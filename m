Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318627AbSHAFbe>; Thu, 1 Aug 2002 01:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318630AbSHAFbe>; Thu, 1 Aug 2002 01:31:34 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:59014 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S318627AbSHAFbd>; Thu, 1 Aug 2002 01:31:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.19-rc4
Date: Thu, 1 Aug 2002 07:40:39 +0200
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.44.0207311819060.1026-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.44.0207311819060.1026-100000@freak.distro.conectiva>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020801053133Z318627-685+21899@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 July 2002 23:20, Marcelo Tosatti wrote:
> Hi,
>
> Since some critical problems appeared (mainly the d_unhash() SMP race)
> here is rc4.
>

Found these warnings when compiling:

gcc -D__KERNEL__ -I/home/rudmer/src/kernel/linux-2.4.19-rc4/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4    -nostdinc -I 
/usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/include -DKBUILD_BASENAME=setup  -c 
-o setup.o setup.c
setup.c: In function `amd_adv_spec_cache_feature':
setup.c:751: warning: implicit declaration of function `have_cpuid_p'
setup.c: At top level:
setup.c:2629: warning: `have_cpuid_p' was declared implicitly `extern' and 
later `static'
setup.c:751: warning: previous declaration of `have_cpuid_p'
<snip>
gcc -D__KERNEL__ -I/home/rudmer/src/kernel/linux-2.4.19-rc4/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4    -nostdinc -I 
/usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/include -DKBUILD_BASENAME=pci_pc  
-c -o pci-pc.o pci-pc.c
{standard input}: Assembler messages:
{standard input}:1066: Warning: indirect lcall without `*'
{standard input}:1151: Warning: indirect lcall without `*'
{standard input}:1238: Warning: indirect lcall without `*'
{standard input}:1311: Warning: indirect lcall without `*'
{standard input}:1322: Warning: indirect lcall without `*'
{standard input}:1333: Warning: indirect lcall without `*'
{standard input}:1410: Warning: indirect lcall without `*'
{standard input}:1422: Warning: indirect lcall without `*'
{standard input}:1434: Warning: indirect lcall without `*'
{standard input}:1914: Warning: indirect lcall without `*'
{standard input}:2019: Warning: indirect lcall without `*'
<snip>
gcc -D__KERNEL__ -I/home/rudmer/src/kernel/linux-2.4.19-rc4/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4    -nostdinc -I 
/usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/include -DKBUILD_BASENAME=apm  -c 
-o apm.o apm.c
{standard input}: Assembler messages:
{standard input}:237: Warning: indirect lcall without `*'
{standard input}:331: Warning: indirect lcall without `*'

output from scripts/ver_linux:
Linux gandalf 2.4.19-rc3-ac4 #2 Wed Jul 31 21:23:51 CEST 2002 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11q
mount                  2.11q
modutils               2.4.16
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0

my binutils is 2.12 and the script does not mention it... if I change the 
scripts binutils 'detection' to:
 ld -v 2>&1 | awk 'NR==1 {print "binutils              ",$4}'
then it gets listed.

	Rudmer
