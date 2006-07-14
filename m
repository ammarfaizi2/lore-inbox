Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161119AbWGNOxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbWGNOxf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 10:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161120AbWGNOxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 10:53:35 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:36487 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161119AbWGNOxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 10:53:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q4OP9fbuDpH++frXN6/JeRcJ8i6Elwof9kRJJCbzLhS9UJLEGuzpomzlpIyhWC4598qLwBEF5IAE8p0XT3CSJrrPxWS3Ji4OlwS/4d4CAC7anLwq83gX41z7QtLqQ1oeie8T23HxtJg+VRryPEnwXN0TCuTny1TQmiBLQsrlOZ4=
Message-ID: <b0943d9e0607140753k6a551cb8m6bc8416b180872d4@mail.gmail.com>
Date: Fri, 14 Jul 2006 15:53:33 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0607131214l68232de8lf8cf03f805822f07@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <6bffcb0e0607110902u4e24a4f2jc6acf2eb4c3bae93@mail.gmail.com>
	 <b0943d9e0607110931n4ce1c569x83aa134e2889926c@mail.gmail.com>
	 <6bffcb0e0607111000q228673a9kcbc6c91f76331885@mail.gmail.com>
	 <b0943d9e0607111454l1f9919eahbb3b683492a651e@mail.gmail.com>
	 <6bffcb0e0607120435x31eceab7r3fdb055a7bee6da2@mail.gmail.com>
	 <b0943d9e0607120917pa0c191aw5814a19b9e6f31fd@mail.gmail.com>
	 <6bffcb0e0607121555n20a9df53q8589109024629f7a@mail.gmail.com>
	 <b0943d9e0607130935l2d8b2ff1qf1abec1af876f155@mail.gmail.com>
	 <6bffcb0e0607131214l68232de8lf8cf03f805822f07@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> After applying context_struct_to_string-not-leak.patch and reverting
> alloc_skb-false-positive.patch I haven't noticed that soft lockup.

You still need the apply alloc_skb-false-positive.patch as it just
avoids a false positive (I'll add it to kmemleak 0.9). Does anything
change with this (and the context_struct_... one)?

> Here is something new
> orphan pointer 0xf40d61ac (size 1536):
>   c017392a: <__kmalloc_track_caller>
>   c01631b1: <__kzalloc>
>   f98869cd: <skge_ring_alloc>
>   f9888a1d: <skge_up>
>   c02b17b6: <dev_open>
>   c02b2e94: <dev_change_flags>
>   c02e6e17: <devinet_ioctl>
>   c02e8a02: <inet_ioctl>

This looks like a leak but I couldn't find anything obvious with the
code. I'll keep looking.

> http://www.stardust.webpages.pl/files/o_bugs/kml/ml2/
> http://www.stardust.webpages.pl/files/o_bugs/kml/ml3/

I would also need to investigate why the report shows some orphan
pointers without any back-trace information. It seems to disappear
after a while.

Thanks.

-- 
Catalin
