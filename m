Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271135AbRHTJdw>; Mon, 20 Aug 2001 05:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271134AbRHTJdm>; Mon, 20 Aug 2001 05:33:42 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:26763 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S271135AbRHTJd1>; Mon, 20 Aug 2001 05:33:27 -0400
From: Christoph Rohland <cr@sap.com>
To: "Michel A. S. Pereira - KIDMumU|ResolveBucha" 
	<michelcultivo@uol.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.4.8
In-Reply-To: <3B7D12D0.BE309A7@uol.com.br>
Organisation: SAP LinuxLab
Date: 20 Aug 2001 11:33:27 +0200
Message-ID: <m3g0anf53s.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

On Fri, 17 Aug 2001, Michel A. S. Pereira wrote:
> 	The oops:
> 
> Aug 17 02:45:07 lucy kernel: Unable to handle kernel paging request at
> virtual address 34e21396
> Aug 17 02:45:07 lucy kernel:  printing eip:
> Aug 17 02:45:07 lucy kernel: c013e9b7
> Aug 17 02:45:07 lucy kernel: *pde = 00000000
> Aug 17 02:45:07 lucy kernel: Oops: 0002
> Aug 17 02:45:07 lucy kernel: CPU:    0
> Aug 17 02:45:07 lucy kernel: EIP:    0010:[d_instantiate+55/80]
> Aug 17 02:45:07 lucy kernel: EFLAGS: 00010282
> Aug 17 02:45:07 lucy kernel: eax: 34e21392   ebx: c61a1370   ecx:
> 00000000   edx: c6f2a880
> Aug 17 02:45:07 lucy kernel: esi: c6f2a720   edi: c61a1340   ebp:
> ffffffe4   esp: cdacbefc
> Aug 17 02:45:07 lucy kernel: ds: 0018   es: 0018   ss: 0018
> Aug 17 02:45:07 lucy kernel: Process enlightenment (pid: 988,
> stackpage=cdacb000)
> Aug 17 02:45:07 lucy kernel: Stack: c6dcf140 c6f2a720 c61a1340 c012bfe5
> c61a1340 c6f2a720 cdacbf5c cee6b720
> Aug 17 02:45:07 lucy kernel:        000003b6 00000001 cdacbf5c 0000000c
> 00000000 c0174952 cdacbf5c 00000080
> Aug 17 02:45:07 lucy kernel:        00000000 cdacbf5c c0226c56 00000000
> 000003b6 00000000 000003b6 00000080
> Aug 17 02:45:07 lucy kernel: Call Trace: [shmem_file_setup+189/284]
> [newseg+142/336] [sys_shmget+100/292] [sys_ipc+584/632]
> [math_state_restore+25/52] [system_call+51/56]
> Aug 17 02:45:07 lucy kernel:
> Aug 17 02:45:07 lucy kernel: Code: 89 58 04 89 47 30 8d 46 10 89 43 04
> 89 5e 10 89 77 08 5b 5e

AFAIU d_instantiate fails to list_add(&entry->d_alias, &inode->i_dentry)
while accessing inode->i_dentry->next.

So inode has to be initialised incorrectly. The shmem_file_setup part
is straightforward. I would guess it is a corrupted slab cache. But
that's out of my area of understanding.

Greetings
		Christoph


