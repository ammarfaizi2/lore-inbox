Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266827AbRIHIyZ>; Sat, 8 Sep 2001 04:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267043AbRIHIyP>; Sat, 8 Sep 2001 04:54:15 -0400
Received: from imo-d08.mx.aol.com ([205.188.157.40]:23504 "EHLO
	imo-d08.mx.aol.com") by vger.kernel.org with ESMTP
	id <S266827AbRIHIyC>; Sat, 8 Sep 2001 04:54:02 -0400
From: Floydsmith@aol.com
Message-ID: <109.548ddae.28cb3697@aol.com>
Date: Sat, 8 Sep 2001 04:53:43 EDT
Subject: Re1: LOADLIN and 2.4 kernels
To: hpa@transmeta.com
CC: linux-kernel@vger.kernel.org, Floydsmith@aol.com
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 4.0 for Windows 95 sub 14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Hi everyone,
>
>I got a bug report of LOADLIN not working with recent -ac kernels, and
>thought it might have something to do with my recent A20 changes that
>were added to -ac.  However, in trying to reproduce this bug, I have
>been completely unable to boot *any* 2.4 kernel with LOADLIN-1.6, trying
>this from Win98 DOS mode.
>
>Anyone have any insight into this?  I really don't understand how the
>A20 changes could affect LOADLIN, and it's starting to look to me that
>there is some other problem going on...
>
>        -hpa

You do not specify exactly what your problem is (error message, where, etc.) 
so I am not sure I can help you or not. I had a problem with 2.2x kernels 
booting but not any 2.4.x ones with loadlin but only when "initrd" (ramdisk 
as "root" filesystem) was used. The symptom was the kernel would attempt to 
load but a insuficient memory error (I think it said you must have at least 
4MB) then it would hang. If you have this problem and if you exactly 64MB of 
ram, then what seems to happen is loadlin probes for and finds the correct 
amount of memory. Then it loads the 2.4.x kernel into a buffer. The kernel 
then attempts boot just the "boot" sector stuff. This again probes for the 
total amount of system ram (64MB). But, because of the much greater size of 
2.4.x kernels some memory location that himem uses (I think - maybe BIOS 
though) in relation to "memory size determination" gets over wiritten when 
loadlin filed the "buffer". The only workaround I have found so far for this 
is to pass on the loadlin command line the extra "boot param" of:
    mem=64M
so that the kernel does not probe.

Floyd,
