Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130187AbQKNPU0>; Tue, 14 Nov 2000 10:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130210AbQKNPUQ>; Tue, 14 Nov 2000 10:20:16 -0500
Received: from lsne-cable-1-p21.vtxnet.ch ([212.147.5.21]:62222 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S130187AbQKNPT7>;
	Tue, 14 Nov 2000 10:19:59 -0500
Date: Tue, 14 Nov 2000 15:49:53 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: Linux rebooting directly into linux.
Message-ID: <20001114154953.E8753@almesberger.net>
In-Reply-To: <m17l6deey7.fsf@frodo.biederman.org> <20001111171158.B17692@progenylinux.com> <m1bsvmcb4z.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1bsvmcb4z.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sat, Nov 11, 2000 at 05:00:28PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> There are a couple of differences.  
> But the big one is I'm trying to do it right.

So why do you need a file-based interface then ? ;-)

Since this is a highly privileged operation anyway, you may as
well trust user space to use the right data format ...

I get the impression that you incur quite a lot of overhead just
to make it fit with the exec interface. I agree that it's
conceptually nice, and it looks cleanly done, but I don't quite
see the practical value. (Except, perhaps, that this allowed you
to pick the rather cute name "kexec" ;-)

> Additionally mine is the only one that has a real chance of booting
> a non-linux kernel.

Hmm, I think all approaches could boot a non-Linux kernel, but ...

As far as loading is concerned, bootimg probably has an advantage
there, because you can put things together in memory (e.g. some
OS-specific chain loader), without going to secondary storage.
(Proof of concept: bootimg is able to load all currently supported
kernel image formats on ia32.)

As far as execution is concerned, you're probably slightly better
off with an approach that goes back to real mode. (Or use a chain
loader - this can be transparent to the kernel.) But then, I'm not
sure if you can re-animate the BIOS in any consistent way, so your
choice of operating systems may be quite limited, or you have to
provide your own BIOS substitute.

Concerning complexity, you don't need to use assembler for the
copying (arch/i386/kernel/relocate_kernel.S), see bootimg,
kernel/bootimg_pic.c

Also, why did you implement your own memory management in
fs/kexec.c:kimage_get_chunk ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
