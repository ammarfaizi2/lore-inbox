Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263060AbUJ1Nce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbUJ1Nce (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 09:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263061AbUJ1Nce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 09:32:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26071 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263060AbUJ1NcD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 09:32:03 -0400
Date: Thu, 28 Oct 2004 08:51:08 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>
Cc: linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com, nathans@sgi.com
Subject: Re: best linux kernel with memory management
Message-ID: <20041028105108.GB5741@logos.cnet>
References: <412C87F3.2030602@ribosome.natur.cuni.cz> <20040825114005.GB13285@logos.cnet> <412C94F5.4010902@ribosome.natur.cuni.cz> <20040825120450.GA22509@logos.cnet> <412C9D9C.6060703@ribosome.natur.cuni.cz> <20040827121905.GG32707@logos.cnet> <417F6258.7010209@ribosome.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417F6258.7010209@ribosome.natur.cuni.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 10:54:48AM +0200, Martin MOKREJ? wrote:
> Hi,
>  I have hit again memory problem on the same host with 2.4.28-pre3.
> I went to test raid5 filesystem and wanted to evaluate speed
> of different filesystems while studying different combinations
> of their mkfs options or mount options. I did test reiserfs3,
> ext3, xfs, ext2.
> 
>   With a subset of xfs test I run on the server out of memory,
> reproducibly. Those are tests on a filesystem which was created
> with "mkfs.xfs -f -b log=9 -d sunit=64,swidth=64 /dev/sdb2"
> and other sizes of swidth parameter. Omitting those parameters
> makes no trouble and tests finish properly.
> 
>  I have noticed that maxfiles was reached and also the 
> 0 allocation failed messages.
> I have /proc/sys/fs/max-files set to 655360.
> The filesystem is created on a 1Terabyte large raid5. I guess xfs
> allocates to much space for it's buffers.
> 
>  The problem is triggered by starting:
> "bonnie++ -n 1 -s 12G -d /scratch -u apache -q"
> in few minutes system runs out of memory/files.
> 
>  Originally, I did not have a swap on this host, but even
> doing mkswap and swapon of a spare 12GB partition doesn't help,
> although from I forgot if I have again the 0 allocation pages
> message. At least the maxfiles problem was repeated.
> 
>  Doing same test on a 5GB large partion on my home computer
> I couldn't reproduce the problem, but from vmstat I gather
> that the system does not loose any memory for buffers.
> 
>  I'll kick out SMP and HIGHMEM on that problematic host and retry,
> but I don't understand if that would be even expected to help.
> Well, maybe HIGHMEM, but why SMP would do a difference?
> 
>  I can't think of a reason same machine would perform
> well with many other mkfs.xfs switches except those two above.
> Therefore, I don't believe it's a problem with memory management.
> I suspect a problem in xfs memory usage.
> 
>  Any ideas what might be wrong? I can attach serial console and
> gather some messages if some is interrested in. In principle,
> I can turn on either memory or xfs debugging.

Its really looks XFS specific - have you sent this to the XFS people?

>  Are there any known bugs in memory management or xfs on 2.4.28-pre3?
> I'd like to stick to this version to be able to evaluate the
> performance results. Thanks for any help.
> Please Cc: me in replies.
> Martin
> 
> Marcelo Tosatti wrote:
> >On Wed, Aug 25, 2004 at 04:09:32PM +0200, Martin MOKREJ? wrote:
> >
> >>Hi Marcelo,
> >>
> >>Marcelo Tosatti wrote:
> >>
> >>>On Wed, Aug 25, 2004 at 03:32:37PM +0200, Martin MOKREJ? wrote:
> >>>
> >>>
> >>>>Marcelo Tosatti wrote:
> >>>>
> >>>>
> >>>>>Hi Martin!
> >>>>>
> >>>>>On Wed, Aug 25, 2004 at 02:37:07PM +0200, Martin MOKREJ? wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>>>Hi Marcelo.
> >>>>>>I have a huge server with 6GB RAM and 1 TB raid5 array on aic7xxx 
> >>>>>>using XFS. The xfs seems to eat a lot of memory, so I'm getting 
> >>>>>>processes killed. That's bad. Which kernel would you recommend? I 
> >>>>>>have problems with 2.6.8-rc1.
> >>>>>
> >>>>>
> >>>>>Can you show me the output from dmesg while you see the tasks getting 
> >>>>>killed?
> >>>>
> >>>>Umm, the dmesg output is the one you saw below. I could have attached 
> >>>>/var/log/messages or kern.log , yes. Will do. The machine did not 
> >>>>reboot properly, grrr. It has cost 30 000 Euro and no single linux 
> >>>>kernel worked fine. Also 2.4.25 had problems which was on Gentoo 
> >>>>install CDROM. I don't remember exact their exact revisions, but I 
> >>>>shouldn't have used xfs also for /. I thought better xfs everywhere 
> >>>>than combined with reiserfs. Of course, /boot is ext3.
> >>>
> >>>
> >>>So there was a problem with installation of v2.4.25? I'm pretty sure
> >>
> >>Yes, the trick was to never insmod aic7xxx and only install basic stuff 
> >>on teh internal raid using gdth controller. After mkfs.xfs on internal 
> >>disks I had to reboot often. I was a month away so don't remember 
> >>details, but I'm sure I tried even 2.4.27-rcXX or whatever was out at 
> >>that time. Tommorow I can give you list of all those kernels. It seemed 
> >>to me that that 2.6.8-rc1 is without problems, but as I found after 
> >>vacation ...
> >>
> >>
> >>>you can boot a v2.4 kernel on it now if you wish. It has to work.
> >>
> >>Boot I can, I can work for a while in multiuser, but after lot's of IO on 
> >>XFS on aic7xxx controller I start to have problems.
> >
> >
> >Odd. You dont remember the errors in detail?
> >
> >
> >>>>>The VM prints out debugging information when that happens. 
> >>>>>
> >>>>>How deep into swap are you when the VM starts killing tasks?
> >>>>
> >>>>No swap defined at all, if I remember right. Can't say, but machine 
> >>>>totally unloaded.
> >>>
> >>>
> >>>You should add some swap also, really.
> >>
> >>I think I have prepared swap on that aic7xxx RAID, not to stress internal 
> >>controller.
> >>
> >>
> >>>>>Whats the output of /proc/slabinfo just before the VM starts killing 
> >>>>>tasks?
> >>>>>
> >>>>>XFS is very hungry memory user, but you have _a lot_ of memory, there 
> >>>>>must
> >>>>>be some freeable cache around.
> >>>>
> >>>>I aggree.
> >>>>
> >>>>
> >>>>
> >>>>>Well, before gathering this data please try 2.6.8-final.
> >>>>
> >>>>You mean 2.6.8.1? I tried yesterday on another machine, and had to turn 
> >>>>off acpi. :(
> >>>
> >>>
> >>>You need ACPI to the box to work properly?
> >>
> >>No, but that crash resulted in immediate lockup of kernel, it did not 
> >>crash, but acpi sent out some error messages and blocked system. I want 
> >>acpi for better interrupt handling/balancing. But that is another 
> >>machine. On this raid host I can stay without it for a while, but good 
> >>powersaving/cpu temp. saving is a must in a long term. Should be used for 
> >>computations (dual Xeon 3 GHz).
> >>
> >>
> >>
> >>>>>I'm willing to help! :)
> >>>>
> >>>>Great, I'll get an acces to that machine tommorow. Untill that, tell me 
> >>>>if I should turn on/off some kernel debug option ...
> >>>
> >>>
> >>>Not really, just enable swap and run 2.6.8.1.
> >>
> >>But why do I need swap at all? What's the difference between 3 GB RAM + 3 
> >>GB swap setup to 6 GB RAM only?
> >
> >
> >When the kernel swaps it knows you are out of memory (it has already thrown
> >away pagecache and inode/dentries caches). 
> >
> >Swap is important in this case so the kernel can push some anonymous 
> >memory to swap, in case you are overloaded with such.
> >
> >
> >>>If you have problems with such setup, we have a problem which must be 
> >>>fixed.
> >>>
> >>>I bet v2.4 run flawlessly, but v2.6 is much faster.
> >>
> >>
> >>During installation of gentoo linux, user has to unpack 2 .tar.gz files, 
> >>about 15 MB and teh other is bigger. Believe me, after mkfs.xfs I had to 
> >>reboot first, then unpack the file, reboot, continue installation. I 
> >>think with the other file (bigger?) I did not make it a lot further in 
> >>the install process. I remember what has worked was to unpack on another 
> >>server and use rsync(1) to copy the tree. Yes, that bad! Feel free to 
> >>test www.gentoo.org's install procedure and try yourself. If I would know 
> >>how to easily rip the install-cd kernel and replace it with my own, I'd 
> >>play more. But basically, mkfs.xfs and then "bzip2 -dc *.tar.bz2 | tar 
> >>xvf -)" should do the trick on every huge filesystem.
> >
> >
> >Hum, very odd.
> >
> >
