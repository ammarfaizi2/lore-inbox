Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280245AbRJaQB2>; Wed, 31 Oct 2001 11:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280247AbRJaQBU>; Wed, 31 Oct 2001 11:01:20 -0500
Received: from jalon.able.es ([212.97.163.2]:9637 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S280245AbRJaQBL>;
	Wed, 31 Oct 2001 11:01:11 -0500
Date: Wed, 31 Oct 2001 15:59:34 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@zip.com.au>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cdrecord from ext3
Message-ID: <20011031155934.A18608@werewolf.able.es>
In-Reply-To: <20011031001846.A1840@werewolf.able.es> <3BDF576F.3A797933@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3BDF576F.3A797933@zip.com.au>; from akpm@zip.com.au on Wed, Oct 31, 2001 at 02:44:15 +0100
X-Mailer: Balsa 1.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011031 Andrew Morton wrote:
>"J . A . Magallon" wrote:
>
>> Kernel: 2.4.13-ac5+bproc, controller is an Adaptec
>> 
>
>bproc?   scyld distributed process thing, or something else?
>

Yep.

>Something strange is happening.  Could you please investigate
>further?  For example:
>
>	dd if=/dev/zero of=foo bs-1024k count=600
>	time cat foo > /dev/null
>
>How long does the `cat' take on ext2 and ext3?
>

Tried several times. Basic script is:

	rm -f foo
	echo ext2 create:
	time dd if=/dev/zero of=foo bs=1024k count=600
	sync
	echo ext2 read:
	time cat foo > /dev/null
	rm -f foo

and results a similar to this (but read below..):

ext2 create:
600+0 records in
600+0 records out
0.02user 5.73system 0:27.43elapsed 20%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (119major+18minor)pagefaults 0swaps

ext2 read:
0.24user 4.85system 0:27.57elapsed 18%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (100major+17minor)pagefaults 0swaps

ext3 create:
600+0 records in
600+0 records out
0.00user 12.20system 1:12.28elapsed 16%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (119major+18minor)pagefaults 0swaps

ext3 read:
0.19user 6.30system 1:21.73elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (100major+17minor)pagefaults 0swaps

Did you noticed that the ext3 was at 20MHz, and ext2 was at 40MHz ? I
will reformat the 20MHz drive and make 2 slices, one ext2 and one ext3
to be sure not to compare apples and oranges...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.13-ac5-beo #1 SMP Tue Oct 30 00:10:00 CET 2001 i686
