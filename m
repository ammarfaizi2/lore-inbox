Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWGSKf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWGSKf3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 06:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWGSKf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 06:35:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:38895 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964783AbWGSKf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 06:35:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Kh3g4nSOMJGaMyYTF/0CxPFnVCGth5x7Yl9v5QYW7npkcK9AtYu3ShQSbRw4A3zJHBqBY4JeBZiIkkYQYk1FOQc/o1MeDz6D6ITOvn4XBejPE23vkQbEfREycIR/5Bwc/RMbAYbK04kx+MCz0GbQQhwMqyavEAaKcpe6H3W2riI=
Message-ID: <84144f020607190335p65ba24cbn3ba95eddd28ac675@mail.gmail.com>
Date: Wed, 19 Jul 2006 13:35:27 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "yunfeng zhang" <zyf.zeroos@gmail.com>
Subject: Re: Improvement on memory subsystem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4df04b840607190313u75965101n9543ad3bd6716ace@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4df04b840607180303i3d8c8bd0o4d2a24752ec2e150@mail.gmail.com>
	 <84144f020607180925s62e6a7abvbaf66c672849170b@mail.gmail.com>
	 <4df04b840607182021hecef3b6v24c4794444a8e53c@mail.gmail.com>
	 <84144f020607190130q94b5563i436e16028eb9fb94@mail.gmail.com>
	 <4df04b840607190313u75965101n9543ad3bd6716ace@mail.gmail.com>
X-Google-Sender-Auth: 630e1a6e34786197
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/06, yunfeng zhang <zyf.zeroos@gmail.com> wrote:
> Here, the off-slab is the same as the off-slab concept of Linux,
> doesn't Linux stores bufctl_t array in its off-slab object?
>
> I consider that we should try our best to explore the potential of
> page structure. In my OS, page structure is just like a union and is
> cast into different types according to its flag field.

The slab allocator currently allocates space for struct slab and the
bufctls next to each other regardless of whether we are allocating
on-slab or off-slab. Your approach of splitting them results in more
data cache pressure for the cache_alloc() path, I think.
