Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264892AbSLGX3w>; Sat, 7 Dec 2002 18:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbSLGX3w>; Sat, 7 Dec 2002 18:29:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27400 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264892AbSLGX3v>;
	Sat, 7 Dec 2002 18:29:51 -0500
Message-ID: <3DF28610.3000004@pobox.com>
Date: Sat, 07 Dec 2002 18:36:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [RFC][PATCH] net drivers and cache alignment
References: <3DF2781D.3030209@pobox.com> <20021207.144004.45605764.davem@redhat.com> <3DF27EE7.4010508@pobox.com> <3DF2844C.F9216283@digeo.com>
In-Reply-To: <3DF2844C.F9216283@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> It needs padding _only_ on SMP.  ____cacheline_aligned_in_smp.
[...]
> So your patch will do what you want it to do.  You should just tag the
> first member of a group with ____cacheline_aligned_in_smp, and keep an
> eye on things with offsetof().


thanks.

For this case, though, I want to align on cacheline bounaries even on 
UP, right?  That's why I picked ____cacheline_aligned.  It uses 
L1_CACHE_BYTES when !CONFIG_SMP.  Other uses of ____cacheline_aligned in 
the kernel seem to relate to irq matters, just like my groupings in tg3.h.

[obviously benchmarking can answer some of this, but I want to hammer 
out silliness first]

	Jeff



