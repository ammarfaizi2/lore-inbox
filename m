Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315842AbSEOOFJ>; Wed, 15 May 2002 10:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316075AbSEOOFI>; Wed, 15 May 2002 10:05:08 -0400
Received: from jalon.able.es ([212.97.163.2]:7585 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315842AbSEOOFH>;
	Wed, 15 May 2002 10:05:07 -0400
Date: Wed, 15 May 2002 16:04:55 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Jan Nieuwenhuizen <janneke@gnu.org>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre8-ac3 -- thread_info?
Message-ID: <20020515140455.GA2186@werewolf.able.es>
In-Reply-To: <200205141244.g4ECi6P29886@devserv.devel.redhat.com> <87ptzxlnzn.fsf@peder.flower>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.15 Jan Nieuwenhuizen wrote:
>
>It seems that 2.4.19pre8-ac3 introduced the use of thread_info, but
>it's not defined in sched.h?
>
>Greetings,
>Jan.
>
>gcc -D__KERNEL__ -I/var/src/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -O2 -c -o sched.o sched.c
>sched.c: In function `migration_thread':
>sched.c:1595: structure has no member named `thread_info'
>sched.c:1600: structure has no member named `thread_info'
>sched.c:1606: structure has no member named `thread_info'
>sched.c:1574: warning: `cpu_src' might be used uninitialized in this function
>make[2]: *** [sched.o] Error 1
>

Sure it has been added ?
It can be the O1-sched patch or the O1-updates from rml, when extracted from
2.5 still use that.
Just change every occurence of:

p->thread_info->cpu

to

p->cpu.

Hope this helps.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre8-jam2 #3 SMP lun may 13 00:49:15 CEST 2002 i686
