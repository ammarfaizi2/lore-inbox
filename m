Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUFUTeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUFUTeO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 15:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266434AbUFUTeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 15:34:07 -0400
Received: from [80.72.36.106] ([80.72.36.106]:23687 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S266435AbUFUTcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 15:32:20 -0400
Date: Mon, 21 Jun 2004 21:32:15 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Kirill Korotaev <kksx@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can TSC tick with different speeds on SMP=?koi8-r?Q?=3F?=
In-Reply-To: <E1BcU4I-000Cj2-00.kksx-mail-ru@f27.mail.ru>
Message-ID: <Pine.LNX.4.58.0406212112020.28702@alpha.polcom.net>
References: <E1BcU4I-000Cj2-00.kksx-mail-ru@f27.mail.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2004, [koi8-r] "Kirill Korotaev[koi8-r] "  wrote:

> Hello,
> 
> I've got some stupid question to SMP gurus and would be very thankful for the details. I suddenly faced an SMP system where different P4 cpus were installed (with different steppings). This resulted in different CPU clock speeds and different speeds of time stamp counters on these CPUs. I faced the problem during some timings I measured in the kernel.

IANSG (= I am not SMP guru).

> So the question is "is such system compliant with SMP specification?".
> In old kernels there was a code to syncronize TSCs and to detect if they were screwed up. Current kernels do not have such code. Is it intentional? I suppose there is some code in kernel which won't work find on such systems (real-time threads timing accounting and so on).

I have friend. He has SMP system with 2x P III. He put two different CPUs 
into it (on 700 and one 750). This resulted in fast growing difference 
between time on them. This can be potentially dangerous to databases or 
other time driven programs. But there is a fix: boot with notsc kernel 
parameter. But there is one problem. Everyting is ok as long as you have 
i386 (that means NOT i686) compiled glibc. If you have not, init will stop 
with segmentation fault or something like that. But we are using Gentoo, 
so his glibc was i686 compiled so not working. He do not wanted to 
recompile it to i386 so I fixed glibc to work with notsc and i686. But I 
will not provide any patch because I fixed it against some CVS version 
that Gentoo used at this time. Maybe he has more recent patch. I will ask 
him and I will post patch if he has any. But the change is very simple. 
You should grep glibc's sources against tsc related assembly instructions 
and then kill them in the smart way. I found two places. One was in some 
malloc debuging code and the other was in header. The header is simple to 
fix - you should overwrite it with its no-op version from i386 (or 
something like that) directory. And you should disable the second call in 
the malloc debuging code (for example by setting define that you have no 
precise timing source in your machine). Then you should recompile your 
glibc and you are done. My friend's server has something about 2 moths 
uptime and no clock problems so this is probably The Right Fix (TM). I am 
writing this words using it so I know...


Grzegorz Kulewski

