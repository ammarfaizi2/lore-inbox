Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291935AbSBNWCk>; Thu, 14 Feb 2002 17:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291942AbSBNWCa>; Thu, 14 Feb 2002 17:02:30 -0500
Received: from out019pub.verizon.net ([206.46.170.98]:3033 "EHLO
	out019.verizon.net") by vger.kernel.org with ESMTP
	id <S291935AbSBNWCR>; Thu, 14 Feb 2002 17:02:17 -0500
Date: Thu, 14 Feb 2002 17:00:19 -0500
From: Skip Ford <skip.ford@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG?] -- Kernel compilation on v2.5.4 source breaks
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202141625030.31418-200000@dodobirdy.netcraft.com.my>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0202141625030.31418-200000@dodobirdy.netcraft.com.my>; from julian@netwxs.com.my on Thu, Feb 14, 2002 at 04:31:53PM +0800
Message-Id: <20020214220216.SXFO379.out019.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Julian Gomez wrote:
> 
> The error is :
> 
> -- start here --
> 
> make[1]: Entering directory `/network-fs/linux-2.5.4/arch/i386/kernel'
> gcc -D__KERNEL__ -I/network-fs/linux-2.5.4/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686   -DKBUILD_BASENAME=process  -c -o process.o process.c
> process.c:60: parse error before `unsigned'
> make[1]: *** [process.o] Error 1
> make[1]: Leaving directory `/network-fs/linux-2.5.4/arch/i386/kernel'
> make: *** [_dir_arch/i386/kernel] Error 2
> 
> -- end here --
> 
> on a pristine v2.5.4 with the patch for processor.h from David Howell's
> applied. Configuration file is attached to this message. Same

Well, you're saying 2.5.4 but that error is what you get if you apply
2.5.5-pre1 to a tree that has the processor.h patch already applied.

You need to change the following line in processor.h:
'#define thread_saved_pc(TSK) (((unsigned long*)(TSK)->thread.esp)[3])'

to:

'extern unsigned long thread_saved_pc(struct task_struct *tsk);'

- -- 
Skip  ID: 0x7EDDDB0A
-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAjxsM18ACgkQBMKxVH7d2wptawCfdWCv2uZxRfHibIpx3uryRQWj
6DcAnRqqdkzlDFL5ZAt8DiYsBE/62sxX
=fZfn
-----END PGP SIGNATURE-----
