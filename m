Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132589AbQKXK1j>; Fri, 24 Nov 2000 05:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132609AbQKXK1a>; Fri, 24 Nov 2000 05:27:30 -0500
Received: from devserv.devel.redhat.com ([207.175.42.156]:21004 "EHLO
        devserv.devel.redhat.com") by vger.kernel.org with ESMTP
        id <S132589AbQKXK1V>; Fri, 24 Nov 2000 05:27:21 -0500
Date: Fri, 24 Nov 2000 04:57:02 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Andries.Brouwer@cwi.nl
Cc: greg@linuxpower.cx, viro@math.psu.edu, alan@lxorguk.ukuu.org.uk,
        bernds@redhat.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: gcc-2.95.2-51 is buggy
Message-ID: <20001124045702.M1514@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <UTC200011240520.GAA143373.aeb@aak.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200011240520.GAA143373.aeb@aak.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Nov 24, 2000 at 06:20:33AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2000 at 06:20:33AM +0100, Andries.Brouwer@cwi.nl wrote:
> >> ... RedHat's GCC snapshot "2.96" handles this case just fine.
> 
> > Now, if you can isolate the relevant part of the diff between
> > 2.95.2 and RH 2.96...
> 
> Maybe I have to be more precise in the statement "gcc 2.95.2 is buggy".
> 
> I just installed gcc 2.95.2 freshly ftp'ed from ftp.gnu.org, and
> 
> % /usr/bin/gcc -v
> Reading specs from /usr/lib/gcc-lib/i486-suse-linux/2.95.2/specs
> gcc version 2.95.2 19991024 (release)
> % /usr/bin/gcc -Wall -O2 -o bug bug.c; ./bug
> 0x84800000
> % /usr/gcc/aeb/bin/gcc -v
> Reading specs from /usr/gcc/aeb/lib/gcc-lib/i686-pc-linux-gnu/2.95.2/specs
> gcc version 2.95.2 19991024 (release)
> % /usr/gcc/aeb/bin/gcc -Wall -O2 -o nobug bug.c; ./nobug
> 0x0
> 
> So, not all versions of gcc 2.95.2 are equal.

I believe all 2.95.2's are equal in this, I think the fact that it gives 0
in the nobug case is some other reason:

$ for i in gcc kgcc '/usr/src/gcc-trunk/obj/gcc/xgcc -B /usr/src/gcc-trunk/obj/gcc/' '/usr/src/gcc-2.95.2/obj/gcc/xgcc -B /usr/src/gcc-2.95.2/obj/gcc/'; do $i -v; for j in -mcpu=i386 -mcpu=i586 -mcpu=i686; do $i $j -O2 -o aeb aeb.c; echo -n "$i $j "; ./aeb; done; done
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.0)
gcc -mcpu=i386 0x0
gcc -mcpu=i586 0x0
gcc -mcpu=i686 0x0
Reading specs from /usr/lib/gcc-lib/i386-glibc21-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
kgcc -mcpu=i386 0x0
kgcc -mcpu=i586 0x0
kgcc -mcpu=i686 0x0
Reading specs from /usr/src/gcc-trunk/obj/gcc/specs
Configured with:
gcc version 2.97 20001120 (experimental)
/usr/src/gcc-trunk/obj/gcc/xgcc -B /usr/src/gcc-trunk/obj/gcc/ -mcpu=i386 0x0
/usr/src/gcc-trunk/obj/gcc/xgcc -B /usr/src/gcc-trunk/obj/gcc/ -mcpu=i586 0x0
/usr/src/gcc-trunk/obj/gcc/xgcc -B /usr/src/gcc-trunk/obj/gcc/ -mcpu=i686 0x0
Reading specs from /usr/src/gcc-2.95.2/obj/gcc/specs
gcc version 2.95.2 19991024 (release)
/usr/src/gcc-2.95.2/obj/gcc/xgcc -B /usr/src/gcc-2.95.2/obj/gcc/ -mcpu=i386 0x84800000
/usr/src/gcc-2.95.2/obj/gcc/xgcc -B /usr/src/gcc-2.95.2/obj/gcc/ -mcpu=i586 0x84800000
/usr/src/gcc-2.95.2/obj/gcc/xgcc -B /usr/src/gcc-2.95.2/obj/gcc/ -mcpu=i686 0x0

so the reason why it did not show up in the gcc you picked up from
ftp.gnu.org is that you have compiled it so that it defaults to -mcpu=i686
where the bug does not show up.

	Jakub
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
