Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310953AbSDQRVQ>; Wed, 17 Apr 2002 13:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311121AbSDQRVP>; Wed, 17 Apr 2002 13:21:15 -0400
Received: from [195.63.194.11] ([195.63.194.11]:60680 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310953AbSDQRVO>; Wed, 17 Apr 2002 13:21:14 -0400
Message-ID: <3CBDA073.6010700@evision-ventures.com>
Date: Wed, 17 Apr 2002 18:18:59 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 boot enhancements, boot bean counting 8/11
In-Reply-To: <m1elhegt1c.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Linus please apply,
> 
> Rework the actual build/link step for kernel images.  
> - remove the need for objcopy
> - Kill the ROOT_DEV Makefile variable, the implementation
>   was only half correct and there are much better ways
>   to specify your root device than modifying the kernel Makefile.
> - Don't loose information when the executable is built

Coudl you please use sufficiently large fields for kdev_t variables?
This way if we once have bigger device id spaces one will not have
to mess with the boot code again.
Thank you.


> +
> +struct boot_params {
> +	uint8_t  reserved1[0x1f1];		/* 0x000 */
> +	uint8_t  setup_sects;			/* 0x1f1 */
> +	uint16_t mount_root_rdonly;		/* 0x1f2 */
> +	uint16_t syssize;			/* 0x1f4 */
> +	uint16_t swapdev;			/* 0x1f6 */
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
this should be uint32_t

> +	uint16_t ramdisk_flags;			/* 0x1f8 */
> +#define RAMDISK_IMAGE_START_MASK  	0x07FF
> +#define RAMDISK_PROMPT_FLAG		0x8000
> +#define RAMDISK_LOAD_FLAG		0x4000	
> +	uint16_t vid_mode;			/* 0x1fa */
> +	uint16_t root_dev;			/* 0x1fc */
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
this should be uint32_t


