Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264902AbUEVICs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbUEVICs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 04:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264908AbUEVICs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 04:02:48 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:51149 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264902AbUEVICq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 04:02:46 -0400
Message-ID: <40AF0911.6020000@colorfullife.com>
Date: Sat, 22 May 2004 10:02:25 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: slab redzoning
References: <20040522034902.GB2161@holomorphy.com>
In-Reply-To: <20040522034902.GB2161@holomorphy.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>-if ((size < 4096 || fls(size-1) == fls(size-1+3*BYTES_PER_WORD)))
>+if (size + 3*BYTES_PER_WORD <= PAGE_SIZE ||
>
I understand this change: objects between 4082 and 4095 bytes are 
redzoned and cause order==1 allocations, that's wrong.

>+			((size & (size - 1)) &&
>+			(1 << fls(size)) - size > 3*BYTES_PER_WORD))
>
Why this change? I've tested my fls(size-1)==fls(size-1-3*4) approach 
and it always returned the right result: No redzoning between 8181 and 
8192 bytes, between 16373 and 16384, etc.

--
    Manfred

