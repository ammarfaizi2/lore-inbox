Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbTIKQWz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbTIKQWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:22:55 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:32992 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261354AbTIKQWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:22:53 -0400
Date: Thu, 11 Sep 2003 18:22:23 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jakub Jelinek <jakub@redhat.com>,
       Dan Aloni <da-x@gmx.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [BK PATCH] One strdup() to rule them all
Message-ID: <20030911162223.GB3989@wohnheim.fh-wedel.de>
References: <20030825161435.GB8961@callisto.yi.org> <20030825122532.J10720@devserv.devel.redhat.com> <20030825170530.GB7097@gtf.org> <20030825194918.A1052@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030825194918.A1052@pclin040.win.tue.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 August 2003 19:49:18 +0200, Andries Brouwer wrote:
> On Mon, Aug 25, 2003 at 01:05:30PM -0400, Jeff Garzik wrote:
> 
> > > > +char *strdup(const char *s)
> > > > +{
> > > > +	char *rv = kmalloc(strlen(s)+1, GFP_KERNEL);
> > > > +	if (rv)
> > > > +		strcpy(rv, s);
> > > > +	return rv;
> > > > +}
> 
> > Unfortunately Linus doesn't like the strdup cleanup, so I don't see this
> > patch going in either :)
> 
> When seeing this my objection was: it introduces something with
> a well-known name that uses GFP_KERNEL, so is not suitable everywhere -
> an invitation to mistakes.

Andries, would you still object this function?

char *strdup(const char *s, int flags)
{
	char *rv = kmalloc(strlen(s)+1, flags);
	if (rv)
		strcpy(rv, s);
	return rv;
}

strdup(foo, GFP_KERNEL) should give most people enough clue to know
what they are doing.

Jörn

-- 
But this is not to say that the main benefit of Linux and other GPL
software is lower-cost. Control is the main benefit--cost is secondary.
-- Bruce Perens
