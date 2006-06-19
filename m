Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWFSPOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWFSPOT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWFSPOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:14:19 -0400
Received: from mail.mazunetworks.com ([4.19.249.111]:22739 "EHLO
	mail.mazunetworks.com") by vger.kernel.org with ESMTP
	id S1750935AbWFSPOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:14:19 -0400
Message-ID: <4496BF65.30108@mazunetworks.com>
Date: Mon, 19 Jun 2006 11:14:45 -0400
From: Jeff Gold <jgold@mazunetworks.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>
CC: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org
Subject: Re: Serial Console and Slow SCSI Disk Access?
References: <448DDC7F.4030308@mazunetworks.com> <448DDF1D.5020108@rtr.ca> <448DE4F1.9000407@mazunetworks.com> <4496492A.1030907@aitel.hist.no>
In-Reply-To: <4496492A.1030907@aitel.hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> With nothing attached, any write to the serial device might go
> through a lengthy timeout because of flow control.  [...] But I can't
> see why it'd make scsi disks slower. The scsi host adapter 
> initialization writes some messages of course, but there should be no
> more console accesses during a hdparm test run.

This makes sense to me.  When I attach a serial cable and use that to 
login (I've got agetty running), hdparm produces no console messages 
that I can see using minicom.  Still, the disk throughput is around 1.5 
MB/sec for some reason.  When I disable the serial console in grub.conf 
and reboot I get over 70 MB/sec again.

A combination of out-of-tree patches (mainly network related but also 
one to disable PM_TIMERS) seem to eliminate the issue even with the 
serial console enabled, at least for the moment.  That means I no longer 
have a problem, but the whole thing is mysterious to me.

                                        Jeff
