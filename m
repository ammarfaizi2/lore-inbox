Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130510AbRAOOi3>; Mon, 15 Jan 2001 09:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130372AbRAOOiU>; Mon, 15 Jan 2001 09:38:20 -0500
Received: from smtp8.xs4all.nl ([194.109.127.134]:11006 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S130436AbRAOOiH>;
	Mon, 15 Jan 2001 09:38:07 -0500
Date: Mon, 15 Jan 2001 14:36:15 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
Message-ID: <20010115143615.A3525@grobbebol.xs4all.nl>
In-Reply-To: <E14H8Ks-0004hA-00@the-village.bc.nu> <3A5F4827.2E443786@colorfullife.com> <20010112200541.A25675@unternet.org> <93no05$7k1$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <93no05$7k1$1@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Jan 12, 2001 at 12:04:21PM -0800
X-OS: Linux grobbebol 2.2.19pre7 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 12:04:21PM -0800, Linus Torvalds wrote:
> Ok, so it's tentatively the IOAPIC disable/enable code.  But it could
> obviously be something that just interacts with it, including just a
> timing issue (ie the _real_ bug might just be bad behaviour when
> changing IO-APIC state at the same time as an interrupt happens, and
> disable/enable-irq just happen to be the only things that do it at a
> high enough frequency that you can see the problem). 


my BP6 with the patch frank sent me and the apic code at line 273 (or
so) defined as '1' and a flood ping :

Jan 14 19:56:19 grobbebol kernel: APIC error on CPU1: 02(02)
Jan 14 19:56:25 grobbebol kernel: APIC error on CPU1: 02(02)
Jan 14 19:58:10 grobbebol last message repeated 2 times
Jan 14 20:00:01 grobbebol kernel: APIC error on CPU1: 02(02)
Jan 14 20:01:11 grobbebol last message repeated 2 times
Jan 14 20:01:48 grobbebol kernel: APIC error on CPU1: 02(02)
Jan 14 20:01:59 grobbebol kernel: APIC error on CPU1: 02(08)
Jan 14 20:02:10 grobbebol kernel: APIC error on CPU1: 08(08)
Jan 14 20:02:39 grobbebol kernel: APIC error on CPU1: 08(02)
Jan 14 20:02:39 grobbebol kernel: unexpected IRQ trap at vector 8d
Jan 14 20:15:32 grobbebol kernel: APIC error on CPU1: 02(08)
[....]


ad the network is dead. however, no crashes seen during this.
-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
