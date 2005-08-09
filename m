Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbVHIHsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbVHIHsA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 03:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVHIHsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 03:48:00 -0400
Received: from sccrmhc11.comcast.net ([63.240.76.21]:37512 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932457AbVHIHsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 03:48:00 -0400
Message-ID: <42F85FAE.4000504@comcast.net>
Date: Tue, 09 Aug 2005 00:47:58 -0700
From: "David C. Young" <dcy665@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: jeffw@cyte.com
Subject: Re: amd64 cdrom access locks system
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is in response to Jeff Wiegley () cyte ! com problem with amd64 and 
ide cdrom.  I tried to contact him directly but the email bounced.  I 
apologize in advance for using kernel list bandwidth to address this.

Jeff,

I have a amd64 running on a Asus board (K8V SE Deluxe) and I have been 
having problems similar to your cdrom lockups.  The board has on-board 
IDE/ATA and SATA.  I am only using two SATA drives and one DVD/CD burner 
on the secondary IDE/ATA connector.

The system lockups occurred with kde (all the time) and gnome 
(occasionally).  I killed the haldaemon and went through 2.6.12.[0-3] 
but I would access, or the haldaemon would access, the cdrom and 
/dev/hdc would lock up, the system would slow down and occasionally lock 
up (in particular during cd-burning).  I got logs full of drive busy, 
drive opcode unknown and drive not ready followed by ATAPI resets.  The 
situation was better but not fixed completely when I disabled the haldaemon.

I solved my cdrom/ide problem by building a custom kernel.  I haven't 
gone back to check all the permutations but I continued having problems 
until I disabled scsi cdrom support.  I left generic scsi and disk 
support on but once the scsi cdrom support was eliminated the slowdowns 
and/or lockups went away.  I did get one error message from trying to 
access past the end of the drive when I tried to mount a blank cd.  Past 
that, my logs are clean of /dev/hdc problems.

It seems to me that the ide-ata works fine in burning mode and the 
generic scsi cdrom support just confuses the issue.  That is only my 
opinion and I don't profess to be a kernel hack.  I do burn iso images 
fairly often and my command is:
	cdrecord dev=/dev/hdc fs=16MB -eject <filename>

Also, I make sure the cpu is running at full speed instead of power 
saving mode and I run as root for the actual burning.

Hope this helps,

David
