Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264585AbUEXUXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbUEXUXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 16:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUEXUXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 16:23:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9088 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264585AbUEXUXC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 16:23:02 -0400
Date: Mon, 24 May 2004 16:22:46 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: shanthi kiran pendyala <skiranp@cisco.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Mmap problem (VM_DENYWRITE)
In-Reply-To: <000a01c441bf$ccb83600$322147ab@amer.cisco.com>
Message-ID: <Pine.LNX.4.53.0405241610460.729@chaos>
References: <000a01c441bf$ccb83600$322147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2004, shanthi kiran pendyala wrote:

> Hi,
>
> <<I am not subscribed to this list b'cos of the volume of emails. Please
> include my email in the reply.>>

>
> ===================================================================
> My mmap implementation is as follow


Can't you just use ioremap_nocache(FPGA_CSR_ADDR_START, MMAP_SIZE);

>
> #define FPGA_CSR_ADDR_START 0x10940000
> #define FPGA_CSR_ADDR_END   0x1095ffff
> #define MMAP_SIZE (FPGA_CSR_ADDR_END + 1 - FPGA_CSR_ADDR_START)
>

> }
> ================================================================
> I try to access to the device memory region with this user space test
> program
>     ....
> 	fpga_fd = open("/dev/mem", O_RDWR);


If you want to get the physical address from your driver, just
make an ioctl() to return it. In the meantime, mmap() with this
fd.


>
>     if(cde_fd < 0) {
>         printf("can't open %s err %d\n", FPGA_DEV_FILE_NAME, fpga_fd);
>         goto finish;
>     }
>
>     hint = 0x10000000;
>     fpga_csr_start = mmap(hint, MMAP_SIZE,
>                 PROT_READ|PROT_WRITE, MAP_SHARED|MAP_FIXED,
>                 fpga_fd, FPGA_CSR_ADDR_START);
>
>     if (fpga_csr_start == (void *)-1 ) {
                              |_______________ Read docs, don't assume!!

>         printf(" error in mmap errno %d", errno);
>         goto finish;
>     }

      close(fpga_fd);	// Not needed anymore

>
> ...
> ============================================================================
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


