Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315451AbSELWsw>; Sun, 12 May 2002 18:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSELWsv>; Sun, 12 May 2002 18:48:51 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:28293 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S315426AbSELWss>;
	Sun, 12 May 2002 18:48:48 -0400
Message-ID: <007201c1fa07$2d7bd5d0$0201a8c0@witek>
From: "Witek Krecicki" <adasi@kernel.pl>
To: "Manfred Spraul" <manfred@colorfullife.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <3CDED21B.3050208@colorfullife.com>
Subject: Re: [BUG 2.5.X] Hollow processes
Date: Mon, 13 May 2002 00:48:46 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Manfred Spraul" <manfred@colorfullife.com>
> > It's impossible to check what the process is (trying to read
>  > /proc/{pid}/{anyting} causes reading process to hang in the
>  > same way (so we have now 2 hanging processes).
>
> Have you tried SysRQ+showTasks? That dumps the kernel stack. You can
> convert the numbers to names with ksymoops, or often klogd will convert
> them and the result is in /var/log/messages.
>
> What exactly hangs?
> Could you run
>
> strace ls /proc/1234
> strace cat /proc/1234/maps
> strace ls /proc/1234/fd -l
>
> Which syscall hangs?
> SMP or UP?
It's UP machine with UP kernel. I haven't tried it now strace'ing 'cat
/proc/1234/cmdline' (on 2.5.15) but as I remember from earlier kernels it
hanged on file reading processes. I'll try to make some additional tests as
soon as I'll be back from short vacation
ls'ing /proc/1234 doesn't hangs but ls -al does.
BTW: from my earlier post:
<cut>
mremap(0x407c5000, 8192, 12288, MREMAP_MAYMOVE) = 0x407c1000
brk(0x82e5000)                          = 0x82e5000
brk(0x82e6000)                          = 0x82e6000
old_mmap(NULL, 135168, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x407dc000
mremap(0x407ce000, 8192, 12288, MREMAP_MAYMOVE
</cut>
This is strace poldek on 2.5.11 kernel (behaviour is the same)
WK
P.S. now I can't reproduce it (on 2.5.15) as it's glibc compilation and it
takes far too long and has many subprocesses, but poldek issue on 2.5.11/12
was reproductible.
WK


