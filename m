Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWBSQf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWBSQf5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 11:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWBSQf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 11:35:57 -0500
Received: from ms-smtp-03-smtplb.tampabay.rr.com ([65.32.5.133]:46038 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S932079AbWBSQf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 11:35:56 -0500
Message-ID: <43F89E57.9010506@cfl.rr.com>
Date: Sun, 19 Feb 2006 11:35:35 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Alan Stern <stern@rowland.harvard.edu>, Kyle Moffett <mrmacman_g4@mac.com>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
References: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org> <43F11A9D.5010301@cfl.rr.com> <20060217210445.GR3490@openzaurus.ucw.cz> <43F74C89.1080606@cfl.rr.com> <20060218172908.GD1776@elf.ucw.cz> <43F807AD.6080008@cfl.rr.com> <20060219090234.GB3235@elf.ucw.cz>
In-Reply-To: <20060219090234.GB3235@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> "Foolish enough"? Multiple users told you that they consider that use
> case okay for hotpluggable drives.
> 

They are confused.  It has never been, is not, and never will be okay to 
disconnect a drive while it is mounted.  It is simply an easier mistake 
to make with USB.  Easy or not, it is still a mistake.

This user error may be rather common, but as long as you sacrifice other 
functionality to prevent this user error from being particularly 
irritating to users, they will not learn and will continue to make this 
mistake.  Let them be bitten by it once or twice, and they will learn 
they need to properly unmount before yanking.

> 
> Ever heard about "journalling"?
> 

Yes, it makes it faster to recover the filesystem to a consistent state 
after a crash.  It does NOT make it okay to disconnect the drive 
willy-nilly, and does not prevent data loss.

> 
> If it is okay during runtime, it should be okay while suspended. Don't
> expect users to know about power on USB buses. You may call any system
> that does not support standby power on USB broken if you wish... 
> 

It is only okay to disconnect the drive at any time, running or 
suspended, after you unmount it.  Fail to do that and you're asking for 
trouble.

> 
> "Does not such any worse than non-usb" does not cut it here. USB disks
> are too easy to unplug/replug.
> 
> Anyway, your mail came without a patch, again. That's useless; if you
> implement layer above floppies/usb sticks that can recognize same
> disk, maybe we can talk about that.


That's exactly what I've been talking about.  You can add some logic 
that can hopefully notice if the user has modified the volume, but those 
tests need not be 100% foolproof in order to assume that the user did 
not actually modify the volume while suspended.

