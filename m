Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVDDPNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVDDPNn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 11:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVDDPNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 11:13:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21687 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261265AbVDDPM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 11:12:57 -0400
Date: Sun, 3 Apr 2005 17:20:18 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org, Steffen Moser <lists@steffen-moser.de>
Subject: Re: Oops with "linux-2.4.29"
Message-ID: <20050403202018.GB26531@logos.cnet>
References: <20050331132449.GO10495@steffen-moser.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331132449.GO10495@steffen-moser.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Steffen,

On Thu, Mar 31, 2005 at 03:24:49PM +0200, Steffen Moser wrote:
> Hi all,
> 
> one of our file servers (SuSE Linux 7.2, running "linux-2.4.29")  
> oopsed some days ago - here is the bug report:
> 
> [1.] One line summary of the problem:
> 
> Kernel "linux-2.4.29" oopses irregularly. The oopses seem to be 
> triggered by high I/O load on the SCSI subsystem.
> 
> 
> [2.] Full description of the problem/report:
> 
> The machine which is mainly used as a "samba" and "NIS/NFS" server of
> a comprehensive secondry school's network runs unstable - especially 
> under heavy I/O load, for example, when a virus scanner ("antivir" {1}) 
> is doing a scan over the whole user data files.
> 
> The oopses are not only triggered by "antivir", but also during high
> I/O load caused by a "samba" process, for example. 
> 
> The machine is running quite an old installation of SuSE Linux 7.2. The
> kernel which is used is "linux-2.4.29". The security relevant things 
> ("samba", "ssh", "kernel", and so on) have been patched manually. I 
> haven't had the time to set up this machine based on a newer distri-
> bution, yet. :-/
> 

<snip>

> [...]
>  
>  | Code: 00 00 00 00 17 3a 23 00 01 00 00 00 04 09 00 00 00 00 00 00
>  | Unable to handle kernel NULL pointer dereference at virtual address
>  | 00000000
>  | ccabe7a0
>  | *pde = 00000000
>  | Oops: 0002
>  | CPU:    0
>  | EIP:    0010:[<ccabe7a0>]    Not tainted
>  | Using defaults from ksymoops -t elf32-i386 -a i386
>  | EFLAGS: 00010282
>  | eax: 00000000   ebx: c13b8214   ecx: 00000017   edx: c0273c5c
>  | esi: dfe91504   edi: 00000000   ebp: da00a804   esp: d4e5bf20
>  | ds: 0018   es: 0018   ss: 0018
>  | Process antivir (pid: 28362, stackpage=d4e5b000)
>  | Stack: c13b8214 c015991c c0124041 d3baf260 c13b8214 00000000 d3baf260 08179504
>  |        d3baf280 00001000 00000001 00000000 00000000 da00a740 c0124583 d3baf260
>  |        d3baf280 d4e5bf8c c012446c 00000000 d3baf260 ffffffea 00000400 00000000
>  | Call Trace:    [<c015991c>] [<c0124041>] [<c0124583>] [<c012446c>] [<c0130d56>]
>  |   [<c0106b33>]
>  | Code: 00 00 00 00 17 3a 23 00 01 00 00 00 04 09 00 00 00 00 00 00
>  | 
>  | 
>  | >>EIP; ccabe7a0 <_end+c7cd2ac/20552b0c>   <=====
>  | 
>  | >>ebx; c13b8214 <_end+10c6d20/20552b0c>
>  | >>edx; c0273c5c <contig_page_data+dc/3c0>
>  | >>esi; dfe91504 <_end+1fba0010/20552b0c>
>  | >>ebp; da00a804 <_end+19d19310/20552b0c>
>  | >>esp; d4e5bf20 <_end+14b6aa2c/20552b0c>
>  | 
>  | Trace; c015991c <ext3_get_block+0/64>
>  | Trace; c0124041 <do_generic_file_read+291/438>
>  | Trace; c0124583 <generic_file_read+8b/190>
>  | Trace; c012446c <file_read_actor+0/8c>
>  | Trace; c0130d56 <sys_read+96/f0>
>  | Trace; c0106b33 <system_call+33/38>
>  |
>  | Code;  ccabe7a0 <_end+c7cd2ac/20552b0c>
>  | 00000000 <_EIP>:
>  | Code;  ccabe7a0 <_end+c7cd2ac/20552b0c>   <=====
>  |    0:   00 00                     add    %al,(%eax)   <=====
>  | Code;  ccabe7a2 <_end+c7cd2ae/20552b0c>
>  |    2:   00 00                     add    %al,(%eax)
>  | Code;  ccabe7a4 <_end+c7cd2b0/20552b0c>
>  |    4:   17                        pop    %ss
>  | Code;  ccabe7a5 <_end+c7cd2b1/20552b0c>
>  |    5:   3a 23                     cmp    (%ebx),%ah
>  | Code;  ccabe7a7 <_end+c7cd2b3/20552b0c>
>  |    7:   00 01                     add    %al,(%ecx)
>  | Code;  ccabe7a9 <_end+c7cd2b5/20552b0c>
>  |    9:   00 00                     add    %al,(%eax)
>  | Code;  ccabe7ab <_end+c7cd2b7/20552b0c>
>  |    b:   00 04 09                  add    %al,(%ecx,%ecx,1)

This looks like corruption - ext3_get_block() jumps to a bogus function
which contains bogus instructions. Like if ext3_get_block() had been
overwritten with junk data. 

Smells like bad hardware, but I'm not certain.

> [6.] A small shell script or example program which triggers the
> problem (if possible):
> 
> Running "antivir /usr/lib/AntiVir/antivir -s -e -del /home /export"
> every two hours (started by "cron") will produce a oops like this
> within a few days.

Do you have other oopses saved? Please send em.
