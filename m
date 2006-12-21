Return-Path: <linux-kernel-owner+w=401wt.eu-S1422753AbWLUGDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422753AbWLUGDo (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 01:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422754AbWLUGDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 01:03:44 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:19376 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422753AbWLUGDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 01:03:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TyVqPduziFTxECeINdqBKnhHSs2sfn+OhKmbCirT+jPNe/da5qAW7cBZjUOc+mxUtDVjiNwO1VEvj7B0CpgPfEBvuPnB0Vea7fazNK4i91FhMJIF+4sDi8obTwnlnVXpo645NeCBKB9QbHV6USvEjRWxpmrdF2U/Zoi93KQuQfU=
Message-ID: <652016d30612202203h16331f96o2147872db3cb2d43@mail.gmail.com>
Date: Thu, 21 Dec 2006 11:48:42 +0545
From: "Manish Regmi" <regmi.manish@gmail.com>
To: "Bill Davidsen" <davidsen@tmr.com>
Subject: Re: Linux disk performance.
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
In-Reply-To: <4589B92F.2030006@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <652016d30612172007m58d7a828q378863121ebdc535@mail.gmail.com>
	 <1166431020.3365.931.camel@laptopd505.fenrus.org>
	 <652016d30612180439y6cd12089l115e4ef6ce2e59fe@mail.gmail.com>
	 <4589B92F.2030006@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/06, Bill Davidsen <davidsen@tmr.com> wrote:
> >
> > But isn't O_DIRECT supposed to bypass buffering in Kernel?
> That's correct. But it doesn't put your write at the head of any queue,
> it just doesn't buffer it for you.
>
> > Doesn't it directly write to disk?
> Also correct, when it's your turn to write to disk...

But the only process accessing that disk is my application.

> > I tried to put fdatasync() at regular intervals but there was no
> > visible effect.
> >
> Quite honestly, the main place I have found O_DIRECT useful is in
> keeping programs doing large i/o quantities from blowing the buffers and
> making the other applications run like crap. If you application is
> running alone, unless you are very short of CPU or memory avoiding the
> copy to an o/s buffer will be down in the measurement noise.

Yes... my application does large amount of I/O. It actually writes
video data received from ethernet(IP camera) to the disk using 128 K
chunks.

> I had a news (usenet) server which normally did 120 art/sec (~480 tps),
> which dropped to about 50 tps when doing large file copies even at low
> priority. By using O_DIRECT the impact essentially vanished, at the cost
> of the copy running about 10-15% slower. Changing various programs to
> use O_DIRECT only helped when really large blocks of data were involved,
> and only when i/o clould be done in a way to satisfy the alignment and
> size requirements of O_DIRECT.
>
> If you upgrade to a newer kernel you can try other i/o scheduler
> options, default cfq or even deadline might be helpful.

I tried all disk schedulers but all had timing bumps. :(

> --
> bill davidsen <davidsen@tmr.com>
>    CTO TMR Associates, Inc
>    Doing interesting things with small computers since 1979
>


-- 
---------------------------------------------------------------
regards
Manish Regmi

---------------------------------------------------------------
UNIX without a C Compiler is like eating Spaghetti with your mouth
sewn shut. It just doesn't make sense.
