Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262851AbVF3Fst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbVF3Fst (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 01:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbVF3Fst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 01:48:49 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:47541 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262851AbVF3Fsp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 01:48:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-transfer-encoding:x-mailer;
        b=AiWPzPfIfmQ6ILwNmrUo+I0c40jSbTye38QqrYpiDzihcLTaOkHvFirwozMQ6YQoxYXnDc7u3wDddWWRS1CuF7M50Wrj5ERBNUp2q5LZ1e6eTjaBHoVL9beuFyJkOMo2nmb5zhoEiuumsl0uGVgIhDF8kCjpXW+XlYkQctyRTTk=
Date: Thu, 30 Jun 2005 13:46:43 +0800
From: Wang Jian <larkwang@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12.1 problems I meet (please CC: me)
Message-Id: <20050630111916.FEA2.LARKWANG@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Mailer: Becky! ver. 2.20 [CN]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I use a customized kernel to do packets analysis. The analysis code is
linked into kernel. It will vmalloc() nearly 128M (a little less) when
initialized.

The original code runs on 2.6.10 and works fine. The platform is a
general P4 with 100M ethernet. The user space system is a 8M compressed
ramdisk image which is a 32M filesystem.

Now I want to make it work on 2.6.12+ and on Athlon64 platform, for
better driver and better CPU/NIC performance.

I have a P4 box (compilation bed, CB), a 2-way Athlon64 box (test bed,
TB).

The problems are:

1. I port the code directly to 2.6.12.1 on CB, and it compiles ok. But
during boot, the kernel boot with error "unknown bus type 0" and freeze.
Especially, it can't detect harddisk's partition table. I use "quiet" to
strip non-error message and hand copy error messages

unknown bus type 0.
...
<repeat for several times>
...
unknown bus type 0.
irq 15: nobody cared!
handlers:
[<c0252927>]  (ide_intr+0x0/0x146)
Disabling IRQ #15
irq 1: nobody cared!
handlers:
[<c021a79a>]  (i8042_interrupt+0x0/0x256)
Disabling IRQ #1

But the same configuration works fine for 2.6.10.


2. I compile kernel 2.6.12.1 for K7 on CB. Boot it on TB, the system
boot up execept that the analysis code can't vmalloc() the needed memory.

"allocation failed: out of vmalloc space - use vmalloc=<size> to increase size."

If I use vmalloc=256m in boot command line, then

initrd extends beyond end of memory (0x37fef716 > 0x30000000)
initrd extends beyond end of memory (0x37fef716 > 0x30000000)
Kernel panic - unsyncing: VFS: Unable to mount root fs on unknown-block
(1,0)

BTW: Is there any way that a 512M memory chunk can be alloc? The system
has a lot of memory (1G+) and can't be used. It's better to provide a
mechanism to alloc big chunk of memory for special purpose (they will
never be freed and will be used as a single big chunk)


-- 
Wang Jian

