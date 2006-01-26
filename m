Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWAZMPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWAZMPB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 07:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWAZMPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 07:15:01 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:31732 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751337AbWAZMPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 07:15:00 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 26 Jan 2006 13:13:50 +0100
To: jerome.lacoste@gmail.com, axboe@suse.de
Cc: schilling@fokus.fraunhofer.de, rlrevell@joe-job.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D8BCFE.nailE1C116RR9@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
 <20060125144543.GY4212@suse.de>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de>
 <5a2cf1f60601251401h2cced00ele307636e748b9a7b@mail.gmail.com>
In-Reply-To: <5a2cf1f60601251401h2cced00ele307636e748b9a7b@mail.gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste <jerome.lacoste@gmail.com> wrote:


> Joerg seems to be concerned by 2 things:
> - the portability of his application accross various platforms
> - provide an end-to-end application for writing CDs from both the
> command line and to various 3rd party front ends.

> Providing a cross platform way to reference the devices seems to help
> him achieve that goal.

Correct.



> Linux developers seem to see the world in a different way. Their main
> requirements:
> - compliance with the linux way of doing things

Which is unfortunately (in contrary to what cdrecord does) a moving target.

> - ultimately a front end should hide all the dirty details. That
> doesn't mean a command line version has to hide them as well, nor that
> cdrecord should be the interface to ask things the operating system
> can provide

The best way of making a GUI portable is by making the underlying command line 
application portable and using the same CLI for every OS.


> So it looks like:
> - from a cdrecord point ov view, Linux is broken.
> - from a Linux developers point of view, cdrecord is doing too much
> and forces things up.

BTW: There are still many people who run Linux-2.2 and many people told me that
they will probably never upgrade from 2.4 to 2.6.

On Linux-2.4, cdrecord's abstraction is the only way to hide the security 
relevent non-stable /dev/sg* <-> device relation.


> <very naively>
>
> As a developper with absolutely no competence in this area, I wonder
> something: I don't see why the way to refer to a device affects the
> ability to perform the functionality (write to it).
>
> Isn't it possible to reorganize the code in such a way that the
> burning part can be independent of the way the devices are referred
> to?

This is what cdrecord does!

Cdrecord uses the OS and transport independent libscg/

> I downloaded the code and quickly looked at it. If I am looking at the
> right version, it seems that the cdrecord code that relates to both cd
> burning + the Linux specific part is not that big (and very readable,
> thanks Joerg). So I really don't understand why this issue doesn't get
> fixed.
>
> </very naively>

I was never talking about cdrecord in special here but rather talkign about
libscg which does not only deal with CD/DVD-writers but with any (even unknown) 
kind of SCSI devices.

The real problen with many people on this list is that they ague in a way that 
might be correct in case that cdrecord would not use a anstracting library as 
libscg. In that case, some of the arguments may ne right....but we need to talk 
abut a generic SCSI transport - independent from the SCSI device type and from 
the SCSI transport that is used for that device.


> cdrecord, how important is Linux to you?

Linux was important between 1996 and ~ 2000. In that time, I got a lot of 
really exciting and valuable feedback from various kernel developers and 
in that time, Linux was the only way to use CD/DVD-writers with strange exotic 
transport interfaces.

But the times are changing. During the past few years, some Linux kernel 
developers started a rather aggressive campaign against crecord and Linux did 
become less usable for CD/DVD writing than it has been before.

Meanwhile other OS did step into the right direction. FreeBSD and Solaris added 
support for other SCSI transports and I now recommend to use FreeBSd or Solaris 
because things are a lot smoother on these OS.

As an example: USB on Solaris is a lot more stable than on Linux. Timeout 
problems to not appear, I have been able to connect and mount my Nikon D70
out of the box on Solaris 9 (from November 2002) while Linux does not even see 
the camera on USB. Solaris has a device cache for removable media and offers 
stable /dev/* entries and stable major/minor numbers for hot plugged USB and 
other devices while Linux happyli creates new device entries for every reconnect. 

Discussions with FreeBSD and Solaris people are always friutful because these 
discussions stay technical. Solaris did fix all remaining issues with CD/DVD 
writing during the past 2 years and Solaris now is the free OS where CD/DVD 
writing works most smoothly.

It seems that cdrecord does not need Linux anymore. Does Linux need cdrecord?

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
