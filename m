Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315536AbSEHGc5>; Wed, 8 May 2002 02:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315537AbSEHGc4>; Wed, 8 May 2002 02:32:56 -0400
Received: from rj.SGI.COM ([192.82.208.96]:52440 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S315536AbSEHGc4>;
	Wed, 8 May 2002 02:32:56 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alexander.Riesen@synopsys.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "Mon, 06 May 2002 12:54:35 +0200."
             <20020506105435.GA1044@riesen-pc.gr05.synopsys.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 May 2002 12:54:39 +1000
Message-ID: <4647.1020826479@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2002 12:54:35 +0200, 
Alex Riesen <Alexander.Riesen@synopsys.com> wrote:
>On Thu, May 02, 2002 at 12:23:33AM +1000, Keith Owens wrote:
>> Linus, kbuild 2.5 is ready for inclusion in the main 2.5 kernel tree.
>> It is faster, better documented, easier to write build rules in, has
>> better install facilities, allows separate source and object trees, can
>> do concurrent builds from the same source tree and is significantly
>> more accurate than the existing kernel build system.
>
>I do not like the new(core-11) "make *config" behaviour. Now it starts
>build immediately after finishing, make xconfig effectively does
>make xconfig installabled. I usually cook up the .config first, and
>than decide when to compile the kernel. Now i have to interrupt the
>build.

I do not see either of these symptoms, and nobody else has reported
them.

# make -f $KBUILD_SRCTREE_000/Makefile-2.5 xconfig
Using ARCH='i386' AS='as' LD='ld' CC='/usr/bin/gcc' CPP='/usr/bin/gcc -E' AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
Generating global Makefile
  phase 1 (find all inputs)
  (cd /build/kaos/object-2.5.14/.tmp_config/links/ && /build/kaos/object-2.5.14/scripts/tkparse < config.in-2.5) >> /build/kaos/object-2.5.14/scripts/kconfig.tk

xconfig menu displays, clicking save and exit ends xconfig and drops
back to the command prompt, it does not do anything else.

>"make oldconfig" is broken btw, if the .config contains something
>unknown (i.e. NEW). It used to ask for possible choices before.

# make -f $KBUILD_SRCTREE_000/Makefile-2.5 oldconfig
Using ARCH='i386' AS='as' LD='ld' CC='/usr/bin/gcc' CPP='/usr/bin/gcc -E' AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
Generating global Makefile
  phase 1 (find all inputs)
#
# Using defaults found in .config
#
*
* Code maturity level options
*
Prompt for development and/or incomplete code/drivers (CONFIG_EXPERIMENTAL) [N/y/?] 
*
* General setup
*
Networking support (CONFIG_NET) [N/y/?] 
System V IPC (CONFIG_SYSVIPC) [N/y/?] 
BSD Process Accounting (CONFIG_BSD_PROCESS_ACCT) [N/y/?] 
Sysctl support (CONFIG_SYSCTL) [N/y/?] 
*
* Loadable module support
*
Enable loadable module support (CONFIG_MODULES) [Y/n/?] 
  Set version information on all module symbols (CONFIG_MODVERSIONS) [N/y/?] 
  Kernel module loader (CONFIG_KMOD) [N/y/?] (NEW) 

Works for me.

