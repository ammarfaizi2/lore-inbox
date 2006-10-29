Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWJ2ASq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWJ2ASq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 20:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWJ2ASq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 20:18:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:12974 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751436AbWJ2ASp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 20:18:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lkJa9WCaYqvS/BGp1VD9oo9MViJ3tfmXA2I0SkgAV2Gpc94SFIjB5T8RxpyXjyQUm0OKYDwKWObymtvaR6HxLK8SOphDZkb4+oj615q1s2gRxy96M38ZYv5KZ08WG0rb5vdkiZLiP0cFqG2VrxOT7wgFO6QNJRci3UEGgP2iyfg=
Message-ID: <a2ebde260610281718g1d8d8c0cr180196d3ec804e09@mail.gmail.com>
Date: Sun, 29 Oct 2006 08:18:44 +0800
From: "Dong Feng" <middle.fengdong@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: leave_mm() and lazy TLB mode
In-Reply-To: <a2ebde260610281023x65c0bcd2ga34f7e50d0427259@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a2ebde260610281023x65c0bcd2ga34f7e50d0427259@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I read source code more and now I understand that the effect of
leave_mm() is not only

1. bypassing the invocation to local_flush_tlb(), but also
2. prevent the curent CPU from receiving any more INVALIDATE_TLB_VECTOR IPI.

Some material makes me understand the lazy TLB mode this way, that is,
a CPU's TLB will not be flushed since it enters lazy TLB mode till it
return to normal TLB mode.

But according to the source code, it seems that a CPU still has to
undergo at most one time TLB flush, that is, the flush caused by
loading CR3 with swapper_pg_dir.

Could any one confirm whether my original understanding and my
corrective understanding is correct? Thank you very much.




2006/10/29, Dong Feng <middle.fengdong@gmail.com>:
> There are several places where some comments say leave_mm() disables
> TLB flush on CPUs in lazy TLB mode.
>
> My question may be silly, ...
>
> leave_mm() change the value of CR3 register. In my understanding, that
> causes TLB flush. Does this contradict with the definition of lazy TLB
> mode?
>
