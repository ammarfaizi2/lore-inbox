Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263303AbSJGWzO>; Mon, 7 Oct 2002 18:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262748AbSJGWyb>; Mon, 7 Oct 2002 18:54:31 -0400
Received: from marob.cust.panix.com ([166.84.191.66]:52098 "HELO
	marob.cust.panix.com") by vger.kernel.org with SMTP
	id <S263121AbSJGWxw>; Mon, 7 Oct 2002 18:53:52 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: make modules fails with 2.5.41 in scsi/ppa
From: rcliff@panix.com (Robert Clifford)
Reply-To: rcliff@panix.com (Robert Clifford)
X-Phone: 212 924-2812 (Data 675-7059)
X-Organization: ESCC, New York City
X-Face: ByE+UMAp1klWR3?\RNGx(A-~Ri!YT%C6M!sxoJL+.;9`Q/|+dj7[KR>gGMyV.2qZeot0NI`4\MA^_Qg`F9=+Ox&zaE?Y9dV%F~Xzf';Zyk2Aobs.uu^Ey0_C6^~q';G#$HkA!ZAHXPpG-"*|Dd*Z4U$4y{{aI0c%75}i~Of(jxYtI[uIpYF<*Zoe|\*/ufb
References: <20021007214904.19683.qmail@marob.cust.panix.com>
In-Reply-To: <20021007214904.19683.qmail@marob.cust.panix.com> (rcliff@panix.com's
 message of "7 Oct 2002 17:49:04 -0400, Mon, 7 Oct 2002 17:49:04 -0400
 (EDT)")
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.5 (brussels sprouts,
 i686-pc-linux)
Date: Mon, 07 Oct 2002 18:59:30 -0400
Message-ID: <ufptullust.fsf@marob.cust.panix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And if I remove #include <linux/tqueue.h> from ppa.h: 
(routine (ppa.c line 56) was in tqueue.h:
struct tq_struct {
        struct list_head list;          /* linked list of active bh's */
        unsigned long sync;             /* must be initialized to zero */
        void (*routine)(void *);        /* function to call */
        void *data;                     /* argument to function */
}; )

-----------------

make -f drivers/scsi/Makefile
  gcc -Wp,-MD,drivers/scsi/.ppa.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE -include include/linux/modversions.h   -DKBUILD_BASENAME=ppa   -c -o drivers/scsi/ppa.o drivers/scsi/ppa.c
drivers/scsi/ppa.c:32: field `ppa_tq' has incomplete type
drivers/scsi/ppa.c:56: warning: braces around scalar initializer
drivers/scsi/ppa.c:56: warning: (near initialization for `ppa_hosts[0].ppa_tq')
drivers/scsi/ppa.c:56: unknown field `routine' specified in initializer
drivers/scsi/ppa.c:56: invalid initializer
drivers/scsi/ppa.c:56: (near initialization for `ppa_hosts[0].ppa_tq')
drivers/scsi/ppa.c:56: initializer element is not constant
drivers/scsi/ppa.c:56: (near initialization for `ppa_hosts[0].ppa_tq')
drivers/scsi/ppa.c:56: initializer element is not constant
drivers/scsi/ppa.c:56: (near initialization for `ppa_hosts[0]')
drivers/scsi/ppa.c:56: warning: braces around scalar initializer
drivers/scsi/ppa.c:56: warning: (near initialization for `ppa_hosts[1].ppa_tq')
drivers/scsi/ppa.c:56: unknown field `routine' specified in initializer
drivers/scsi/ppa.c:56: invalid initializer
drivers/scsi/ppa.c:56: (near initialization for `ppa_hosts[1].ppa_tq')
drivers/scsi/ppa.c:56: initializer element is not constant
drivers/scsi/ppa.c:56: (near initialization for `ppa_hosts[1].ppa_tq')
drivers/scsi/ppa.c:56: initializer element is not constant
drivers/scsi/ppa.c:56: (near initialization for `ppa_hosts[1]')
drivers/scsi/ppa.c:56: warning: braces around scalar initializer
drivers/scsi/ppa.c:56: warning: (near initialization for `ppa_hosts[2].ppa_tq')
drivers/scsi/ppa.c:56: unknown field `routine' specified in initializer
drivers/scsi/ppa.c:56: invalid initializer
drivers/scsi/ppa.c:56: (near initialization for `ppa_hosts[2].ppa_tq')
drivers/scsi/ppa.c:56: initializer element is not constant
drivers/scsi/ppa.c:56: (near initialization for `ppa_hosts[2].ppa_tq')
drivers/scsi/ppa.c:56: initializer element is not constant
drivers/scsi/ppa.c:56: (near initialization for `ppa_hosts[2]')
drivers/scsi/ppa.c:56: warning: braces around scalar initializer
drivers/scsi/ppa.c:56: warning: (near initialization for `ppa_hosts[3].ppa_tq')
drivers/scsi/ppa.c:56: unknown field `routine' specified in initializer
drivers/scsi/ppa.c:56: invalid initializer
drivers/scsi/ppa.c:56: (near initialization for `ppa_hosts[3].ppa_tq')
drivers/scsi/ppa.c:56: initializer element is not constant
drivers/scsi/ppa.c:56: (near initialization for `ppa_hosts[3].ppa_tq')
drivers/scsi/ppa.c:56: initializer element is not constant
drivers/scsi/ppa.c:56: (near initialization for `ppa_hosts[3]')
drivers/scsi/ppa.c: In function `ppa_interrupt':
drivers/scsi/ppa.c:804: warning: implicit declaration of function `schedule_delayed_work_Rd3dad18a'
drivers/scsi/ppa.c: In function `ppa_queuecommand':
drivers/scsi/ppa.c:989: warning: implicit declaration of function `schedule_work_Rf6a5a6c8'
make[2]: *** [drivers/scsi/ppa.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2




rcliff@panix.com writes:

> slackware-8.1: gcc 2.95.3; intel pentuum4
>
> Here is the error when I do "make modules" from a clean 2.5.41:
>
>
> 05:06pm{/usr/src/linux}# make modules
> .....
> make -f drivers/scsi/Makefile
>   gcc -Wp,-MD,drivers/scsi/.ppa.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE -include include/linux/modversions.h   -DKBUILD_BASENAME=ppa   -c -o drivers/scsi/ppa.o drivers/scsi/ppa.c
> In file included from drivers/scsi/ppa.c:52:
> drivers/scsi/ppa.h:81: linux/tqueue.h: No such file or directory
....
> make[1]: *** [drivers/scsi] Error 2
> make: *** [drivers] Error 2

-- 
Robert Clifford, ESCC New York City                         rcliff@panix.com
"I think I've got the hang of it now .... :w :q :wq :wq!  ^d  X  exit  X   Q 
:quitbye CtrlAltDel  ~~q :~q logout save/quit :!QUIT ^[zz  ^[ZZ ZZZZ ^H ^@ ^L
^[c ^# ^E ^X ^I ^T ? help helpquit ^D^d ^C ^c help exit ?Quit ?q" (Ed Wright)
