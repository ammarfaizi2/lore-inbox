Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbTJWXGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 19:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTJWXGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 19:06:00 -0400
Received: from [212.97.163.22] ([212.97.163.22]:48354 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S261842AbTJWXFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 19:05:55 -0400
Date: Fri, 24 Oct 2003 01:05:42 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "Joseph D. Wagner" <theman@josephdwagner.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86 Architecture
Message-ID: <20031023230542.GC2084@werewolf.able.es>
References: <200310221855.15925.theman@josephdwagner.info>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200310221855.15925.theman@josephdwagner.info> (from theman@josephdwagner.info on Wed, Oct 22, 2003 at 14:55:15 +0200)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


On 10.22, Joseph D. Wagner wrote:
> Yes, I know you can select Pentium III, Pentium 4, Athlon, etc, under 
> processor type when doing a 'make xconfig', but those selections do not 
> translate into the appropriate -mcpu and -march flags.
> 
> While the kernel on x86 architecture can be optimized in terms of generic 
> processor specifications (i.e. i386, i486, i586, i686), the kernel can't be 
> optimized beyond a i686.
> 
> If you select Pentium III, the -march flag is set to i686.
> If you select Pentium 4, the -march flag is set to i686.
> If you select Athlon 4, the -march flag is set to i686.
> If you select Athlon XP, the -march flag is set to i686.
> 
> It should be that...
> 
> If you select Pentium III, the -march flag is set to pentium3.
> If you select Pentium 4, the -march flag is set to pentium4.
> If you select Athlon 4, the -march flag is set to athlon-4.
> If you select Athlon XP, the -march flag is set to athlon-xp.
> 
> I don't want to have to hand edit the makefiles just to optimize my kernel.  
> I think this change is simple enough to do, and would allow kernel 
> developers the option of processor-specific optimizations in the future.
> 
> TIA.
> 
> Joseph D. Wagner

I have sent the attached patches sometimes to the list/Marcelo, and they
have been rejected to the moment because:
- gcc can spit some new instructions, reorganize code and other things when
  you jump from i686 to pentium3, for example.
- There can be bugs both in gcc and in the kernel that can be triggered by
  >i686 optimizations/code.
- This is not safe for a stable kernel, it was done in 2.5, bugs appeared,
  were corrected, and so on, 'cause this was a development kernel.

BTW, I use this regularly, and have not found any bugs, but I admit it is
unsafe. I also advocate for a pII split (I use a dual PII ;).
There are some other specific code that could be used in the kernel,
for example mb() and so on can be implemented with {m,s,l}fence in p3/p4
processors, instead of the old 'lock; insn' (attached also).

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre7-jam2 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk))

--VbJkn9YxBvnuCH5J
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="22-x86-mb.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWUlUb/EAAOVfgEIwXn//+mvv38q//9/gUAN+O1gAAlhqaKaDIaNGJkA0NANN
A0AGgA0HNMjIZMENGEwRpo0YgaZMjAAEEpqNQ1R6mmnqZMj1MgGg0AADQBkAHNMjIZMENGEw
Rpo0YgaZMjAAECqJGgTTRNT0k9Tym1GZR6maI0DaRtTNJjRPSaWjgOv3T69FUm/1/RzJYKd7
1cXsfrPj1M7MnYztsMMuy/GMYYcjHc218VnPNRa4vtmwJGBJ/qw/t0rYPe7EVvTMzsp4Dxxx
xu2nqeYjxLPN03aNSkEkhVwDGaZHDehOUloZ+MwSt62S/m2Q0ifB8ebjv87KzhEieFyJwmD+
4wSJU6KC4QhI13gFQbeLUDQ0UgcGaq0tCZtkZE5cSTJISZJISROROgiNhMjMORWEzJyqvNMR
yoYpIlKkRvxOqZ6q8pLoF76E/i85ecPC8lnTr4jQxeN0fv0NMmbwKrFGoeV6Wx3tlS8k5jad
b6y04jYSd9YyvJ3lhW+Z0+7B7GK4/k1mizHPULWWr0Fp0YlWzvlC9h+HqhC7ErvzO2BZhwPv
RgRham87nyVdSJjnjsdT3RCXted4V6D4XxHuSe9zRD29qxqcvNamlJlTQh1uFgoQyLlMWRCm
v2T2s8GxpFZ+MTSWqd0QwITReQnH5K4slTRkrFGpatmFvhLNHBpGy9MxBUkjkYPKOFepG5JK
yjJSBzo6UeRGpGpFpHooiz/JeSe4l6X9YUXo7EevOIXrUPRFPmqwzW1YrqVn5UlY98O4dzBK
UmWB8Gp7S3r4Lm2UfOLrsEm5FSK8MqwR8dD/qMojNtipzrL8dfFnSva2VO/CW6Ya+DDeyXkK
FyyXW7zdDc4nraNxk3wsXL0YsFhDXfxpjYXplnmSzcCG26iNiOrE5E0YXkp5GtRcUR9N2FKb
OVZbOdNURjEYZ0VUpEslChCyJuUoWJRt0jNdchyI5qLtFRG+MPLQZUl0vVsz2KiKg9zRDPcS
Vog0wSe05EpJ5nk8GadyxUEJSt1QAi7YyBQqyBmZcLJNFk4I3zVZVRPGu1s1u/ZeW8aMTMlD
HalGSY/i7kinChIJKo3+IA==

--VbJkn9YxBvnuCH5J--
