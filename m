Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268899AbRHFRFs>; Mon, 6 Aug 2001 13:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268900AbRHFRFi>; Mon, 6 Aug 2001 13:05:38 -0400
Received: from mercury.eng.emc.com ([168.159.40.77]:46097 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S268899AbRHFRF0>; Mon, 6 Aug 2001 13:05:26 -0400
Message-ID: <276737EB1EC5D311AB950090273BEFDD043BC54C@elway.lss.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'Ignacio Vazquez-Abrams'" <ignacio@openservices.net>,
        linux-kernel@vger.kernel.org
Subject: RE: Problems in using loadLin
Date: Mon, 6 Aug 2001 12:59:40 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the reply. I found the problem. The first kernel
image doesn't probe multiple luns, while the second one does.
So the devno of the root filesystem changes. I built the driver
into the kernel, so I did not use the initrd.

There is another problem with loadLin for > 2.4.2 kernel. 
It seems that I could not use dev names to specify root 
filesystem. Say if the boot.bat is like:
	loadlin.exe bzImage ro root=/dev/sdc1

The kernel fails to boot due to null ptr error.



-----Original Message-----
From: Ignacio Vazquez-Abrams [mailto:ignacio@openservices.net]
Sent: Monday, August 06, 2001 12:58 PM
To: linux-kernel@vger.kernel.org
Subject: Re: Problems in using loadLin


On Mon, 6 Aug 2001, chen, xiangping wrote:

> Hi,
>
> I am trying to use loadlin to boot up a machine. But after I
> replaced the bzImage, the kernel fails to boot up. It prints
> out error messages like:
> 	...
> 	VFS: Mounted root (ext2 filesystem) readonly
> 	Freeing unused kernel memory : 96K freed
> 	Warning: unable to open an initial console
> 	Kernel panic: No init found. Try passing init= option to kernel.
>
> The boot.bat file is:
> 	loadlin.exe bzImage ro root=0x0821
>
> Thanks,
>
> Xiangping

0x0821 represents /dev/sdc1. Did you build the SCSI driver into the kernel,
or
do use an initrd?

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
