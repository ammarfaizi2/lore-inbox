Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbSKRVo7>; Mon, 18 Nov 2002 16:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbSKRVo7>; Mon, 18 Nov 2002 16:44:59 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:43747 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S264925AbSKRVo6>;
	Mon, 18 Nov 2002 16:44:58 -0500
Date: Mon, 18 Nov 2002 22:51:58 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: "Filipau, Ihar" <ifilipau@sussdd.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: useless image of hdd: how to make it useful?
Message-ID: <20021118215158.GA2183@win.tue.nl>
References: <7A5D4FEED80CD61192F2001083FC1CF906505A@CHARLY>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7A5D4FEED80CD61192F2001083FC1CF906505A@CHARLY>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 11:08:10AM +0100, Filipau, Ihar wrote:

> 			# dd if=/dev/hdc of=/root/hdc_img
> 
> 	I do not know the way to mount partition table!
> 	it's possible with loop device to mount partition - but how
>       to mount whole hddd (with its own partition table) to have
>       access to single partition inside???

loop knows about an offset:

First find where your partitions are:

% sfdisk -l -uS hdc_img
Warning: hdc_img is not a block device
Disk hdc_img: cannot get size
Disk hdc_img: cannot get geometry

Disk hdc_img: 0 cylinders, 0 heads, 0 sectors/track

Units = sectors of 512 bytes, counting from 0

   Device Boot    Start       End   #sectors  Id  System
 hdc_img1            63    112454     112392  83  Linux
 hdc_img2        112455    401624     289170  82  Linux swap
 hdc_img3        401625  33736499   33334875   5  Extended
 ...

OK, let us mount this first one, at an offset of 63 sectors.

% bc
63*512
32256

# mount hdc_img /mnt -o loop,offset=32256
#



