Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129828AbQJaNym>; Tue, 31 Oct 2000 08:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129942AbQJaNyd>; Tue, 31 Oct 2000 08:54:33 -0500
Received: from ns.dce.bg ([212.50.14.242]:39434 "HELO home.dce.bg")
	by vger.kernel.org with SMTP id <S129828AbQJaNy0>;
	Tue, 31 Oct 2000 08:54:26 -0500
Message-ID: <39FECEFD.4F70A24F@dce.bg>
Date: Tue, 31 Oct 2000 15:54:05 +0200
From: Petko Manolov <petkan@dce.bg>
Organization: Deltacom Electronics
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: changed section attributes
In-Reply-To: <E13pz9c-0006Jh-00@the-village.bc.nu> <39FD5433.587FF7C6@zaralinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi there,

I noticed that when i changed to binutils 2.10.91 (Debian,woody)
i start to see messages like:

"Warning: Ignoring changed section attributes for .modinfo"

Chasing down the problem appeared that section modinfo is
declared for the first time as ".section .modinfo" without any
attributes. This is done by the including of linux/module.h.
The next declaration is ".section .modinfo,"a",@progbits".
And assembler moans on that line number.

Changing the declaration in linux/module.h to ".modinfo,"a""
fixed the problem, but i noticed that the author said that
"we want .modinfo to not be allocated"

I wonder why?

I already tried to allocate it (.modinfo,"a" in module.h) and
it seems to work.

Any ideas?



	Petkan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
