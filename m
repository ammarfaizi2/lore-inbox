Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbTIDPH2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 11:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbTIDPH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 11:07:28 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:55813 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S265031AbTIDPHZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 11:07:25 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Yann Droneaud <yann.droneaud@mbda.fr>,
       fruhwirth clemens <clemens-dated-1063536166.2852@endorphin.org>
Subject: Re: nasm over gas?
Date: Thu, 4 Sep 2003 22:57:12 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <20030904104245.GA1823@leto2.endorphin.org> <3F5741BD.5000401@mbda.fr>
In-Reply-To: <3F5741BD.5000401@mbda.fr>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309042257.12739.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 September 2003 21:44, Yann Droneaud wrote:
> fruhwirth clemens wrote:
> > Hi!
> >
> > I recently posted a module for twofish which implements the algorithm in
> > assembler
> > (http://marc.theaimsgroup.com/?l=linux-kernel&m=106210815132365&w=2)
> >
> > Unfortunately the assembler used is masm. I'd like to change that.
> > Netwide Assembler (nasm) is the assembler of my choice since it focuses
> > on portablity and has a more powerful macro facility (macros are heavily
> > used by 2fish_86.asm). But as I'd like to make my work useful (aim for an
> > inclusion in the kernel) I noticed that this would be the first module to
> > depend on nasm. Everything else uses gas.
> >
> > So the question is: Is a patch which depends on nasm likely to be merged?
>
> I hope no ...
>
> Some years ago, we converted the only part of the kernel that used as86
> to GNU as: see arch/i386/boot. I think this was an improvement.
> Using nasm for only one small piece of code would be a regression, imho.
>

Concur, not worthwhile to start using a fairly unsupported tool in the kernel.

As to using assembler, It is better to get rid of it but in special cases.
Todays compilers are the better coders in 98+% of applications, and if you
follow some of the discussions here on the list, you will be amazed what 
people do with a C compiler - all portable and much more maintainable.

I guess your code should be 80-90% C and 10-20% assmbler. This will make it
up to 10 times a portable.   

As to using nasm, note for gas and gcc 3.2+:

+ GAS does intel syntax too using  the directive
   .intel_syntax

+ GCC can do intel syntax asm output as well, tried
  it on some mid size apps - it works fine.

As to "abuse" of macros, macros beyond C-style pre-processing are generaly 
obsolete, better use C, or write an app-specific front end. 

I did the latter to "preprocess" a common source, running 16 bit/embedded 
source through wasm and 32bit/linux source through gas. 

Regards
Michael

