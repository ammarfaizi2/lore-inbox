Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265365AbTLHPHR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 10:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265389AbTLHPHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 10:07:17 -0500
Received: from web25201.mail.ukl.yahoo.com ([217.12.10.61]:6063 "HELO
	web25201.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S265365AbTLHPHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 10:07:14 -0500
Message-ID: <20031208150713.39743.qmail@web25201.mail.ukl.yahoo.com>
Date: Mon, 8 Dec 2003 16:07:13 +0100 (CET)
From: =?iso-8859-1?q?moi=20toi?= <mikemaster_f@yahoo.fr>
Subject: Physical address
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am a newbie in the development of Linux driver. I
have some
difficulties to understand how the memory management
works.

I am working on a Pentium IV ( 512M of RAM), with the
Red Hat 9.0.
I want to create buffers in the RAM which are
available for DMA
transfer, and I want that process can map them.

I reserve at boot time some space in the RAM
(mem=400M).
And then I remap a buffer into the driver with the
following command: 

>unsigned long Ram_Buffer_addr;
>#define       POSITION 0x19000000 
//400*1024*1024=400M
>#define SIZE  8*1024
>
>Ram_Buffer_addr = (unsigned long) ioremap (POSITION,
SIZE);

The addresses of the buffer are the following: 
Ram_Buffer_addr               = 0xD9DCB000
Virt_to_phys(Ram_Buffer_addr) = 0x19DCB000
Virt_to_bus(Ram_Buffer_addr)  = 0x19DCB000

The virtual address is of course different from the
physical address,
and the physical address and the bus address are the
same, because I m
working on a PC. But I don t understand why the
physical address is
different from the one I gave to the function ioremap.

I did a second test: I change the position of the
buffer instead of
taking it at the address 0x19000000, the buffer start
at the address:
0x1f400000 (500M).

>unsigned long Ram_Buffer_addr;
>#define       POSITION 0x1F400000 
//500*1024*1024=500M
>#define SIZE  8*1024
>
>Ram_Buffer_addr = (unsigned long) ioremap (POSITION,
SIZE);

The addresses of the buffer are the following: 
Ram_Buffer_addr               = 0xD9DCB000
Virt_to_phys(Ram_Buffer_addr) = 0x19DCB000
Virt_to_bus(Ram_Buffer_addr)  = 0x19DCB000

The addresses are exactly the same. I m ok for the
virtual addresses,
but it sounds pretty weird for the physical and bus
addresses, they
shouldn t be the same than in the first test.

----------------------------------------------------------------------
When I map the buffer from a process, I use the
virtual address of the
buffer with the function mmap, but in the mmap
call-back function in
the driver, I use the true physical address with the
function:
remap_page_range( vma,  vma->vm_start,
POSITION,(vma->vm_end -
vma->vm_start), (pgprot_t) vma->vm_page_prot);
And it seems work! 
But if instead of POSITION, I set
Virt_to_phys(Ram_Buffer_addr), it
doesn t work anymore.

Does that mean that the functions virt_to_phys and
virt_to_bus don t
work on virtual addresses? Does anyone know, how to
get the real
physical address of the buffer.

Thanks

Francois.

____________________________________________________________________________________
Do You Yahoo!? -- Avec Yahoo! soyez au coeur de la récolte de dons pour le Téléthon.
http://fr.promotions.yahoo.com/caritatif/
