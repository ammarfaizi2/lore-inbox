Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131369AbRAJA7b>; Tue, 9 Jan 2001 19:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131958AbRAJA7V>; Tue, 9 Jan 2001 19:59:21 -0500
Received: from saraksh.alkar.net ([195.248.191.65]:48650 "EHLO smtp3.alkar.net")
	by vger.kernel.org with ESMTP id <S131369AbRAJA7D>;
	Tue, 9 Jan 2001 19:59:03 -0500
Message-ID: <3A5BB340.9EA8B5C3@namesys.botik.ru>
Date: Wed, 10 Jan 2001 03:56:32 +0300
From: "Vladimir V. Saveliev" <vs@namesys.botik.ru>
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Lehmann <pcg@goof.com>
CC: BUGTRAQ@SECURITYFOCUS.COM, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] major security bug in reiserfs (may affect SuSE 
 Linux)
In-Reply-To: <20010110004201.A308@cerebro.laendle>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Marc Lehmann wrote:

> We are still investigating, but there seems to be a major security problem
> in at least some versions of reiserfs. Since reiserfs is shipped with
> newer versions of SuSE Linux and the problem is too easy to reproduce and
> VERY dangerous I think alerting people to this problem is in order.
>
> We have tested and verified this problem on a number of different systems
> and kernels 2.2.17/2.2.8 with reiserfs-3.5.28 and probably other versions.
>
> Basically, you do:
>
> mkdir "$(perl -e 'print "x" x 768')"
>
> I.e. create a very long directory. The name doesn't seem to be of
> relevance (we found this out by doing mkdir "$(cat /etc/hosts)" for other
> tests). This works.  The next ls (or echo *) command will segfault and the
> kernel oopses. all following accesses to the volume in question will oops
> and hang the process, even afetr a reboot.
>

Hmm,
mkdir "$(perl -e 'print "x" x 768')"
ls
echo *

works here as it should. (2.2.18 and reiserfs-3.5.29)

Did I miss something?

Thanks,
vs



>
> reiserfsck (the filesystem check program) does _NOT_ detect or solve this
> problem:
>
> Replaying journal..ok
> Checking S+tree..ok
> Comparing bitmaps..ok
>
> But fortunately, rmdir <filename> works and seems to leave the filesystem
> undamaged.
>
> Since a kernel oops results (see below), this indicates a buffer overrun
> (the kernel jumps to address 78787878, which is "xxxx") inside the kernel,
> which is of course very nasty (think ftp-upload!) and certainly gives you
> root access from anywhere, even from inside a chrooted environment. We
> didn't pursue this further.
>
> The best workaround at this time seems to be to uninstall reiserfs
> completely or not allow any user access (even indirect) to these volumes.
> While this individual bug might be easy to fix, we believe that other,
> similar bugs should be easy to find so reiserfs should not be trusted (it
> shouldn't be trusted to full user access for other reasons anyway, but it
> is still widely used).
>
> Unable to handle kernel paging request at virtual address 78787878
> current->tss.cr3 = 0d074000, %cr3 = 0d074000
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c013f875>]
> EFLAGS: 00010282
> eax: 00000000   ebx: bfffe78c   ecx: 00000000   edx: bfffe78c
> esi: ccbddd62   edi: 78787878   ebp: 00000300   esp: ccbddd3c
> ds: 0018   es: 0018   ss: 0018
> Process bash (pid: 292, process nr: 54, stackpage=ccbdd000)
> Stack: c013f66a ccbddf6c cd100000 ccbddd62 0000030c c0136d49 00000700 00002013
>        00001000 7878030c 78787878 78787878 78787878 78787878 78787878 78787878
>        78787878 78787878 78787878 78787878 78787878 78787878 78787878 78787878
> Call Trace: [<c013f66a>] [<c0136d49>]
> Code: 89 1f 8b 44 24 18 29 47 08 31 c0 5b 5e 5f 5d 81 c4 2c 01 00
>
> --
>       -----==-                                             |
>       ----==-- _                                           |
>       ---==---(_)__  __ ____  __       Marc Lehmann      +--
>       --==---/ / _ \/ // /\ \/ /       pcg@opengroup.org |e|
>       -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
>     The choice of a GNU generation                       |
>                                                          |

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
