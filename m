Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423044AbWBOIv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423044AbWBOIv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 03:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423046AbWBOIv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 03:51:58 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:6353 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423044AbWBOIv5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 03:51:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tGjj9cHAtjpWdN5MqeJLuTeTG0q8VMOpRCehtHqxqn76ONky4TpjrWM+60C4wwHDlM4jYqjCXoStowBcPKsgLPPyo2kv5do/nHI1dmhiKQdqSSrb6ktwoVrum5ZL1QJObV/yVB36tHxyMw9vcm5rF/2mb6t1Uutjbbv1bm1A9y0=
Message-ID: <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com>
Date: Wed, 15 Feb 2006 09:51:56 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Seewer Philippe <philippe.seewer@bfh.ch>
Subject: Re: RFC: disk geometry via sysfs
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <43F2E8BA.90001@bfh.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com>
	 <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com>
	 <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com>
	 <43F2E8BA.90001@bfh.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/06, Seewer Philippe <philippe.seewer@bfh.ch> wrote:
>
> Phillip Susi wrote:
> > Seewer Philippe wrote:
> >
> >>
> >> IDE tries to return the actual hardware geometry. Most other drivers
> >> implement a "fake". Or try to guess the geometry from the MBR...
> >>
> >
> > But there is no "actual hardware geometry".  IDE disks can report a
> > geometry, but that is no more real than any other made up geometry.  If
> > you take the geometry that the disk itself reports and write that to the
> > MBR, then software that actually uses the geometry ( i.e. non LBA boot
> > loaders ) will fail because it is not the geometry that the bios uses.
> >
> > The only remaining purpose to geometry values that I see is to store in
> > the MBR for non LBA boot loaders to use.  Since they must have the
> > values the bios uses, then you need to get the values from the bios when
> > creating such an MBR.
> >
> >> My personal answer is here: Because there are so many tools around which
> >> use the kernel values, that it is easier to overwrite the kernel than
> >> patch all other software... (i know, i know...)
> >
> >
> > The only tools that I am aware of are boot loaders and disk
> > partitioners, and these tools do not need the geometry, they just try to
> > get it to maintain compatibility with ancient systems.  As such, it is
> > long past time for them to no longer require this information.
> >
> >>
> >> And additionally: When partitioning its sometimes necessary or safer to
> >> write a whole new mbr (dd if=... of=... ; parted mklabel msdos). When
> >> dd'ing the mbr goes away. And some drivers return geometry based on the
> >> mbr...... So overwriting these values might come handy.
> >>
> >
> > But what would you overwrite them with?  The only values that have any
> > actual use are the ones from the bios.  If you get the values from the
> > bios, it makes no sense to change them later.
> >
> Hi Phillip
>
> I'd like to close this discussion if possible.
>
> I think we both know that disk geometry is a fiction and except for a
> few "older" devices which still need support, Linux couldn't care less
> about it (and in an ideal world this would include myself).
>
> On the other hand, at least in the x86 world, we must live with the fact
> that there are other os around, which, as you so aptly put, aren't sane.
> In order to work with them and if necessary to fix things, geometry
> information is necessary. One part is the bios geometry, available
> through edd or other means. The other part is the geometry the kernel
> exports (whatever sane values it contains or where they come from).
>
> Both are necessary for debugging and fixing. And sometimes it actually
> makes sense to overwrite the kernel with values that are "compatible".
> Whether gleaned from the bios via edd or computed by hand does not
> matter as long as the user has to it by himself. I've given a few
> examples for this, others can be found by googling (For example the ide
> disk geometry rewrite for http://unattended.sourceforge.net).
>
> I completely agree with all that the kernel should never try to report
> bios geometry for a disk unless absolutely necessary and should not
> attempt to fix things automagically.
>
> But, as long as the Linux kernel does something with disk geometry, and
> this could mean just returning some bogus values, it makes sense to
> export these values read/write in sysfs. Because we all know, sysfs is
> much easier to handle than say for example ioctls.

This made me thinking - if all the kernel does is returning some bogus
values and we need to fix applications to use sysfs interface why not
instead just fix applications to not use ioctl interface?

Bartlomiej
