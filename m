Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130475AbQLYVMK>; Mon, 25 Dec 2000 16:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130704AbQLYVMA>; Mon, 25 Dec 2000 16:12:00 -0500
Received: from pec-148-86.tnt6.h2.uunet.de ([149.225.148.86]:12549 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id <S130475AbQLYVLv>; Mon, 25 Dec 2000 16:11:51 -0500
Date: Mon, 25 Dec 2000 20:40:50 +0000
From: Thorsten Kranzkowski <th@Marvin.DL8BCU.ampr.org>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Andreas Franck <afranck@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Fatal Oops on boot with 2.4.0testX and recent GCC snapshots
Message-ID: <20001225204050.A1126@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@gmx.net
Mail-Followup-To: Mike Galbraith <mikeg@wen-online.de>,
	Andreas Franck <afranck@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <00122423490000.00575@dg1kfa.ampr.org> <Pine.Linu.4.10.10012250531020.560-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.Linu.4.10.10012250531020.560-100000@mikeg.weiden.de>; from mikeg@wen-online.de on Mon, Dec 25, 2000 at 06:09:35AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 25, 2000 at 06:09:35AM +0100, Mike Galbraith wrote:
> I wouldn't (not going to here;) spend a lot of time on it.  The compiler
> has problems.  It won't build glibc-2.2, and chokes horribly on ipchains.
> 
> int ipt_register_table(struct ipt_table *table)
> {
> 	int ret;
> 	struct ipt_table_info *newinfo;
> 	static struct ipt_table_info bootstrap
> 		= { 0, 0, { 0 }, { 0 }, { } };
>                                ^
> ip_tables.c:1361: Internal compiler error in array_size_for_constructor, at varasm.c:4456


Well, I  'fixed' this by changing above line to:
 		= { 0, 0, { 0 }, { 0 }, };
and repeating this change (deleting the braces) about 15 times in 2 or 3 other 
files of iptables. (patch available on request)
Of course gcc shouldn't die but issue a useful message if/when syntax rules
may have changed.

Apart from that and a hand-edited arch/alpha/vmlinux.lds that got some 
newlines wrong, the kernel compiled fine and is up for over a day now.
Though this is not intel but alpha (ev4 / AXPpci33).

Marvin:~$ uname -a
Linux Marvin 2.4.0-test13pre4-ac2 #13 Sun Dec 24 15:26:57 UTC 2000 alpha unknown
Marvin:~$ uptime
  8:19pm  up 1 day,  4:28,  4 users,  load average: 0.00, 0.00, 0.00
Marvin:~$ gcc -v
Reading specs from /usr/lib/gcc-lib/alpha-unknown-linux-gnu/2.97/specs
Configured with: ../gcc-20001211/configure --enable-threads --enable-shared --prefix=/usr --enable-languages=c,c++
gcc version 2.97 20001211 (experimental)


I use iptables for masquerading my local ethernet and that works as expected
so far.

Thorsten.



-- 
| Thorsten Kranzkowski        Internet: dl8bcu@gmx.net                        |
| Mobile: ++49 170 1876134       Snail: Niemannsweg 30, 49201 Dissen, Germany |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
