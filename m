Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbTJATzl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 15:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbTJATzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 15:55:41 -0400
Received: from waste.org ([209.173.204.2]:32409 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262556AbTJATzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 15:55:39 -0400
Date: Wed, 1 Oct 2003 14:55:22 -0500
From: Matt Mackall <mpm@selenic.com>
To: Erlend Aasland <erlend-a@ux.his.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Steve French <sfrench@samba.org>,
       Samba Technical Mailing List <samba-technical@samba.org>,
       James Morris <jmorris@intercode.com.au>
Subject: Re: [PATCH CIFS] use CryptoAPI MD4/MD5
Message-ID: <20031001195522.GK1897@waste.org>
References: <20030902203041.GA25675@johanna5.ux.his.no> <20031001133039.GA32610@badne3.ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001133039.GA32610@badne3.ux.his.no>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 03:30:39PM +0200, Erlend Aasland wrote:

>  static int cifs_calculate_signature(const struct smb_hdr * cifs_pdu, const char * key, char * signature)
[...]

> +	spin_lock(&md5_tfm_lock);
> +	crypto_digest_init(md5_tfm);
> +	crypto_digest_update(md5_tfm, sg, 2);
> +	crypto_digest_final(md5_tfm, signature);
> +	spin_unlock(&md5_tfm_lock);

Eek. How often does this get called? We're now up to three instances
of CryptoAPI conversion (/dev/random, cryptoloop, and cifs) that want
tfms-on-the-stack but instead use extra locking.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
