Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314041AbSEHR0L>; Wed, 8 May 2002 13:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314383AbSEHR0K>; Wed, 8 May 2002 13:26:10 -0400
Received: from boden.synopsys.com ([204.176.20.19]:44181 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S314041AbSEHR0J>; Wed, 8 May 2002 13:26:09 -0400
Date: Wed, 8 May 2002 19:25:57 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Message-ID: <20020508172557.GB1044@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020506105435.GA1044@riesen-pc.gr05.synopsys.com> <4647.1020826479@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 12:54:39PM +1000, Keith Owens wrote:
> On Mon, 6 May 2002 12:54:35 +0200, 
> Alex Riesen <Alexander.Riesen@synopsys.com> wrote:
> >On Thu, May 02, 2002 at 12:23:33AM +1000, Keith Owens wrote:
> >> Linus, kbuild 2.5 is ready for inclusion in the main 2.5 kernel tree.
> >> It is faster, better documented, easier to write build rules in, has
> >> better install facilities, allows separate source and object trees, can
> >> do concurrent builds from the same source tree and is significantly
> >> more accurate than the existing kernel build system.
> >
> >I do not like the new(core-11) "make *config" behaviour. Now it starts
> >build immediately after finishing, make xconfig effectively does
> >make xconfig installabled. I usually cook up the .config first, and
> >than decide when to compile the kernel. Now i have to interrupt the
> >build.
> 
> I do not see either of these symptoms, and nobody else has reported
> them.

i've found the reason: the make's stdin was redirected in /dev/null
(my make is aliased to a program prettifying output).
It still starts to compile immediately after *config, though.

/compile/kb-test-o gmake -f ../kb-test/Makefile-2.5 xconfig
Using ARCH='i386' AS='as' LD='ld' CC='/usr/bin/gcc' CPP='/usr/bin/gcc -E' AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
Generating global Makefile
  phase 1 (find all inputs)
(cd /export/home/riesen-pc0/riesen/compile/kb-test-o/.tmp_config/links/ && /export/home/riesen-pc0/riesen/compile/kb-test-o/scripts/tkparse < config.in-2.5) >> /export/home/riesen-pc0/riesen/compile/kb-test-o/scripts/kconfig.tk
<pressed "Save&Exit" here...>
  phase 2 (convert all Makefile.in files)
  phase 3 (evaluate selections)
  phase 4 (integrity checks, write global makefile)
Starting phase 5 (build) for installable
  CC arch/i386/kernel/setup.o
...
looks like my *config targets aren't like yours and belong to phase5
targets 8)

-alex

