Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263092AbVCJULm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263092AbVCJULm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 15:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263116AbVCJUHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 15:07:00 -0500
Received: from mx2.mail.ru ([194.67.23.122]:51480 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S263101AbVCJUEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 15:04:21 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Kylene Hall <kjhall@us.ibm.com>
Subject: Re: [PATCH] Add TPM hardware enablement driver
Date: Thu, 10 Mar 2005 23:04:54 +0200
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <1110415321526@kroah.com>
In-Reply-To: <1110415321526@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503102304.54927.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 March 2005 02:42, Greg KH wrote:

> [PATCH] Add TPM hardware enablement driver

> +static ssize_t tpm_transmit(struct tpm_chip *chip, const char *buf,
> +			    size_t bufsiz)
> +{

> +	u32 count;
> +	__be32 *native_size;
> +
> +	native_size = (__force __be32 *) (buf + 2);
> +	count = be32_to_cpu(*native_size);

__force in a driver?

	count = be32_to_cpup((__be32 *) (buf + 2));

should be enough. Once done you can remove "native_size".

> +static int tpm_atml_recv(struct tpm_chip *chip, u8 * buf, size_t count)
> +{

> +	u32 size;

> +	__be32 *native_size;

> +	/* size of the data received */
> +	native_size = (__force __be32 *) (hdr + 2);
> +	size = be32_to_cpu(*native_size);

> +static int tpm_nsc_recv(struct tpm_chip *chip, u8 * buf, size_t count)
> +{

> +	u32 size;
> +	__be32 *native_size;

> +	native_size = (__force __be32 *) (buf + 2);
> +	size = be32_to_cpu(*native_size);

Same story.

	Alexey
