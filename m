Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbSKBSQ7>; Sat, 2 Nov 2002 13:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261360AbSKBSQ7>; Sat, 2 Nov 2002 13:16:59 -0500
Received: from [212.45.9.156] ([212.45.9.156]:44673 "EHLO null.ru")
	by vger.kernel.org with ESMTP id <S261354AbSKBSQW>;
	Sat, 2 Nov 2002 13:16:22 -0500
Message-ID: <3DC417A4.2000903@yahoo.com>
Date: Sat, 02 Nov 2002 21:21:24 +0300
From: Stas Sergeev <stssppnn@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021014
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Larger IO bitmap?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I was trying to add some VESA support to
dosemu and found that on my Radeon7500
card it requires an access to the ports
from range 0x9800-0x98ff. As ioperm()
doesn't allow to open such a ports, I've
got a very slow graphics.
What happens is this:
IO attempt->GPF->return_to_dosemu->
decode insn->change uid->change IOPL->
do IO->change IOPL->change uid->
back_to_DOS_execution.
You may guess how slow it is, but if I
say that it is as slow as the simple
screen redraw takes up to a minute, that
may still be a surprise:)

My question is: why do we still have a
128-bit IO bitmap? Is it possible to have
the full 8K IO bitmap per process under
Linux? And if yes, then why not yet?
(Note: I am using the latest 2.4 kernels
and I don't know if there is something
changed in 2.5 about that problem. If
something is changed, then sorry for wasting
your time).

I think that could be an advantage also for
X. I think currently X works around the
problem by keeping IOPL==3 all the run,
but that can't work for dosemu.

I've found several discussions on that
topic, but they all ended unconclusively
(too difficult, too expensive, useless etc).
But as the last discussion I've found was
dated 1998, I think it is time to reiterate:)

Can anyone please suggest what must be done
in order to enlarge the thing? The obvious
way of increasing IO_BITMAP_SIZE constant
doesn't do the trick.

