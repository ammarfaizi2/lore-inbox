Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbUK0G6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbUK0G6C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 01:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbUKZTHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:07:44 -0500
Received: from zeus.kernel.org ([204.152.189.113]:25022 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261238AbUKZTGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:06:13 -0500
Date: Thu, 25 Nov 2004 09:04:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Thomas Fritzsche <tf@noto.de>
Cc: linux-kernel@vger.kernel.org, david@2gen.com
Subject: Re: Re: Is controlling DVD speeds via SET_STREAMING supported?
Message-ID: <20041125080451.GE10233@suse.de>
References: <33356.192.168.0.2.1101334593.squirrel@192.168.0.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33356.192.168.0.2.1101334593.squirrel@192.168.0.10>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24 2004, Thomas Fritzsche wrote:
>  /* SET STREAMING command */
>   cgc.cmd[0] = 0xb6;
>  /* 28 byte parameter list length */
>   cgc.cmd[10] = 28;
> 
>   cgc.sense = &sense;
>   cgc.buffer = buffer;
>   cgc.buflen = sizeof(buffer);
>   cgc.data_direction = CGC_DATA_WRITE;
> 
>   buffer[8] = 0xff;
>   buffer[9] = 0xff;
>   buffer[10] = 0xff;
>   buffer[11] = 0xff;
> 
>   buffer[15] = 177*speed;
>   buffer[18] = 0x03;
>   buffer[19] = 0xE8;

I should have read this more closely... You need to fill the speed
fields correctly:

	unsigned long read_size = 177 * speed;

	buffer[12] = (read_size >> 24) & 0xff;
	buffer[13] = (read_size >> 16) & 0xff;
	buffer[14] = (read_size >>  8) & 0xff;
	buffer[15] = read_size & 0xff;

Ditto for write size.

-- 
Jens Axboe

