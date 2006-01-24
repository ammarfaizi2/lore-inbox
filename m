Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWAXGty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWAXGty (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 01:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWAXGty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 01:49:54 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:459 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S932239AbWAXGty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 01:49:54 -0500
Date: Tue, 24 Jan 2006 07:49:52 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH 02/04] Add dsa crypto ops
Message-ID: <20060124064952.GA18879@hardeman.nu>
Mail-Followup-To: Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, dhowells@redhat.com
References: <11380489523918@2gen.com> <E1F1Csk-0000lm-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <E1F1Csk-0000lm-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 12:22:02PM +1100, Herbert Xu wrote:
>David H?rdeman <david@2gen.com> wrote:
>>
>> +static int dsa_setkey(void *ctx, const u8 *key, unsigned int keylen, u32 *flags)
>> +{
>> +       struct dsa_ctx *dctx = ctx;
>> +
>> +       if (keylen != sizeof(struct key_payload_dsa *)) {
>> +               printk("Invalid key size in dsa_setkey\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       dctx->key = (struct key_payload_dsa *)key;
>> +       return 0;
>> +}
>
>This is bad.  You're putting a pointer to an object with an unknown
>lifetime into the tfm.
>
>Is there anything wrong with allocating the memory for it and storing
>the key in the tfm like everyone else?

No, not at all, it's a mistake and I'll change it...

