Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWBRQeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWBRQeq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWBRQeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:34:46 -0500
Received: from ms-smtp-03-smtplb.tampabay.rr.com ([65.32.5.133]:33169 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S932069AbWBRQep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:34:45 -0500
Message-ID: <43F74C89.1080606@cfl.rr.com>
Date: Sat, 18 Feb 2006 11:34:17 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Alan Stern <stern@rowland.harvard.edu>, Kyle Moffett <mrmacman_g4@mac.com>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
References: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org> <43F11A9D.5010301@cfl.rr.com> <20060217210445.GR3490@openzaurus.ucw.cz>
In-Reply-To: <20060217210445.GR3490@openzaurus.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Must?! Are you Linus or what?
> 

Non sequitur.

> 
> You are missing this. In 1st case, no data is actually lost, because of
> sync in suspend code;
> while second case is "goodbye, filesystem".

Provided that you sync before suspending, and there are no open files on 
the filesystem, then yes, no data will be lost.  If there are open files 
on the fs, such as a half saved document, or a running binary, or say, 
the whole root fs, then you're going to loose data and even panic the 
kernel, sync or no sync.  From the user perspective, this is unacceptable.


Why should the user give up such functionality just because the 
connection to the drive thy are using is USB?  Every other type of drive 
and interface does not suffer from this problem.

Maybe Linux should take a page from windows' playbook here.  I believe 
windows handles this scenario with a USB drive the same way it does when 
you eject a floppy and reinsert it.  The driver detects that the 
media/drive _may_ have changed and so it fails requests from the 
filesystem with an error code indicating this.  The filesystem then sets 
an override flag so it can send down some reads to verify the media. 
Generally the FS reads the super block and compares it with the in 
memory one to make sure it appears to be the same media, and if so, 
continues normal access without data loss.

