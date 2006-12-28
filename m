Return-Path: <linux-kernel-owner+w=401wt.eu-S1753846AbWL1Xbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbWL1Xbc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 18:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753770AbWL1Xbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 18:31:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:46315 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782AbWL1Xbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 18:31:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=ow4eiKasLj1wgVAH1pJ+QBl1BszhPR54zjWscE14eXJwAgTyvr4oeZjyiazWxNO2Fl53k6kvYG9wBfoO8s5E3h3cxSrUGrr54Svg73P6J0CxwEGCyloAut7dm/JGXUi3bzKglVIbnHAWPyCVwyjEQxk7+UykeiQU4T0Ep++XhQs=
Message-ID: <459453E6.6020104@gmail.com>
Date: Fri, 29 Dec 2006 00:31:27 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Sergei Organov <osv@javad.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: moxa serial driver testing
References: <45222E7E.3040904@gmail.com> <87wt7hw97c.fsf@javad.com>	<4522ABC3.2000604@gmail.com> <878xjx6xtf.fsf@javad.com>	<4522B5C2.3050004@gmail.com> <87mz8borl2.fsf@javad.com>	<45251211.7010604@gmail.com> <87zmcaokys.fsf@javad.com>	<45254F61.1080502@gmail.com> <87vemyo9ck.fsf@javad.com>	<4af2d03a0610061355p5940a538pdcbd2cda249161e8@mail.gmail.com>	<87vemtnbyg.fsf@javad.com> <452A1862.9030502@gmail.com>	<87r6urket6.fsf@javad.com> <552766292581216610@wsc.cz>	<552766292581216610@wsc.cz> <554564654653216610@wsc.cz> <87d564x7r0.fsf@javad.com>
In-Reply-To: <87d564x7r0.fsf@javad.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergei Organov wrote:
> Hi, Jiri!

Hi.

> I'm so sorry, I don't know what I smoked yesterday, but the latest
> version you've sent me does not have this problem anymore! I think I

YES!

> copied compiled module to modules directory for different kernel and
> thus tested old code all the time. BTW, should you tell me that the
> ports are now called /dev/ttyMIx instead of /dev/ttyMx, I think I'd

ttyM was reserved for isicom, and it caused many warnings in the kernel, when
both isicom and mxser were built and loaded. The proper name for mxser is (and
ever was) ttyMI -- sorry for not giving you a notice (I didn't realize the change).

> notice my mistake earlier. Yes, in fact I didn't test any version where
> ports are called /dev/ttyMIx until now! In particular, it means that
> maybe some of the recent changes you've made yesterday based on my wrong
> reports are not in fact required.

I think those with ASYNC_CLOSING test in the isr is the one (but also wakeup
spinlock change is requisite to go upstream).

> Anyway, the only mxser-specific problem that currently remains for
> me and that I didn't see before, is the following:
> 
> # rmmod mxser_new
> Trying to free already-free IRQ 58
> Trying to free nonexistent resource <0000000000009000-000000000000903f>
> Trying to free nonexistent resource <0000000000008800-0000000000008800>

Thanks, I'll fix this and let you know. Does this happed every time you try to
unload it?

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
