Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282184AbRK1Xqx>; Wed, 28 Nov 2001 18:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282188AbRK1Xqi>; Wed, 28 Nov 2001 18:46:38 -0500
Received: from [212.18.232.186] ([212.18.232.186]:27405 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282184AbRK1XqQ>; Wed, 28 Nov 2001 18:46:16 -0500
Date: Wed, 28 Nov 2001 23:45:05 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "David C. Hansen" <haveblue@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from drivers' release functions
Message-ID: <20011128234505.C2561@flint.arm.linux.org.uk>
In-Reply-To: <E169EFX-0006TA-00@the-village.bc.nu> <3C057410.3090201@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C057410.3090201@us.ibm.com>; from haveblue@us.ibm.com on Wed, Nov 28, 2001 at 03:32:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2001 at 03:32:32PM -0800, David C. Hansen wrote:
> Nothing, because the BKL is not held for all opens anymore.  In most of 
> the cases that we addressed, the BKL was in release _only_, not in open 
> at all.  There were quite a few drivers where we added a spinlock, or 
> used atomic operations to keep open from racing with release.  

All char and block devs are opened with the BKL held - see chrdev_open in
fs/devices.c and do_open in fs/block_dev.c

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

