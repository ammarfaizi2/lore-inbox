Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUC0VLu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 16:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbUC0VLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 16:11:50 -0500
Received: from bimba.bezeqint.net ([192.115.104.6]:8104 "EHLO
	bimba.bezeqint.net") by vger.kernel.org with ESMTP id S261900AbUC0VLq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 16:11:46 -0500
Date: Sat, 27 Mar 2004 23:11:35 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040327211135.GG2737@luna.mooo.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <1079198671.4446.3.camel@laptop.fenrus.com> <4053624D.6080806@BitWagon.com> <20040313193852.GC12292@devserv.devel.redhat.com>
 <40564A22.5000504@aurema.com> <20040316063331.GB23988@devserv.devel.redhat.com> <40578FDB.9060000@aurema.com> <20040320102241.GK2803@devserv.devel.redhat.com>
	 <405C2AC0.70605@stesmi.com> <20040322223456.GB2549@luna.mooo.com> <405F70F6.5050605@aurema.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405F70F6.5050605@aurema.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 10:04:22AM +1100, Peter Williams wrote:
> Micha Feigin wrote:
> >On Sat, Mar 20, 2004 at 12:28:00PM +0100, Stefan Smietanowski wrote:
> >
> >>>>>there is one. Nothing uses it
> >>>>>(sysconf() provides this info)
> >>>>
> >>>>Seems to me that it would be fairly trivial to modify those programs 
> >>>>(that should use this mechanism but don't) to use it?  So why should 
> >>>>they be allowed to dictate kernel behaviour?
> >>>
> >>>
> >>>quality of implementation; for example shell scripts that want to do
> >>>echo 500 > /proc/sys/foo/bar/something_in_HZ
> >>>...
> >>>or /etc/sysctl.conf or ...
> >>>
> >>
> >>Then write a simple program already. How hard is it to write a program
> >>that does a sysconf() and returns (as ascii of course) just the
> >>value of HZ? Then do some trivial calculation off of that.
> >>
> >>HZ=$(gethz)
> >>
> >>If your 500 was 5 seconds, do
> >>
> >>TIME=$[HZ*5]
> >>echo $TIME > /proc/sys/foo/bar/something_in_HZ
> >>
> >
> >
> >Will this be USER_HZ or kernel HZ?
> >Someone earlier suggested it would be USER_HZ which would make it
> >pointless.
> 
> It has to be whatever enables user space to correctly interpret values 
> sent to user space as "ticks".  That means USER_HZ and it's not useless 
> as it enables USER_HZ to be different and/or change without breaking 
> programs that use values expressed in "ticks".
> 

Unless the kernel is converted to make that conversion possible then it
is useless at the moment since userspace gets USER_HZ and the kernel
proc interface speaks (KERNEL) HZ so userspace really has no idea how
to speak to kernel space with 2.6.

> >
> >
> >>I mean, come on.
> >>
> >>Then you include it in the default distro of choice so that
> >>everybody can use it and there you are.
> >>
> >>If someone doesn't have "gethz" then they can download it.
> >>
> >>// Stefan
> >>
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> -- 
> Dr Peter Williams, Chief Scientist                peterw@aurema.com
> Aurema Pty Limited                                Tel:+61 2 9698 2322
> PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
> 79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com
> 
> 
> +++++++++++++++++++++++++++++++++++++++++++
> This Mail Was Scanned By Mail-seCure System
> at the Tel-Aviv University CC.
> 
