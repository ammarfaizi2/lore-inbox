Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267233AbSKPGTQ>; Sat, 16 Nov 2002 01:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267234AbSKPGTP>; Sat, 16 Nov 2002 01:19:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22282 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267233AbSKPGTO>;
	Sat, 16 Nov 2002 01:19:14 -0500
Message-ID: <3DD5E4E2.2020101@pobox.com>
Date: Sat, 16 Nov 2002 01:25:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
CC: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] 2.5.47: strdup()
References: <87d6p63ui2.fsf@goat.bogus.local>
In-Reply-To: <87d6p63ui2.fsf@goat.bogus.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche wrote:

> This *untested* patch adds strdup(). There are about five or six
> different strdup() implementations in various parts of the kernel.
>

> +#ifndef __HAVE_ARCH_STRDUP
> +/**
> + * strdup - allocate memory and duplicate a string
> + */
> +char *strdup(const char *s)
> +{
> +	char *p = kmalloc(strlen(s) + 1, GFP_KERNEL);
> +	if (p)
> +		strcpy(p, s);
> +
> +	return p;
>  }



Comments:

* arch-specific strdup is unlikely

* IMO safer to create a strndup, and then update all strdup callers to 
use strndup...


