Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263004AbVF3QwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbVF3QwY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 12:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbVF3QwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 12:52:24 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:39923 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263004AbVF3Qv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 12:51:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type;
        b=RzUoKJM3Gz7XlucwO3kUta+0H2c/dN5Yy/J1yHL+1S1zepctBncUWUf9NzJfJ4IcpyjtmA//APJDr5iriM0hE1EDRXG9jHvbWhpo7AClIrThzGyjYGr8CdrCb3Iodai0I3nqZjMSqbkklyGjjrqnbz99sdjfNSzHTloWS8L65xg=
Message-ID: <42C4232B.7090904@gmail.com>
Date: Thu, 30 Jun 2005 22:21:55 +0530
From: Toufeeq Hussain <toufeeqh@gmail.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: 2.6.13-rc1 problems
References: <42C2EAE4.90007@gmail.com> <20050629120210.489db9fd.akpm@osdl.org>
In-Reply-To: <20050629120210.489db9fd.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=218783B9
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4D0B5F511F7A253D1DECB29F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4D0B5F511F7A253D1DECB29F
Content-Type: multipart/mixed;
 boundary="------------090102090306020402010103"

This is a multi-part message in MIME format.
--------------090102090306020402010103
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Try this:
> 
> --- 25/drivers/block/ll_rw_blk.c~get_request-nastiness	2005-06-29 09:36:27.000000000 -0700
> +++ 25-akpm/drivers/block/ll_rw_blk.c	2005-06-29 09:36:27.000000000 -0700
> @@ -1918,10 +1918,9 @@ get_rq:
>  	 * limit of requests, otherwise we could have thousands of requests
>  	 * allocated with any setting of ->nr_requests
>  	 */
> -	if (rl->count[rw] >= (3 * q->nr_requests / 2)) {
> -		spin_unlock_irq(q->queue_lock);
> +	if (rl->count[rw] >= (3 * q->nr_requests / 2))
>  		goto out;
> -	}
> +
>  	rl->count[rw]++;
>  	rl->starved[rw] = 0;
>  	if (rl->count[rw] >= queue_congestion_on_threshold(q))

working fine now.
No spurious messages in /var/log/kern.log or in /var/log/syslog.

Thanks,
Toufeeq

-- 
Linux 2.6.13-rc1 i686 GNU/Linux

--------------090102090306020402010103
Content-Type: text/x-vcard; charset=utf-8;
 name="toufeeqh.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="toufeeqh.vcf"

begin:vcard
fn:Toufeeq Hussain
n:Hussain;Toufeeq
email;internet:toufeeqh@gmail.com
tel;home:091-044-24832063
tel;cell:091-9840196690
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------090102090306020402010103--

--------------enig4D0B5F511F7A253D1DECB29F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCxCMr/4Tq3iGHg7kRAkghAKCFf2uW6L9vBSgVm/Z1k1A6PsonIwCfXTEI
o4sl0jEnzfNdONT3FtpCyHc=
=8HoW
-----END PGP SIGNATURE-----

--------------enig4D0B5F511F7A253D1DECB29F--
