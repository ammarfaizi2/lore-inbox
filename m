Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283766AbRLMLvs>; Thu, 13 Dec 2001 06:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283390AbRLMLvi>; Thu, 13 Dec 2001 06:51:38 -0500
Received: from hermes.domdv.de ([193.102.202.1]:6152 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S283860AbRLMLvW>;
	Thu, 13 Dec 2001 06:51:22 -0500
Message-ID: <XFMail.20011213123949.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <000801c183b9$d8eaf5f0$21c9ca95@mow.siemens.ru>
Date: Thu, 13 Dec 2001 12:39:49 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
Subject: RE: APM idle problems - how to check if BIOS halts CPU?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted an apm patch and asked Marcelo to apply it. What you do see is
kapm-idled and the idle task both racing for idle time. There's even more
problems (search lkml for subject kapm-idled and have a look at the reply from
Alan Cox on Dec 5 which does contain my original mail and the patch). With the
patch e.g. the fan control of my laptop works properly which it never did
before. If you really do have a broken bios there's no other way than to
contact your system's vendor.

On 13-Dec-2001 Borsenkow Andrej wrote:
> Many people (me including) are bothered by monitoring tools like
> gkrellm/top showing kapm_idled consuming excessive amount CPU time
> (reports vary from 50% to 70%). In my case I was concerned by the fact
> that CPU was *not* cooled, the temperature stayed above minimal value
> even when system was completely idle (it did not rocket up still it was
> noticeably above low limit).
> 
> The only possible explanation to me was that BIOS neither slows nor
> halts CPU. I have ASUS CUSL2 motherboard (BIOS 1011 beta 5) that reports
> that it does not slow CPU (bit 2 == 0), so I tried to check if CPU was
> really halted.
> 
> If I understand it correctly, if BIOS halts CPU during Idle call and no
> other activity takes place it is clock interrupt that resumes CPU
> activity. In this case jiffies should be advanced, because we return
> into apm_do_idle() after clock interrupt has finished. I tried to count
> number of times when jiffies stayed the same in apm_do_idle() and hot
> nice result - in 99.9% of calls to apm_do_idle() jiffies value did not
> change after return fro BIOS Idle call.
> 
> Then I tried to replace call to apm_do_idle() with call to
> apm_cpu_idle() that directly executes HLT instead of calling BIOS. Lo
> and behold - I got expected picture of cool CPU and 0% CPU time during
> idle times.
> 
> Unfortunately, APM does not specify any way to find out if BIOS halts
> CPU or simply does nothing. It may also be a BIOS bug, because with
> original apm_do_idle() I _sometimes_ got the same picture (cooled CPU
> and 0% CPU usage), so it seems that sometimes BIOS correctly does its
> job. Still, as it seems to be broken most of the time, I thought about
> adding run-time parameter to use apm_cpu_idle() instead. Would such
> patch be acceptable? 
> 
> TIA
> 
> -andrej
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
