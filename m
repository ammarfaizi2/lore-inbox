Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316898AbSIIKji>; Mon, 9 Sep 2002 06:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316935AbSIIKji>; Mon, 9 Sep 2002 06:39:38 -0400
Received: from ipx.zarz.agh.edu.pl ([149.156.125.1]:34052 "EHLO
	zarz.agh.edu.pl") by vger.kernel.org with ESMTP id <S316898AbSIIKjh>;
	Mon, 9 Sep 2002 06:39:37 -0400
Date: Mon, 9 Sep 2002 12:30:08 +0200 (CEST)
From: "Wojciech \"Sas\" Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, <mingo@elte.hu>
Subject: Re: [long] 2.4.19 and O(1) Scheduler [PPC]
In-Reply-To: <20020906142644.GR761@opus.bloom.county>
Message-ID: <Pine.LNX.4.44L.0209091140470.17064-100000@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2002, Tom Rini wrote:
[...]
> 
> You've got some incomplete PPC patch somewhere,  or you're trying to
> compile for an IBM 40x board, which isn't supported by the kernel.org
> trees yet.

Maybe, patch is from http://people.redhat.com/mingo/O(1)-scheduler/
When I replace PPC405_ERR77(x, y) to dcbt x,y [I found this in 2.5]
This part passed correctly, but I found next error in O(1) scheduler source.

[...]
mk_defs.c: In function `main':
mk_defs.c:40: structure has no member named `counter'
mk_defs.c:41: structure has no member named `processor'

When I change this:
from:
	DEFINE(COUNTER, offsetof(struct task_struct, counter));
	DEFINE(PROCESSOR, offsetof(struct task_struct, processor));
to:
	DEFINE(COUNTER, offsetof(struct task_struct, time_slice));
	DEFINE(PROCESSOR, offsetof(struct task_struct, cpu));

I hope this is correct, I found last error :

[...]
	arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	 drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/drm/drm.o drivers/net/fc/fc.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/net/pcmcia/pcmcia_net.o drivers/net/wireless/wireless_net.o drivers/macintosh/macintosh.o drivers/video/video.o drivers/net/hamradio/hamradio.o drivers/usb/usbdrv.o drivers/input/inputdrv.o drivers/md/mddev.o drivers/isdn/vmlinux-obj.o \
	net/network.o \
	/home/users/cieciwa/rpm/BUILD/linux-2.4.19/lib/lib.a \
	--end-group \
	-o vmlinux
arch/ppc/kernel/kernel.o: In function `ret_from_fork':
arch/ppc/kernel/kernel.o(.text+0x27c): undefined reference to `schedule_tail'
arch/ppc/kernel/kernel.o(.text+0x27c): relocation truncated to fit: R_PPC_REL24 schedule_tail
kernel/kernel.o: In function `schedule':
kernel/kernel.o(.text+0x1054): undefined reference to `_sched_find_first_bit'
kernel/kernel.o(.text+0x1054): relocation truncated to fit: R_PPC_REL24 _sched_find_first_bit
make: *** [vmlinux] Error 1
 
And I don't know how to solve this problem.
I don't have PPC machine in home, this error I take when I work via 
internet.

Thanx.
					Sas.
-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}

