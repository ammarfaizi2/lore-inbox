Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRBPG2I>; Fri, 16 Feb 2001 01:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRBPG17>; Fri, 16 Feb 2001 01:27:59 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:36107
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129219AbRBPG1r>; Fri, 16 Feb 2001 01:27:47 -0500
Date: Thu, 15 Feb 2001 22:27:36 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OTP] SMP board recommendations?
In-Reply-To: <Pine.LNX.4.30.0102152048450.2696-100000@ns-01.hislinuxbox.com>
Message-ID: <Pine.LNX.4.10.10102152213510.25463-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi David,

Just to let you and the rest of the world in on a secret, 'ASL, Inc.' is
the premier ATA server system builder.  Jeff Nguyen is the only person
that I knew two years ago that was a pioneer and I have shared some
information with him before in the past, but here is ATA and it it here to
stay.

Cheers,

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

******* shameless toys of creation to challenage the GB/$$ ******* 
http://www.aslab.com/contents/servers/Sovereign-3400T.html
http://www.aslab.com/contents/servers/Sovereign-3450T.html


On Thu, 15 Feb 2001, David D.W. Downey wrote:

> Thank you all for your response.
> 
> Andre (ASL), thanks for the assist. Laurie and Janine took care of me.
> Asus CUV4X-D mobo with 1GB of buffered ECC RAM. I'm in the process of
> transfering all the hardware to the new board. I'll let you know if this
> new board solves the APIC errors and the random lockups under heavy I/O
> problems.
> 
> I do have one more problem that I just can NOT track down.
> 
> 2.4.1-ac10 kernel on the old Abit VP6 mobo. I'm getting curious errors
> from the 2.4.1, 2.4.1-ac10, and 2.4.2-pre[#] kernels.
> 
> I've been using
> 
> dd if=/dev/zero of=/tmp/testdd.img bs=1024k count=1500
> 
> for testing of I/O on the various boards I have here. Now, the funny part
> is that I get "file size limit exceeded" at around 1.0GB. I was getting
> this under the 2.4.2-pre# kernels so i switched to straight 2.4.1 and got
> the same problem. I switched to the 2.4.1-ac# line and the problem
> disappeared. Guess what? It's baaacckk!
> 
> So, I did a strace of the dd command and got the following from it
> 
> execve("/bin/dd", ["dd", "if=/dev/zero", "of=/tmp/testing.img", "bs=1024k", "count=1500"], [/* 22 vars */]) = 0
> brk(0)                                  = 0x804e7b8
> open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
> open("/etc/ld.so.cache", O_RDONLY)      = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=7852, ...}) = 0
> old_mmap(NULL, 7852, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40015000
> close(3)                                = 0
> open("/lib/libc.so.6", O_RDONLY)        = 3
> fstat(3, {st_mode=S_IFREG|0755, st_size=1183326, ...}) = 0
> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\215"..., 4096) = 4096
> old_mmap(NULL, 947548, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40017000
> mprotect(0x400f7000, 30044, PROT_NONE)  = 0
> old_mmap(0x400f7000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xdf000) = 0x400f7000
> old_mmap(0x400fb000, 13660, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x400fb000
> close(3)                                = 0
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x400ff000
> mprotect(0x40017000, 917504, PROT_READ|PROT_WRITE) = 0
> mprotect(0x40017000, 917504, PROT_READ|PROT_EXEC) = 0
> munmap(0x40015000, 7852)                = 0
> personality(PER_LINUX)                  = 0
> getpid()                                = 195
> brk(0)                                  = 0x804e7b8
> brk(0x804e7f0)                          = 0x804e7f0
> brk(0x804f000)                          = 0x804f000
> open("/dev/zero", O_RDONLY|O_LARGEFILE) = 3
> open("/tmp/testing.img", O_RDWR|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 4
> rt_sigaction(SIGINT, NULL, {SIG_DFL}, 8) = 0
> rt_sigaction(SIGINT, {0x804ada8, [], 0x4000000}, NULL, 8) = 0
> rt_sigaction(SIGQUIT, NULL, {SIG_DFL}, 8) = 0
> rt_sigaction(SIGQUIT, {0x804ada8, [], 0x4000000}, NULL, 8) = 0
> rt_sigaction(SIGPIPE, NULL, {SIG_DFL}, 8) = 0
> rt_sigaction(SIGPIPE, {0x804ada8, [], 0x4000000}, NULL, 8) = 0
> rt_sigaction(SIGUSR1, NULL, {SIG_DFL}, 8) = 0
> rt_sigaction(SIGUSR1, {0x804ae70, [], 0x4000000}, NULL, 8) = 0
> old_mmap(NULL, 1052672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40100000
> read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = 1048576
> write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = 1048576
> 
> ********* BIG ASS SNIP **********
> 
> read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = 1048576
> write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = -1 EFBIG (File too large)
> --- SIGXFSZ (File size limit exceeded) ---
> +++ killed by SIGXFSZ +++
> 
> 
> 
> Now, notice the beginning file creation call. It starts out with
> O_LARGEFILE but ends with EFBIG. Since I'm not totally familiar with the
> kernel code I could be wrong on my next statement and if I am, please tell
> me, but it looks like it changes the file creation call from LARGEFILE to
> EFBIG (or is this just the error call itself?)
> 
> Now, the kernel is supposed to be able to handle creating a 4TB file(?),
> so 1.0GB should be nothing to it. NOTHING changed betwen it working and
> not working. No hardware changes, no software additions, no recompiles of
> existing applications/daemons.. nothing.
> 
> So, my question is now one of "What gives?" Any clues on how I can check
> to see what's going wrong? Is my gut feeling that it's changing the file
> type wrong? (IIUC, there are different open() calls for different size
> files? No, I have nothing to base this one, just something I flashed on
> and thought might explain the problem.)
> 
> I'm learning here guys, so please be gentle. You folks are the only ones I
> have with the experience to tell me when I'm just fscked in the head and
> when I'm bang on.
> 
> -- 
> David D.W. Downey - RHCE
> Consulting Engineer
> Ensim Corporation - Sunnyvale, CA
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


