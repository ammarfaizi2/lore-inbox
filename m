Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbTABEa5>; Wed, 1 Jan 2003 23:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbTABEa5>; Wed, 1 Jan 2003 23:30:57 -0500
Received: from holomorphy.com ([66.224.33.161]:53442 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265517AbTABEa4>;
	Wed, 1 Jan 2003 23:30:56 -0500
Date: Wed, 1 Jan 2003 20:38:50 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au
Subject: Re: Linux v2.5.54
Message-ID: <20030102043850.GP9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
References: <Pine.LNX.4.44.0301011935410.8506-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301011935410.8506-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2003 at 07:43:40PM -0800, Linus Torvalds wrote:
> Rusty Russell <rusty@rustcorp.com.au>:
>   o Modules without init functions don't need exit functions
>   o Embed __this_module in module itself
>   o Fix MODULE_PARM for arrays of s
>   o Minor compile fix for some modules
>   o more module parameter parsing bugs
>   o MODULE_PARM "c" support
>   o Modules 1/3: remove common section handling
>   o Modules 2/3: Use sh_addr instead of sh_offset
>   o Modules 3/3: Sort sections

Hmm, I got this oops in 2.5.53-mm3:

eth2: Adaptec Starfire 6915 at 0xf8a55000, 00:00:d1:ec:cf:9f, IRQ 11.
eth2: MII PHY found at address 1, status 0x7809 advertising 01e1.    
eth2: scatter-gather and hardware TCP cksumming disabled.        
eth3: Adaptec Starfire 6915 at 0xf8ad6000, 00:00:d1:ec:cf:a0, IRQ 7.
eth3: MII PHY found at address 1, status 0x7809 advertising 01e1.   
eth3: scatter-gather and hardware TCP cksumming disabled.        
ERROR: SCSI host `isp1020' has no error handling         
ERROR: This is not a safe way to run your SCSI host
ERROR: The error handling must be added to this driver
Call Trace:                                           
 [<c02364a9>] <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0137ca3      
*pde = 00104001
Oops: 0002     
CPU:    0 
EIP:    0060:[<c0137ca3>]    Not tainted
EFLAGS: 00010206                        
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:                                                              
c0137ca3      
*pde = 00104001

$ addr2line -e vmlinux 0xc0137ca3
/mnt/g/mm3-2.5.53-2/kernel/kallsyms.c:60
$ addr2line -e vmlinux 0xc02364a9
/mnt/g/mm3-2.5.53-2/drivers/scsi/hosts.c:380

It doesn't look like these codepaths were touched in the recent 2.5.54
changes.


Thanks,
Bill
