Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWA0HY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWA0HY0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 02:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWA0HY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 02:24:26 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:10372 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S932410AbWA0HYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 02:24:25 -0500
Date: Fri, 27 Jan 2006 08:23:45 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, keyrings@linux-nfs.org
Subject: Re: [PATCH 00/04] Add DSA key type
Message-ID: <20060127072345.GB4082@hardeman.nu>
Mail-Followup-To: Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, dhowells@redhat.com,
	keyrings@linux-nfs.org
References: <11380489522362@2gen.com> <E1F2IJr-0007Gu-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <E1F2IJr-0007Gu-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.11
X-SA-Score: -2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 12:22:31PM +1100, Herbert Xu wrote:
>David H?rdeman <david@2gen.com> wrote:
>>
>> 3) Changes the keyctl syscall to accept six arguments (is it valid to do so?)
>>   and adds encryption as one of the supported ops for in-kernel keys.
>
>The asymmetric encryption support should be done inside the crypto/
>framework rather than as an extension to the key management system.

It is done inside the crypto/ framework. crypto/dsa.c implements the DSA 
signing as a hash crypto algorithm (since a DSA signature is two 160-bit 
integers, the result has a fixed size).

The above patch just adds the syscall to tell the in-kernel system that 
you wish to encrypt/sign something with a given key. In the case that 
the type of the given key is a DSA key, security/keys/dsa_key.c uses the 
dsa crypto alg from crypto/dsa.c to satisfy that request.

Regards,
David
