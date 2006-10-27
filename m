Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWJ0UiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWJ0UiS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 16:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWJ0UiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 16:38:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:22191 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751254AbWJ0UiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 16:38:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jeoZ8TxK45WGyL9dAszBh0UQpgpyODv2USUADkrJ40vQJibRh8BlFyL7nVgrk08lrfRufdILdSL7UU2Mwq6GvVw8EjpM7ApR/c8J7KB9Yh/2YbG1qP2T0kRZgdFgR0v2JE4Zcyw/NhK9ukx/h/JU6sntdX8WZymm5Ht1w13heig=
Message-ID: <653402b90610271338t6e2e4d31idffefe4b6b1ce639@mail.gmail.com>
Date: Fri, 27 Oct 2006 20:38:15 +0000
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <cda58cb80610271308v137a2de8vfb8123a422270144@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061013023218.31362830.maxextreme@gmail.com>
	 <45364049.3030404@innova-card.com> <453C8027.2000303@innova-card.com>
	 <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>
	 <453CE143.3070909@innova-card.com>
	 <653402b90610230921j595446a4xda5e6d9444e108da@mail.gmail.com>
	 <cda58cb80610230951l4a1319bbs6956fea5143c021a@mail.gmail.com>
	 <653402b90610260745w59b740d2x5961e40252f5b76@mail.gmail.com>
	 <cda58cb80610271308v137a2de8vfb8123a422270144@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> On 10/26/06, Miguel Ojeda <maxextreme@gmail.com> wrote:
> > No way. Each controller would have different wirings, pins, in-outs,
> > specifications (...) You will need to code an almost whole new fbdev
> > driver (althought maybe it will be so similar to cfag12864b so you
> > only need to make few little changes, but that is unsure).
> >
>
> that's what I was trying to point out. I was wondering if you could
> make your driver a little more generic so another lcd could use your
> driver as is.
>

Hum... Others LCDs has different pinouts, different timings, different
timings... It would be a really hard work, and maybe the result
wouldn't be good.

I will think about it, but I think it would lead to a really complex
generic driver (something like the fbdev API). Also, we would need
many kinds of LCDs to know what can be a common factor between all of
them, what can't, etc.

Really, I coded 2 drivers. The generic driver is ks0108, which it can
be used with a lot more LCDs drivers. But the cfag12864b driver is
really specific, as all the LCDs are different (as different as the
user (wiring) and the builder (timings, pinout, commands...) wants).
In the other hand, LCD controllers like ks0108 are industry-standard.

> > Well, you were right about mmaping, but you weren't about
> > "info->fix.smem_start". smem_start expects a physical address. RAM
> > addresses can't be mmapped as usual
>
> Sorry I don't understand your last sentence. Can you explain please ?
>

Sorry, I meant: You can't mmap a RAM address using functions like the
usual remap_pfn_range (as such functions doesn't like physical RAM
addresses, they want I/O ports for example, like 0x378). So, you can't
use smem_start. You need to code your own mmap & nopage function. (It
is explained in LDD3 very well).

> --
>                Franck
>
