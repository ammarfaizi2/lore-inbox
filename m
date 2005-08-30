Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbVH3QQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVH3QQl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbVH3QQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:16:41 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:45983 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932198AbVH3QQk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:16:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N+pAkXfu3rkXM9cTeWJJwQIIZ9zBctfTtHHPgMf/hPJ63sbyl6NZz2pYFuG1U+DGs4D64vz7K8YbRWuj2possQVzM2rg1/v/moT7jMUCnn872nr8WwI7nRgomN8KvEECsTbDd3Qf6wpjbnbqBTtTScd2h2KW56QVfz+FCetYcNk=
Message-ID: <58cb370e0508300916432fc003@mail.gmail.com>
Date: Tue, 30 Aug 2005 18:16:36 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Greg Felix <greg.felix@gmail.com>
Subject: Re: IDE HPA
Cc: Oliver Tennert <O.Tennert@science-computing.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <87941b4c05083008523cddbb2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <87941b4c05082913101e15ddda@mail.gmail.com>
	 <200508300859.19701.tennert@science-computing.de>
	 <87941b4c05083008523cddbb2a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

OK, it seems, there is enough need for bringing back more control over HPA.

HPA shouldn't be disabled by default and new kernel parameter ("hdx=hpa")
should be added for disabling HPA (yep, people with buggy BIOS-es will
have to add this parameter to their kernel command line, sorry).

If somebody wants to go ahead and submit actual patches...
[s]he is welcomed to.

Thanks,
Bartlomiej

On 8/30/05, Greg Felix <greg.felix@gmail.com> wrote:
> Kernel list,
> 
> A while ago there was some discussion on the list regarding the
> behavior of the kernel in regards to its unconditional disabling of
> host protected areas of hard drives.  I ran into a problem this causes
> with some RAID controllers.  I've been discussing the problem with
> both the ata-raid mailing list and Oliver.  I feel we should copy the
> kernel list because we don't think the current behavior is the
> desirable one.
> 
> Below is some discussion Oliver and I have had about it.
> 
> > > Sorry for taking up your time. I saw your emails recently to the Linux
> > > kernel mailing list concerning IDE host protected areas.  You were
> > > asking why they are unconditionally disabled.  Did anyone ever give
> > > you a good response to your question?
> > >
> >
> > Hi Greg,
> >
> > Alan Cox answered, but he focussed entirely on the point that in his opinion,
> > the main reason for using HPAs is something like backward-compatibility of
> > the drive with old BIOSses that have problems with large disks.
> >
> > But to be honest, I have never ever heard about that being a motivation to use
> > an HPA. And as far as I know, that was not the reason for introducing an HPA
> > anyway.
> >
> > As far as I know, some HW vendors store some diagnostic tools in an HPA.
> >
> > > I have found a bug where my BIOS is storing some RAID metadata near
> > > the end of a disk.  The problem i run into is that the end of the disk
> > > is 20MB off when Linux counts the HPA.
> > >
> >
> > So you are sure that your RAID controller uses an HPA to store the metadata? I
> > am asking because some RAID controllers simply cut away a moderate region
> > from the end of the disks and present the OS with a smaller disk, which is
> > but a virtual one. In that case, no HPA is used. It is rather like the MD
> > driver works.
> 
> My RAID controller isn't using an HPA to store metadata.  It's simply
> recognizing that there is an HPA and reading its 63 sector backwards
> offset starting at totalSectors-sizeOfHPA.
> 
> > But of course, the Linux kernel simply shows whether an HPA is used or not.
> 
> Right.  I get the output at bootup time.  It reads that the HPA is
> 20MB.  Which is exactly the size of how far off the metadata is in
> Linux (once the HPA is disabled).
> 
> > > Have you heard of any kernel parameters that disable the HPA disabling?
> > >
> >
> > There is no runtime variable, the code is run unconditionally, unfortunately.
> 
> I've found where the code is and it'd be a simple hack to fix it and
> recompile, but I'm concerned that other people will run into this at
> some point.  I think we or the people who make decisions ought to
> revisit the disabling of HPAs idea.
> 
> > > Thanks for your time,
> > > Greg Felix
> >
> > Not at all! Should we CC the mail the kernel mailing list?
> 
> I think we should.  In fact, I will with this email.
> 
> > Best regards
> >
> > Oliver
