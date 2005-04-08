Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262780AbVDHJ6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbVDHJ6C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 05:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbVDHJ6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 05:58:01 -0400
Received: from gate.corvil.net ([213.94.219.177]:11538 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S262780AbVDHJ5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 05:57:44 -0400
Message-ID: <42565587.4000103@draigBrady.com>
Date: Fri, 08 Apr 2005 10:57:27 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Nick Wilson <njw@osdl.org>, linux-kernel@vger.kernel.org,
       rddunlap@osdl.org
Subject: Re: [PATCH 0/6] add generic round_up_pow2() macro
References: <20050408004428.GA4260@njw.pdx.osdl.net> <20050407175042.43c02ae9.akpm@osdl.org>
In-Reply-To: <20050407175042.43c02ae9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Wilson <njw@osdl.org> wrote:
> 
>>The first patch adds a generic round_up_pow2() macro to kernel.h. The
>> remaining patches modify a few files to make use of the new macro.
> 
> 
> We already have ALIGN() and roundup_pow_of_two().

cool. It doesn't handle x={0,1} though.
Maybe we should have:

static inline unsigned long __attribute_const__ 
__roundup_pow_of_two(unsigned long x)
{
         return (1UL << fls(x - 1));
}

static inline unsigned long __attribute_const__ 
roundup_pow_of_two(unsigned long x)
{
         return (unlikely(x<2)?2:__roundup_pow_of_two(x));
}

-- 
Pádraig Brady - http://www.pixelbeat.org
--
