Return-Path: <linux-kernel-owner+w=401wt.eu-S1755368AbXABQiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368AbXABQiy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755371AbXABQix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:38:53 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:52441 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755368AbXABQiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:38:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F4nSG4GZMDsE7CkKRbdWDP6Ifdq6KkemV19jYLIMYnetO4zh2YcDyzVTYPmI670+kjlY1mAvZ2atLeoIn7+kA8gURczRfltovuDPEnvnIR+1VLIuwd0/4xz+kRLr4ITpn3ZlUrGYrIhocvP/u+Hggg3rTYKIbJGlzaw8sNZKQSA=
Message-ID: <3efb10970701020838n61db5388l94b2f0ed38073edd@mail.gmail.com>
Date: Tue, 2 Jan 2007 17:38:51 +0100
From: "Remy Bohmer" <l.pinguin@gmail.com>
Reply-To: linux@bohmer.net
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [BUG-RT] RTC has been stopped-> long delay during boot, soft reboot->GRUB fails to call getrtsecs()
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20070102161608.GA19214@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3efb10970701020601i13dd3809y56c2c6aafeb228b@mail.gmail.com>
	 <20070102161608.GA19214@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ingo,

In the mean time I have tested more with this problem:
1. Once, the RTC clock gets stopped during shutdown, it is **NEVER**
going to run again.
And I continuously see the problems with grub and the BIOS
time-of-day. Finally I had to remove the battery from the motherboard
to reset the RTC clock (Nothing else worked, even total poweroff). Now
it is ticking again... until...
2. Using a kernel without CONFIG_NO_HZ seems to solve all the problems
with the RTC clock, even hwclock functions normally.

With CONFIG_NO_HZ enabled, the problem with hwclock **only** occurs
when it is called for the first time by the init scripts, directly
after kernel boot. Every sub sequential call to hwclock show normal
times like your measurement.


Best Regards and also a Happy New Year,

Remy

2007/1/2, Ingo Molnar <mingo@elte.hu>:
>
> * Remy Bohmer <l.pinguin@gmail.com> wrote:
>
> > Hello Ingo,
> >
> > I have discovered 3 problems that are likely all related to the same
> > root-cause, likely to be caused by the RT-kernel.
> > I use the 2.6.19-rt15 kernel, with the configuration attached to this mail.
> > It is running on a standard x86, i945, Celeron 2.93 GHZ (=UP), Fedora Core 6
> >
> > So, I have set the following options:
> > CONFIG_HIGH_RES_TIMERS=y
> > CONFIG_NO_HZ=y
> >
> > The problems:
> > 1. During (cold and warm) boot the synchronisation of the hardware
> > clock takes often very long time, up to approx. 30 seconds. (This is
> > the call: /sbin/hwclock --hctosys --localtime)
>
> i tried this on a recent -rt kernel and there's no delay:
>
>   [root@europe ~]# time /sbin/hwclock --hctosys --localtime
>
>   real    0m0.756s
>   user    0m0.754s
>   sys     0m0.002s
>
> could you try a more recent kernel like 2.6.20-rc2-rt3? We fixed a good
> number of high-res timers related bugs that could result in similar
> hangs. But maybe it's still unfixed, it's just a guess.
>
>         Ingo
>
>
