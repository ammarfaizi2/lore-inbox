Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVCSNql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVCSNql (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVCSNnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:43:01 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62981 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262541AbVCSNj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:39:58 -0500
Date: Sat, 19 Mar 2005 14:39:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Erich Chen <erich@areca.com.tw>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: 2.6.11-mm4: drivers/scsi/arcmsr/arcmsr.c: enormous stack usage
Message-ID: <20050319133951.GK3143@stusta.de>
References: <20050316040654.62881834.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316040654.62881834.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 04:06:54AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.11-mm3:
>...
> +areca-raid-linux-scsi-driver.patch
> 
>  Updated version of this driver.
>...

<--  snip  -->

...
static int arcmsr_iop_ioctlcmd(PACB pACB, int ioctl_cmd, void *arg)
{
...
uint8_t tmpQbuffer[1032];
...
uint8_t tmpuserbuffer[1032];
...
}
...

<--  snip  -->


1kB allocations from the stack aren't a good idea considering that you 
might have only a 4kB stack altogether.


Running "make checkstack" after compiling the kernel helps you finding 
such problems.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

