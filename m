Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311960AbSDFQSJ>; Sat, 6 Apr 2002 11:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312563AbSDFQSI>; Sat, 6 Apr 2002 11:18:08 -0500
Received: from cannabis.daphnes.RO ([194.105.18.252]:46597 "HELO
	cannabis.daphnes.ro") by vger.kernel.org with SMTP
	id <S311960AbSDFQSI>; Sat, 6 Apr 2002 11:18:08 -0500
Date: Sat, 6 Apr 2002 19:17:15 +0300 (EEST)
From: halfdead <halfdead@daphnes.ro>
X-X-Sender: <halfdead@daphnes.ro>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.x kernels vs. IDT
In-Reply-To: <Pine.GSO.4.21.0204061107230.632-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0204061911310.21482-100000@daphnes.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey all! with the risk of being annoying i post again this message because
i am not sure the last i did found its way to the list due to some unknown
delays in majordomo`s subscribing procedure. so, here it is my problem in
detail:
i experience a weird IDT issue on kernels 2.4.x. what i want to do
is finding the address of a certain IDT gate but when i try to read memory
from ring0 at that location it segfaults. the code is in assembler.

.bss
idtr:
.double
.text

get_gate:
        movl    $0x80, %eax
        sidt    idtr
        movl    idtr+2, %ebx
        leal    (%ebx, %eax, 8), %ebx
        movw    (%ebx), %cx     <- segfault

as far as i know, i retrieve the correct IDT base, but after the leal
instruction, %ebx has some unusual value. i suspect that either leal
instruction is misimplemented in gcc/as compilers or the kernel doesn`t
give me the right IDT. anyway, it could also be some obscure coding error
but i strongly doubt it.
i cannot find out why is this happening.. i would apreciate any help that i
can get.


best regards,
halfdead

