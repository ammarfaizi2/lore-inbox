Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbQLaCPm>; Sat, 30 Dec 2000 21:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbQLaCPc>; Sat, 30 Dec 2000 21:15:32 -0500
Received: from colorfullife.com ([216.156.138.34]:17416 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129348AbQLaCPN>;
	Sat, 30 Dec 2000 21:15:13 -0500
Message-ID: <3A4E8FE3.DB1B9604@colorfullife.com>
Date: Sun, 31 Dec 2000 02:46:11 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test13-pre7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, acpi@phobos.fachschaften.tu-muenchen.de
Subject: oops with 2.4.0-test13-pre7 in acpi_ns_get_next_object
Content-Type: multipart/mixed;
 boundary="------------F3E3D28E45D35716BADF5B0F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F3E3D28E45D35716BADF5B0F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

As I wrote in the subject line I get an oops with 2.4.0-test13-pre7.

Board: Gigabyte BXD with newest BIOS, Dual processor

Previous kernels ( <=-test12) just printed

ACPI: support found
ACPI: PBLK 0 @ 0x0000:0
ACPI: PBLK 1 @ 0x0000:0
	-0196: *** Error: Sleep State package elements are not both of type
number

Now I get the attached oops.
I've tracked it back into acpi_ns_get_next_object: that function is
called with both child_node and parent_node == NULL, and then the line

	if (parent_node->child)

oopses.

If you need further infos, please ask.

--
	Manfred
--------------F3E3D28E45D35716BADF5B0F
Content-Type: text/plain; charset=us-ascii;
 name="new.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="new.txt"

ACPI: System description tables found
ACPI: System description tables loaded
Unable to handle kernel NULL pointer dereference at virtual address 00000010
 printing eip:
c01d7583
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[acpi_ns_get_next_object+19/76]
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: 54594247   edx: 00000000
esi: 00000000   edi: 0000008d   ebp: 00000000   esp: cbf33f34
ds: 0018   es: 0018   ss: 0018
Process kacpid (pid: 7, stackpage=cbf33000)
Stack: 00000000 c01d75fb 00000000 00000000 00000000 c01ce2f4 ffffffff cbf32331 
       cbf32000 08010646 c01d7d16 00000008 cbf3afc0 ffffffff 00000001 c01ce2f4 
       00000000 00000000 00000008 00000000 c0269e55 c01ce39c 00000008 cbf3afc0 
Call Trace: [acpi_ns_walk_namespace+63/260] [acpi_ev_save_method_info+0/120] [acpi_walk_namespace+70/92] [acpi_ev_save_method_info+0/120] [_acpi_ctype+12949/25696] [acpi_ev_init_gpe_control_methods+48/56] [acpi_ev_save_method_info+0/120] 
       [acpi_ev_initialize+74/100] [acpi_enable_subsystem+62/104] [acpi_thread+163/540] [empty_bad_page+0/4096] [empty_bad_page+0/4096] [startup_32+24/203] [kernel_thread+26/48] [kernel_thread+35/48] 
Code: 8b 40 10 85 c0 74 11 89 c2 eb 0d 89 f6 50 e8 be ff ff ff 89 

Disassembly:
(gdb) x/30i acpi_ns_get_next_object
0xc01d7570 <acpi_ns_get_next_object>:	push   %ebx
0xc01d7571 <acpi_ns_get_next_object+1>:	xor    %edx,%edx
0xc01d7573 <acpi_ns_get_next_object+3>:	mov    0x10(%esp,1),%eax
0xc01d7577 <acpi_ns_get_next_object+7>:	mov    0x8(%esp,1),%bl
0xc01d757b <acpi_ns_get_next_object+11>:	test   %eax,%eax
0xc01d757d <acpi_ns_get_next_object+13>:	jne    0xc01d7590 <acpi_ns_get_next_object+32>
0xc01d757f <acpi_ns_get_next_object+15>:	mov    0xc(%esp,1),%eax
0xc01d7583 <acpi_ns_get_next_object+19>:	mov    0x10(%eax),%eax
0xc01d7586 <acpi_ns_get_next_object+22>:	test   %eax,%eax
0xc01d7588 <acpi_ns_get_next_object+24>:	je     0xc01d759b <acpi_ns_get_next_object+43>
0xc01d758a <acpi_ns_get_next_object+26>:	mov    %eax,%edx
0xc01d758c <acpi_ns_get_next_object+28>:	jmp    0xc01d759b <acpi_ns_get_next_object+43>
0xc01d758e <acpi_ns_get_next_object+30>:	mov    %esi,%esi
0xc01d7590 <acpi_ns_get_next_object+32>:	push   %eax
0xc01d7591 <acpi_ns_get_next_object+33>:	call   0xc01d7554 <acpi_ns_get_next_valid_object>
0xc01d7596 <acpi_ns_get_next_object+38>:	mov    %eax,%edx
0xc01d7598 <acpi_ns_get_next_object+40>:	add    $0x4,%esp
0xc01d759b <acpi_ns_get_next_object+43>:	test   %bl,%bl
0xc01d759d <acpi_ns_get_next_object+45>:	jne    0xc01d75b3 <acpi_ns_get_next_object+67>
0xc01d759f <acpi_ns_get_next_object+47>:	mov    %edx,%eax
0xc01d75a1 <acpi_ns_get_next_object+49>:	jmp    0xc01d75b9 <acpi_ns_get_next_object+73>
0xc01d75a3 <acpi_ns_get_next_object+51>:	cmp    %bl,0x1(%edx)
0xc01d75a6 <acpi_ns_get_next_object+54>:	je     0xc01d759f <acpi_ns_get_next_object+47>
0xc01d75a8 <acpi_ns_get_next_object+56>:	push   %edx
0xc01d75a9 <acpi_ns_get_next_object+57>:	call   0xc01d7554 <acpi_ns_get_next_valid_object>
0xc01d75ae <acpi_ns_get_next_object+62>:	mov    %eax,%edx
0xc01d75b0 <acpi_ns_get_next_object+64>:	add    $0x4,%esp
0xc01d75b3 <acpi_ns_get_next_object+67>:	test   %edx,%edx
0xc01d75b5 <acpi_ns_get_next_object+69>:	jne    0xc01d75a3 <acpi_ns_get_next_object+51>
0xc01d75b7 <acpi_ns_get_next_object+71>:	xor    %eax,%eax
(gdb) quit

--------------F3E3D28E45D35716BADF5B0F--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
