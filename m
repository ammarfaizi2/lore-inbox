Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbTFIOus (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 10:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264436AbTFIOus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 10:50:48 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:48784 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264426AbTFIOuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 10:50:46 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Joe Thornber <thornber@sistina.com>
Subject: Re: [PATCH 2/7] dm: signed/unsigned audit
Date: Mon, 9 Jun 2003 10:03:27 -0500
User-Agent: KMail/1.5
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
References: <20030609142946.GA11331@fib011235813.fsnet.co.uk> <20030609143523.GC11331@fib011235813.fsnet.co.uk>
In-Reply-To: <20030609143523.GC11331@fib011235813.fsnet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306091003.27762.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 June 2003 09:35, Joe Thornber wrote:
> signed/unsigned audit.

> --- diff/drivers/md/dm.c	2003-05-21 11:50:15.000000000 +0100
> +++ source/drivers/md/dm.c	2003-06-09 15:05:02.000000000 +0100
> @@ -546,21 +546,22 @@
>
>  	spin_lock(&_minor_lock);
>  	if (!test_and_set_bit(minor, _minor_bits))
> -		r = minor;
> +		r = 0;
>  	spin_unlock(&_minor_lock);
>
>  	return r;
>  }
>
> -static int next_free_minor(void)
> +static int next_free_minor(unsigned int *minor)
>  {
> -	int minor, r = -EBUSY;
> +	unsigned int m, r = -EBUSY;

Looks like "r" should still be signed.

>  	spin_lock(&_minor_lock);
> -	minor = find_first_zero_bit(_minor_bits, MAX_DEVICES);
> -	if (minor != MAX_DEVICES) {
> -		set_bit(minor, _minor_bits);
> -		r = minor;
> +	m = find_first_zero_bit(_minor_bits, MAX_DEVICES);
> +	if (m != MAX_DEVICES) {
> +		set_bit(m, _minor_bits);
> +		*minor = m;
> +		r = 0;
>  	}
>  	spin_unlock(&_minor_lock);
>

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

