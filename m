Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262906AbREWADp>; Tue, 22 May 2001 20:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262912AbREWADc>; Tue, 22 May 2001 20:03:32 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:6284 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262910AbREWADW>;
	Tue, 22 May 2001 20:03:22 -0400
Date: Tue, 22 May 2001 20:03:20 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct char_device
In-Reply-To: <UTC200105222333.BAA77751.aeb@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0105221952110.17373-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 May 2001 Andries.Brouwer@cwi.nl wrote:

> I am not sure whether we agree or differ in opinion. I wouldn't mind
> 
> /* pairing for dev_t to bd_op/cd_op */
> struct bc_device {
>         struct list_head        bd_hash;
>         atomic_t                bd_count;
>         dev_t                   bd_dev;
>         atomic_t                bd_openers;
>         union {
> 		struct block_device_operations_and_data *bd_op;
> 		struct char_device_operations_and_data *cd_op;
> 	}
>         struct semaphore        bd_sem;
> };
> 
> typedef struct bc_device *kdev_t;

What for? What part of the kernel needs a device and doesn't know apriory
whether it's block or character one?

> and in an inode
> 
> 	kdev_t dev;
Useless. If you hope that block_device will help to solve rmmod races -
sorry, it won't. Wrong layer.

> 	dev_t rdev;
Reasonable.

