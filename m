Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161215AbWASO5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161215AbWASO5x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 09:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161221AbWASO5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 09:57:53 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38068 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1161215AbWASO5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 09:57:52 -0500
Date: Thu, 19 Jan 2006 15:57:51 +0100
From: Jan Kara <jack@suse.cz>
To: Roopesh <roopesh@cyberspace.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Synchronization between VFS and special IO requests to a block device.
Message-ID: <20060119145751.GA10185@atrey.karlin.mff.cuni.cz>
References: <20060118110022.GA32663@grex.cyberspace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118110022.GA32663@grex.cyberspace.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> 	I have an SD card, a partition of which is mounted and is accessed
>   only through VFS, and certain sectors out of this partition having
>   some special data which is accessed by the applications only through
>   certain ioctls to the device. 
>   
>   My problem is in synchronizing/serializing these two accesses to the
>   hardware, especially since I dont want a VFS request to be handled 
>   by the driver inbetween two specific ioctls.  I understand that the
> 	strategy routine should be atomic and that it cant wait on a lock or 
> 	sleep.  Any pointers/suggestions/help?
  If your areas are 4KB (size of pages) aligned and you really always
access either through VFS or though ioctl, then you need no
synchronization (VFS does not care about areas accessed through ioctl)
and ioctl does not care about areas accessed by VFS. Or you need to
somehow ensure that some space written by VFS is written before some
ioctl is called?

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
