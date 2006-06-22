Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030640AbWFVQb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030640AbWFVQb5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030643AbWFVQb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:31:57 -0400
Received: from main.gmane.org ([80.91.229.2]:33744 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030640AbWFVQb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:31:56 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andrey Melnikoff <temnota+news@kmv.ru>
Subject: Re: Serial Console and Slow SCSI Disk Access?
Date: Thu, 22 Jun 2006 20:18:54 +0400
Message-ID: <egsqm3-0tr.ln1@kenga.kmv.ru>
References: <448DDC7F.4030308@mazunetworks.com> <448DDF1D.5020108@rtr.ca>  <448DE4F1.9000407@mazunetworks.com> <4496492A.1030907@aitel.hist.no>  <4496BF65.30108@mazunetworks.com> <44979F99.1090807@aitel.hist.no> <Pine.LNX.4.63.0606211729360.6305@qynat.qvtvafvgr.pbz>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: kenga.kmv.ru
Cancel-Lock: sha1:W/TaZhS6BjZBBoEp07bSTqk9has=
User-Agent: tin/1.8.2-20060425 ("Shillay") (UNIX) (Linux/2.6.17-rc2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang <dlang@digitalinsight.com> wrote:
> On Tue, 20 Jun 2006, Helge Hafting wrote:

> > Jeff Gold wrote:
> >> Helge Hafting wrote:
> >>> With nothing attached, any write to the serial device might go
> >>> through a lengthy timeout because of flow control.  [...] But I can't
> >>> see why it'd make scsi disks slower. The scsi host adapter initialization 
> >>> writes some messages of course, but there should be no
> >>> more console accesses during a hdparm test run.
> >> 
> >> This makes sense to me.  When I attach a serial cable and use that to login 
> >> (I've got agetty running), hdparm produces no console messages that I can 
> >> see using minicom.  Still, the disk throughput is around 1.5 MB/sec for 
> >> some reason.  When I disable the serial console in grub.conf and reboot I 
> >> get over 70 MB/sec again.
> >> 
> >> A combination of out-of-tree patches (mainly network related but also one 
> >> to disable PM_TIMERS) seem to eliminate the issue even with the serial 
> >> console enabled, at least for the moment.  That means I no longer have a 
> >> problem, but the whole thing is mysterious to me.
> > I can see one possibility, that I didn't think of yesterday.
> > Do the scsi host adapter share its interrupt with the serial line?
> > (Boot a kernel that has the problem, and when scsi is slow, do a
> > cat /proc/interrupts
> > If the scsi and the serial driver share an interrupt, then that is the source
> > of the problem.

[skipp]

> I ran into a similar problem (extremely slow scsi performance), but hadn't 
> reported it as I made a lot of changes at the same time (moved from 2.6.7 to 
> 2.6.12.3 as well as enabling the serial console). but with this report I wanted 
> to chime in with a weak 'me-too'. I haven't rebooted without the serial console 
> yet to confirm this, but I will do so shortly, and try 2.6.17 to see if it has a 
> similar problem or not.

2.6.17.1 here, MB Intel SCB20, aic7899 onboard. aic7xxx compilled in, serial
core compilled in, serial console enabled.
With/without serial sonsole - speed 66.0 Mb/s.

Maybe problem related to MB chipset?


