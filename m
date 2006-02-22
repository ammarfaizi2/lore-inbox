Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWBVMcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWBVMcZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 07:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWBVMcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 07:32:25 -0500
Received: from mail2.designassembly.de ([217.11.62.46]:38022 "EHLO
	mail2.designassembly.de") by vger.kernel.org with ESMTP
	id S1751234AbWBVMcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 07:32:24 -0500
Message-ID: <43FC59D4.2090208@designassembly.de>
Date: Wed, 22 Feb 2006 13:32:20 +0100
From: Michael Heyse <mhk@designassembly.de>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: [SOLVED] Re: which one is broken: VIA padlock aes or aes_i586?
References: <43FB0746.5010200@designassembly.de> <20060222013137.GA844@gondor.apana.org.au> <20060222114531.GA4170@gondor.apana.org.au>
In-Reply-To: <20060222114531.GA4170@gondor.apana.org.au>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found the problem, it's a typo in drivers/crypto/padlock-aes.c (introduced probably in the "[CRYPTO] Use standard byte order macros wherever possible" patch) and only happens with 256 bit keys.

it says below the "case 32:"

E_KEY[4] = le32_to_cpu(in_key[4]);
E_KEY[5] = le32_to_cpu(in_key[5]);
E_KEY[6] = le32_to_cpu(in_key[6]);
t = E_KEY[7] = le32_to_cpu(in_key[7]);

but it should be

E_KEY[4] = le32_to_cpu(key[4]);
E_KEY[5] = le32_to_cpu(key[5]);
E_KEY[6] = le32_to_cpu(key[6]);
t = E_KEY[7] = le32_to_cpu(key[7]);

Now it's working!

Michael
