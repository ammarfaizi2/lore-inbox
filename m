Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030556AbVKDAIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030556AbVKDAIp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030554AbVKDAIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:08:44 -0500
Received: from mail25.sea5.speakeasy.net ([69.17.117.27]:41180 "EHLO
	mail25.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932702AbVKDAIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:08:44 -0500
Date: Thu, 3 Nov 2005 19:08:46 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Phillip Hellewell <phillip@hellewell.homeip.net>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
Subject: Re: [PATCH 12/12: eCryptfs] Crypto functions
In-Reply-To: <20051103035659.GL3005@sshock.rn.byu.edu>
Message-ID: <Pine.LNX.4.63.0511031902570.22256@excalibur.intercode>
References: <20051103033220.GD2772@sshock.rn.byu.edu> <20051103035659.GL3005@sshock.rn.byu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Phillip Hellewell wrote:

> +	crypto_cipher_setkey(crypt_stats->tfm, crypt_stats->key,
> +			     crypt_stats->key_size_bits / 8);

Check return value.

> +static void generate_random_key(unsigned char *key, int num_bytes)
> +{
> +	get_random_bytes(key, num_bytes);
> +}

Call get_random_bytes() directly.

> +	if (likely(1 == crypt_stats->encrypted)) {
> +		if (!crypt_stats->key_valid) {
> +			ecryptfs_printk(1, KERN_NOTICE, "Key is "
> +					"invalid; bailing out\n");
> +			rc = -EINVAL;
> +			goto out;
> +		}
> +	} else {
> +		rc = -EINVAL;
> +		ecryptfs_printk(0, KERN_WARNING,
> +				"Called with crypt_stats->encrypted == 0\n");
> +		goto out;
> +	}

What's going on here?  Is (crypt_stats->encrypted != 1) a kernel bug?


- James
-- 
James Morris
<jmorris@namei.org>
