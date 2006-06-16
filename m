Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWFPMkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWFPMkV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 08:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWFPMkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 08:40:20 -0400
Received: from wx-out-0102.google.com ([66.249.82.201]:13348 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751381AbWFPMkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 08:40:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ok3UDXQug6wo7gVansfXdsQgzwyLag+e+nCTtvVEvnLPgW2dqCYzqol/m1OA20drGMfLd0G4QxPzze2hp6O6Mvguyk3uvTmW1+UyPgQua5ravB4Jbg+cgWErL+nVbNI3lAo9XX8Bw0qRy4G1maX5t6+A+FqFW7DQ26qyQk2e0mc=
Message-ID: <84144f020606160540q20433601jd9b5331763a55dab@mail.gmail.com>
Date: Fri, 16 Jun 2006 15:40:17 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Alessio Sangalli" <alesan@manoweb.com>
Subject: Re: APM problem after 2.6.13.5
Cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <44929CF5.208@manoweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44927F91.6050506@manoweb.com>
	 <84144f020606160305ueae2050lc2d8f47944173971@mail.gmail.com>
	 <44929CF5.208@manoweb.com>
X-Google-Sender-Auth: 140082a8fc9612e9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alessio,

On 6/16/06, Alessio Sangalli <alesan@manoweb.com> wrote:
> > > if I enable "APM support" I get a freeze at the very beginning of the
> > > boot, without any explicit erro message, just after the PCI stuff. If
> > > you need a transcript of the messages at boot, let me know, I will have
> > > to write them by hand).
> > > 2.6.13.5 is ok. I need APM support to let the "Fn" key and the battery
> > > meter work!

Pekka Enberg wrote:
> > There's a lot of changes between 2.6.13 and 2.6.14.  It would be
> > helpful if you could narrow down the exact changeset that broke your

On 6/16/06, Alessio Sangalli <alesan@manoweb.com> wrote:
> done:
>
> 4196c3af25d98204216a5d6c37ad2cb303a1f2bf is first bad commit
> diff-tree 4196c3af25d98204216a5d6c37ad2cb303a1f2bf (from
> 9092b20803e4b3b3a480592794a73030f17370b3)
> Author: Linus Torvalds <torvalds@g5.osdl.org>
> Date:   Sun Oct 23 16:31:16 2005 -0700
>
>     cardbus: limit IO windows to 256 bytes
>
>     That's what we've always historically done, and bigger windows seem to
>     confuse some cardbus bridges. Or something.
>
>     Alan reports that this makes the ThinkPad 600x series work properly
>     again: the 4kB IO window for some reason made IDE DMA not work, which
>     makes IDE painfully slow even if it works after DMA timeouts.
>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
>
> :040000 040000 629d4d303048bffa610017e81e0e744bae08660d
> 33e154ffe96822d09f37ae2d433de5152216501b M      drivers
>
>
> let me know any other test I should do to help find a solution to this
> problem, thank you!

So reverting the above commit from git head makes your box boot again?
Linus, any thoughts?

                                      Pekka
