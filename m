Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVCAK5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVCAK5B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 05:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVCAK5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 05:57:00 -0500
Received: from gprs215-195.eurotel.cz ([160.218.215.195]:6280 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261865AbVCAK4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 05:56:38 -0500
Date: Tue, 1 Mar 2005 11:56:25 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
Message-ID: <20050301105625.GH1345@elf.ucw.cz>
References: <20050228231721.GA1326@elf.ucw.cz> <20050301020722.6faffb69.akpm@osdl.org> <20050301022116.2bbd55a0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301022116.2bbd55a0.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Resume on SMP locks up.

Does it work on UP kernel on same hardware? NMI watchdog is problem
for suspend, it takes long to do various phases. Can you disable it
for testing?
								Pavel

> Relocating pagedir | 
> Reading image data (8157 pages): 100% 8157 done.
> Stopping tasks: ====|                           
> Freeing memory... done (0 pages freed)
> Freezing CPUs (at 1)...Sleeping in:   
>  [<c0103c1d>] dump_stack+0x19/0x20 
>  [<c0133c7f>] smp_pause+0x1f/0x54 
>  [<c010ee27>] smp_call_function_interrupt+0x3b/0x60
>  [<c01037d4>] call_function_interrupt+0x1c/0x24    
>  [<c0101111>] cpu_idle+0x55/0x64               
>  [<c05929ed>] start_secondary+0x71/0x78
>  [<00000000>] 0x0                      
>  [<cffa5fbc>] 0xcffa5fbc
> ok                      
> double fault, gdt at c1203260 [255 bytes]
> NMI Watchdog detected LOCKUP on CPU1, eip c0133c96, registers:
> Modules linked in: video thermal processor pcc_acpi fan button battery ac
> CPU:    1                                                                
> EIP:    0060:[<c0133c96>]    Not tainted VLI
> EFLAGS: 00000002   (2.6.11-rc5)             
> EIP is at smp_pause+0x36/0x54   
> eax: 00000001   ebx: cffa5f20   ecx: fffbe4e6   edx: cffa5f20
> esi: cffa4000   edi: 00000080   ebp: cffa5f58   esp: cffa5f1c
> ds: 007b   es: 007b   ss: 0068                               
> Process swapper (pid: 0, threadinfo=cffa4000 task=c18ac540)
> Stack: 00000000 0000007b 00680000 80050033 00000000 005d3000 000006f0 00ff0001 
>        c120b260 07ff5f4c c0577000 00000088 cffa0080 c011eed4 cffa5f68 cffa5f68 
>        c010ee27 00000000 00000001 cffa5fa4 c01037d4 00000001 c120b260 fffbe4e5 
> Call Trace:                                                                    
>  [<c0103bf7>] show_stack+0x7b/0x88
>  [<c0103d36>] show_registers+0x112/0x188
>  [<c01046f1>] die_nmi+0x41/0x74         
>  [<c010fcb4>] nmi_watchdog_tick+0x54/0xcc
>  [<c0104797>] default_do_nmi+0x73/0xfc   
>  [<c0104865>] do_nmi+0x39/0x4c        
>  [<c010395c>] nmi_stack_correct+0x1d/0x2a
>  [<c010ee27>] smp_call_function_interrupt+0x3b/0x60
>  [<c01037d4>] call_function_interrupt+0x1c/0x24    
>  [<c0101111>] cpu_idle+0x55/0x64               
>  [<c05929ed>] start_secondary+0x71/0x78
>  [<00000000>] 0x0                      
>  [<cffa5fbc>] 0xcffa5fbc
> Code: e8 60 e0 24 00 68 0c 7a 40 c0 e8 c2 68 fe ff e8 85 ff fc ff 83 c4 08 f0 ff 05 4c 20 5e c0 a1 50 20 5e c0 89 da 85 c0 74 0b f3 
> console shuts up ...                                                                                                               
>                     

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
