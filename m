Return-Path: <linux-kernel-owner+w=401wt.eu-S1751891AbXARCHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbXARCHg (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 21:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbXARCHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 21:07:36 -0500
Received: from front2.netvisao.pt ([213.228.128.57]:41678 "HELO
	front2.netvisao.pt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751891AbXARCHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 21:07:35 -0500
From: Ricardo Correia <rcorreia@wizy.org>
To: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: How to flush the disk write cache from userspace
Date: Thu, 18 Jan 2007 01:15:54 +0000
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200701140405.33748.rcorreia@wizy.org> <20070116003854.GE4067@kernel.dk>
In-Reply-To: <20070116003854.GE4067@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701180115.54772.rcorreia@wizy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 January 2007 00:38, you wrote:
> As always with these things, the devil is in the details. It requires
> the device to support a ->prepare_flush() queue hook, and not all
> devices do that. It will work for IDE/SATA/SCSI, though. In some devices
> you don't want/need to do a real disk flush, it depends on the write
> cache settings, battery backing, etc.

Is there any chance that someone could implement this (I don't have the 
skills, unfortunately)? Maybe add a new ioctl() to block devices, so that it 
doesn't break any existing code?

I believe it's a very useful (and relatively simple) feature that increases 
data integrity and reliability for applications that need this functionality.

I think it must be considered that most people have disk write caches enabled 
and are using IDE, SATA or SCSI disks.

I also think there's no point in disabling disks' write caches, since it slows 
writes and decreases disks' lifetime, and because there's a better solution.

Personally, I'm not really interested in specific filesystem behaviour, since 
my application uses block devices directly (it's a filesystem itself). 
Although I think all filesystems should guarantee data integrity in the face 
of fsync() or metadata modifications, even if it costs a little performance.

Thank you.
