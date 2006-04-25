Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWDYG62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWDYG62 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 02:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWDYG62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 02:58:28 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:37862 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751028AbWDYG61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 02:58:27 -0400
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Michael Holzheu <holzheu@de.ibm.com>
Cc: ioe-lkml@rameria.de, linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       joern@wohnheim.fh-wedel.de
In-Reply-To: <20060424191941.7aa6412a.holzheu@de.ibm.com>
References: <20060424191941.7aa6412a.holzheu@de.ibm.com>
Date: Tue, 25 Apr 2006 09:58:24 +0300
Message-Id: <1145948304.11463.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 19:19 +0200, Michael Holzheu wrote:
> +#ifndef __HAVE_ARCH_STRRTRIM
> +/**
> + * strrtrim - Remove trailing characters specified in @reject
> + * @s: The string to be searched
> + * @reject: The string of letters to avoid
> + */
> +void strrtrim(char *s, const char *reject)

I think this should return s to be consistent with other string API
functions.

> +{
> +	char *p;
> +	const char *r;

You need to exit here if strlen(s) is zero.

> +
> +	for (p = s + strlen(s) - 1; s <= p; p--) {
> +		for (r = reject; (*r != '\0') && (*p != *r); r++)
> +			/* nothing */;

Please use strchr for the above.

> +		if (*r == '\0')
> +			break;

What are you testing here?

> +	}
> +	*(p + 1) = '\0';
> +}
> +EXPORT_SYMBOL(strrtrim);
> +#endif


