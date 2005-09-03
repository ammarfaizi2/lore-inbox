Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbVICPgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbVICPgp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 11:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbVICPgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 11:36:44 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:37532 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1750866AbVICPgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 11:36:44 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Date: Sat, 3 Sep 2005 18:36:22 +0300
User-Agent: KMail/1.8.2
Cc: andersen@codepoet.org, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050903042859.GA30101@codepoet.org> <AFDE003F-F14F-42CE-B964-2E04A4402406@mac.com>
In-Reply-To: <AFDE003F-F14F-42CE-B964-2E04A4402406@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509031836.22357.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 September 2005 08:55, Kyle Moffett wrote:
> On Sep 3, 2005, at 00:28:59, Erik Andersen wrote:
> >> Absolutely not.  This would be a POSIX namespace violation; they
> >> *must* use double-underscore types.
> >
> > I assume you are worried about the stuff under asm that ends up
> > being included by nearly every header file in the world.  Of
> > course asm must use double-underscore types.  But the thing is,
> > the vast majority of the kernel headers live under
> > linux/include/linux/ and do not use double-underscore types, they
> > use kernel specific, non-underscored types such as s8, u32, etc.
> > My copy of IEEE 1003.1 and my copy of ISO/IEC 9899:1999 both fail
> > to prohibit using the shiny new ISO C99 type for the various
> > #include <linux/*> header files, which is what I was suggesting.
> 
> Anything in linux/* that is included by userspace should not
> presume that stdint.h has already been included or include it on
> its own, because the userspace program may have already made its
> own definitions of uint32_t, or it may not want them defined at
> all.

Is this an excercise in academia? Userspace app which defines
uint32_t to anything different than 'typedef <appropriate int type>'
deserves the punishment, and one which does have such typedef
instead of #include stdint.h will not notice.

All these u32, uint32_t, __u32 end up typedef'ing to same
integer type anyway...

Why should we care of such 'struct uint32_t { ... };' pervert cases?
If we will do, I suspect we will end up with __________u32's.
We already have a lot of __'s:

linux/cache.h:#define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
linux/rcupdate.h:                             typeof(p) _________p1 = p; \

*three underscores* line count over kernel's include/:

# grep -r ___ . | wc -l
10129

and "only" two underscores:

# grep -r __ . | wc -l
72216
--
vda
