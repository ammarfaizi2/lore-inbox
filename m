Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbVH3Pwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVH3Pwj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 11:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbVH3Pwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 11:52:39 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:15383 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932184AbVH3Pwj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 11:52:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lQgyCKahxJFUVg88g4le918WnWWEfxlqnRaYu1BiMa6cQB2FcEYOY6akuPFc20TrYHAx7wUtvBycqQ7csG5I1lPxrVB/vFFB5OVlKAZebJWKUZm42dCZP4Ksw8fGt6tZidYfMQPB8HbrWAjvBzWQ0izzyE6xmeg1loJj2g6w43I=
Message-ID: <87941b4c05083008523cddbb2a@mail.gmail.com>
Date: Tue, 30 Aug 2005 09:52:36 -0600
From: Greg Felix <greg.felix@gmail.com>
To: Oliver Tennert <O.Tennert@science-computing.de>
Subject: Re: IDE HPA
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200508300859.19701.tennert@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <87941b4c05082913101e15ddda@mail.gmail.com>
	 <200508300859.19701.tennert@science-computing.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel list,

A while ago there was some discussion on the list regarding the
behavior of the kernel in regards to its unconditional disabling of
host protected areas of hard drives.  I ran into a problem this causes
with some RAID controllers.  I've been discussing the problem with
both the ata-raid mailing list and Oliver.  I feel we should copy the
kernel list because we don't think the current behavior is the
desirable one.

Below is some discussion Oliver and I have had about it.

> > Sorry for taking up your time. I saw your emails recently to the Linux
> > kernel mailing list concerning IDE host protected areas.  You were
> > asking why they are unconditionally disabled.  Did anyone ever give
> > you a good response to your question?
> >
> 
> Hi Greg,
> 
> Alan Cox answered, but he focussed entirely on the point that in his opinion,
> the main reason for using HPAs is something like backward-compatibility of
> the drive with old BIOSses that have problems with large disks.
> 
> But to be honest, I have never ever heard about that being a motivation to use
> an HPA. And as far as I know, that was not the reason for introducing an HPA
> anyway.
> 
> As far as I know, some HW vendors store some diagnostic tools in an HPA.
> 
> > I have found a bug where my BIOS is storing some RAID metadata near
> > the end of a disk.  The problem i run into is that the end of the disk
> > is 20MB off when Linux counts the HPA.
> >
> 
> So you are sure that your RAID controller uses an HPA to store the metadata? I
> am asking because some RAID controllers simply cut away a moderate region
> from the end of the disks and present the OS with a smaller disk, which is
> but a virtual one. In that case, no HPA is used. It is rather like the MD
> driver works.

My RAID controller isn't using an HPA to store metadata.  It's simply
recognizing that there is an HPA and reading its 63 sector backwards
offset starting at totalSectors-sizeOfHPA.

> But of course, the Linux kernel simply shows whether an HPA is used or not.

Right.  I get the output at bootup time.  It reads that the HPA is
20MB.  Which is exactly the size of how far off the metadata is in
Linux (once the HPA is disabled).

> > Have you heard of any kernel parameters that disable the HPA disabling?
> >
> 
> There is no runtime variable, the code is run unconditionally, unfortunately.

I've found where the code is and it'd be a simple hack to fix it and
recompile, but I'm concerned that other people will run into this at
some point.  I think we or the people who make decisions ought to
revisit the disabling of HPAs idea.

> > Thanks for your time,
> > Greg Felix
> 
> Not at all! Should we CC the mail the kernel mailing list?

I think we should.  In fact, I will with this email.

> Best regards
> 
> Oliver
