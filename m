Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030484AbWF1ImR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030484AbWF1ImR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 04:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030486AbWF1ImR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 04:42:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60390 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030484AbWF1ImQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 04:42:16 -0400
Subject: Re: [PATCH 00/20] Mount writer count and read-only bind mounts (v3)
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, viro@ftp.linux.org.uk, serue@us.ibm.com
In-Reply-To: <20060627191727.406b0e18.akpm@osdl.org>
References: <20060627221436.77CCB048@localhost.localdomain>
	 <20060627183822.667d9d49.akpm@osdl.org>
	 <1151459436.24103.70.camel@localhost.localdomain>
	 <20060627191727.406b0e18.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 10:42:07 +0200
Message-Id: <1151484127.3153.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 19:17 -0700, Andrew Morton wrote:
> On Tue, 27 Jun 2006 18:50:36 -0700
> Dave Hansen <haveblue@us.ibm.com> wrote:
> 
> > > > Since the last revision, the locking in faccessat() and
> > > > mnt_is_readonly() has been changed to fix a race which might have
> > > > caused a false-negative mount-is-readonly return when faccessat()
> > > > is called while another two processes are racing to make a mount
> > > > readonly.
> > > > 
> > > umm, what's it all for?
> > 
> > Mostly for vserver, for now.  They allow a filesystem to be r/w, but
> > have r/o views into it.  This is really handy so that every vserver can
> > use a common install but still allow the administrator to update it.
> 
> OK.  That makes it one of those features which stays in -mm until we work
> out what we're going to do about containers/vserver/etc.
> 
> Unless there's something else which needs it?

in a previous life we repeatedly had customers who really wanted this.
It's more than just containers; it's chroots too (arguably that's
containers as well but a lot more common deployed today) but also things
where the customer wanted to mount a part of a network mount as /usr,
but read only just to be sure....


