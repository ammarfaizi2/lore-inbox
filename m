Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266785AbTGGCXj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 22:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266794AbTGGCXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 22:23:39 -0400
Received: from dyn-ctb-210-9-243-115.webone.com.au ([210.9.243.115]:51716 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S266785AbTGGCX2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 22:23:28 -0400
Message-ID: <3F08DCFB.6030400@cyberone.com.au>
Date: Mon, 07 Jul 2003 12:37:47 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Brandon Low <lostlogic@gentoo.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: anticipatory scheduler merged
References: <20030705133334.4cc7e11b.akpm@osdl.org> <20030707022212.GE27027@lostlogicx.com>
In-Reply-To: <20030707022212.GE27027@lostlogicx.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Brandon Low wrote:

>On Sat, 07/05/03 at 13:33:34 -0700, Andrew Morton wrote:
>
>>- These changes have been well tested, but it is five months work and
>>  over 100 patches.  There's probably a bug or two.  If you suspect that
>>  something has gone wrong at the block layer (lots of tasks stuck in D
>>  state) then please retest with `elevator=deadline'.
>>
>>Thanks.
>>
>
>I am seeing these D tasks when running 2.5.74-mm2 under a heavy seeking
>load (compiling application, untarring kernel, and filesharing
>simultaneously) on a slow (laptop 4200RPM) hdd.  I find that after about
>10 uptime when I start throwing on the seeking loads one or all of them
>go to D state and any new disk IO is either blocked or very slow.
>
>I have tested with elevator=deadline and have been unable to reproduce.
>
>Any further testing or debugging you need me to do I can probably do
>(but I'm not terribly knowledgable so I'll need step by step for said
>testing).  Thanks!
>
>

OK, so the disk is IDE, and you aren't using ide-scsi? Please compile the
kernel with "Magic SysRq key" config option enabled. Its in the Kernel
hacking submenu.

Then repeat the system freeze, and press alt+sys rq+t. Run dmesg | less to
get the task trace. You'll get a lot of lines like this:
bash          S 00000001   627    625                 626 (NOTLB)
followed by their call traces. Copy the call trace of one or two tasks that
have a D following their name. Then post it here.

Oh and you'll probably have to run dmesg and less to get them into cache
before the system freezes!

Thanks,
Nick

