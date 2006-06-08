Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbWFHHcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbWFHHcR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 03:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWFHHcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 03:32:17 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:25566 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932554AbWFHHcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 03:32:16 -0400
Date: Thu, 8 Jun 2006 09:31:38 +0200
From: Voluspa <lista1@comhem.se>
To: Fengguang Wu <wfg@mail.ustc.edu.cn>
Cc: akpm@osdl.org, arjan@infradead.org, Valdis.Kletnieks@vt.edu,
       diegocg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] readahead: initial method - expected read size - fix
 fastcall
Message-Id: <20060608093138.79f66acb.lista1@comhem.se>
In-Reply-To: <349560742.21407@ustc.edu.cn>
References: <349406446.10828@ustc.edu.cn>
	<20060604020738.31f43cb0.akpm@osdl.org>
	<1149413103.3109.90.camel@laptopd505.fenrus.org>
	<20060605031720.0017ae5e.lista1@comhem.se>
	<349560742.21407@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2006 10:26:06 +0800 Fengguang Wu wrote:
> On Mon, Jun 05, 2006 at 03:17:20AM +0200, Voluspa wrote:
> > Patch:
> > http://web.comhem.se/~u46139355/storetmp/adaptive-readahead-v14-linux-2.6.17-rc5-git-updated-june-04-2006.patch
> 
> It seems that the patch has some problem:
[...]
> The above statements was displaced, rendering the if() clause to fail all the time.
> That defeats the small file optimization, for ra_thrash_bytes will remain small.

Which rendered all my testing invalid. Nice... It came about with the
update-01to04of04 and must have elicited a "fuzz" that I neglected to
check. 

Sorry to have caused you grief and extra work, Wu. I can only point 
towards the _Caveat and preemptive Mea Culpa_.

> Voluspa, I attached an updated patch, including two more performance tunings.
> Please take it when you find time to do more benchmarks, thanks.
> 
> I'd suggest that you(and other kind people interested in testing it out) to run
>         blockdev --setra 2048 /dev/[sda/sda1/...]
> before each benchmark to ensure fairness and simplicity of analysis, thanks.

I'm in the process of writing up a new report after having tested for ca 6
hours straight (repenting mood). Will post in the original thread:

Adaptive Readahead V14 - statistics question...
http://marc.theaimsgroup.com/?t=114893205000004&r=1&w=2

The subject has a 'higher profile' than this one and might pull in future
testers.

Note to Andrew; Revised Conclusion: On _this_ machine, with _these_ operations,
Adaptive Readahead in its current incarnation and default settings is a slight
_loss_. However, if the readahead size is lowered from 2048 to 256, it becomes
a slight _gain_ or at least stays in parity with normal readahead.

Mvh
Mats Johannesson
--
