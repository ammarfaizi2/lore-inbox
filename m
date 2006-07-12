Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWGLQRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWGLQRz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWGLQRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:17:55 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:6208 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751452AbWGLQRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:17:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wb1K9IT6Da3ydQe3L6dinfvy1Tsfz7rh6rEpPKH6b9ByTZgNVUFR1tfP56RlanTGb3z2Xn2Mc/nvYf4c7D2rlUgtlDbOh3shHj5sG5RENFHxmqRvy+fsJdi9KyQLr0FIfutSpSt8wF6En0rbyuNVYLmUrs6J1rY1M1hbG8dPC0w=
Message-ID: <b0943d9e0607120917pa0c191aw5814a19b9e6f31fd@mail.gmail.com>
Date: Wed, 12 Jul 2006 17:17:54 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0607120435x31eceab7r3fdb055a7bee6da2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <6bffcb0e0607110649s464840a9sf04c7537809436b1@mail.gmail.com>
	 <b0943d9e0607110702p60f5bf3fg910304bfe06ec168@mail.gmail.com>
	 <6bffcb0e0607110802w4f423854rb340227331084596@mail.gmail.com>
	 <b0943d9e0607110844m6278da6crdc03bccce420da1d@mail.gmail.com>
	 <6bffcb0e0607110902u4e24a4f2jc6acf2eb4c3bae93@mail.gmail.com>
	 <b0943d9e0607110931n4ce1c569x83aa134e2889926c@mail.gmail.com>
	 <6bffcb0e0607111000q228673a9kcbc6c91f76331885@mail.gmail.com>
	 <b0943d9e0607111454l1f9919eahbb3b683492a651e@mail.gmail.com>
	 <6bffcb0e0607120435x31eceab7r3fdb055a7bee6da2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> BTW I have _very_ annoying soft lockup. Can you fix that?
>
> Jul 12 13:15:47 ltg01-fedora kernel: printk: 1527 messages suppressed.
> Jul 12 13:15:47 ltg01-fedora kernel: ipt_hook: happy cracking.
> Jul 12 13:15:56 ltg01-fedora kernel: printk: 1631 messages suppressed.
> Jul 12 13:15:56 ltg01-fedora kernel: Neighbour table overflow.
>
> I don't know why, but clock goes mad.
>
> Jul 12 14:08:21 ltg01-fedora kernel: BUG: soft lockup detected on CPU#0!

Maybe the soft lockup report is cause by the clock change (it doesn't
show any kmemleak functions in the backtrace). You could change
SCAN_BLOCK_SIZE in memleak.c to a smaller value as the scanning is
done with the interrupt disabled.

I'll try tomorrow on my platforms with the soft lockup enabled.

-- 
Catalin
