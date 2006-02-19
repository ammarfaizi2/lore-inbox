Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWBSFxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWBSFxA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 00:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWBSFxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 00:53:00 -0500
Received: from ms-smtp-01-smtplb.tampabay.rr.com ([65.32.5.131]:37264 "EHLO
	ms-smtp-01.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1750936AbWBSFw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 00:52:59 -0500
Message-ID: <43F807AD.6080008@cfl.rr.com>
Date: Sun, 19 Feb 2006 00:52:45 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Alan Stern <stern@rowland.harvard.edu>, Kyle Moffett <mrmacman_g4@mac.com>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
References: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org> <43F11A9D.5010301@cfl.rr.com> <20060217210445.GR3490@openzaurus.ucw.cz> <43F74C89.1080606@cfl.rr.com> <20060218172908.GD1776@elf.ucw.cz>
In-Reply-To: <20060218172908.GD1776@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>> Provided that you sync before suspending, and there are no open files on 
>> the filesystem, then yes, no data will be lost.  If there are open files 
>> on the fs, such as a half saved document, or a running binary, or say, 
>> the whole root fs, then you're going to loose data and even panic the 
>> kernel, sync or no sync.  From the user perspective, this is
>> unacceptable.
> 
> While with your solution, you do not loose one open file, you loose
> whole filesystem. Which is unacceptable.
> 

Only if the user is foolish enough to modify the media somehow while the 
system is suspended and replace it, which is exactly how non USB disks 
currently behave.

>> Why should the user give up such functionality just because the 
>> connection to the drive thy are using is USB?  Every other type of drive 
>> and interface does not suffer from this problem.
> 
> Because it is okay to unplug usb disk on runtime, while it is not okay
> to unplug ATA disk on runtime. And because alternatives suck even more.
> 

Actually, no, it is not okay to unplug a usb disk at runtime while it is 
mounted.  It never has been and it never will be.  Also we aren't 
talking about runtime, we're talking about while the system is 
suspended, when there is no way for the kernel to know whether or not 
the device was unplugged, since it _allways_ appears to have been 
unplugged.  The alternative in the uncommon case ( where the user 
modifies the media while suspended ) does not suck any worse than it 
currently does on non usb media, and the common case ( where the user 
doesn't ) sucks worse currently with usb than others.

>> Maybe Linux should take a page from windows' playbook here.  I believe 
>> windows handles this scenario with a USB drive the same way it does when 
>> you eject a floppy and reinsert it.  The driver detects that the 
>> media/drive _may_ have changed and so it fails requests from the 
>> filesystem with an error code indicating this.  The filesystem then sets 
>> an override flag so it can send down some reads to verify the media. 
>> Generally the FS reads the super block and compares it with the in 
>> memory one to make sure it appears to be the same media, and if so, 
>> continues normal access without data loss.
> 
> Feel free to implement that.
> 								Pavel
> 

