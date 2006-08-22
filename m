Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWHVUsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWHVUsT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 16:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWHVUsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 16:48:19 -0400
Received: from 1wt.eu ([62.212.114.60]:12049 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750701AbWHVUsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 16:48:18 -0400
Date: Tue, 22 Aug 2006 22:34:36 +0200
From: Willy Tarreau <w@1wt.eu>
To: Ernie Petrides <petrides@redhat.com>
Cc: Solar Designer <solar@openwall.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: printk()s of user-supplied strings
Message-ID: <20060822203436.GB12519@1wt.eu>
References: <20060822030755.GB830@openwall.com> <200608222023.k7MKNHpH018036@pasta.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608222023.k7MKNHpH018036@pasta.boston.redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ernie,

On Tue, Aug 22, 2006 at 04:23:17PM -0400, Ernie Petrides wrote:
> On Tuesday, 22-Aug-2006 at 7:7 +0400, Solar Designer wrote:
> 
> > On Mon, Aug 21, 2006 at 07:36:01PM -0400, Ernie Petrides wrote:
> > > -			printk(KERN_ERR "Unable to load interpreter %.128s\n",
> > > -				elf_interpreter);
> >
> > I'd rather have this message rate-limited, not dropped completely.
> 
> I consider any printk() that can be arbitrarily triggered by an
> unprivileged user to be inappropriate, rate-limited or not.  I
> recommend that it be removed entirely.

Well, we had the same problem with the setuid() call where I proposed a
printk(), and Alan proposed to ratelimit it to prevent local user from
using it to flush the logs for instance, which I found clearly appropriate,
reason why I've backported 2.6's printk_ratelimit() function, citing the
two other printk() in binfmt_elf as good candidates.

> > Another long-time concern that I had is that we've got some printk()s
> > of user-supplied string data.  What about embedded linefeeds - can this
> > be used to produce fake kernel messages with arbitrary log level (syslog
> > priority)?  It certainly seems so.
> >
> > Also, there are terminal controls...
> 
> These are valid concerns.  Allowing the kernel to print user-fabricated
> strings is a terrible idea.

I agree. While this printk might have been there for years now, I really
think that it should be fixed for sensible chars, but then restored and
ratelimited to inform the admin that something abnormal is going on.

2.4.33.2 is out with the SCTP fix and this patch now, but with the printk
commented out.

Cheers,
Willy

