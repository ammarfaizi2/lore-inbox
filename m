Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291446AbSBSPxg>; Tue, 19 Feb 2002 10:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291447AbSBSPxZ>; Tue, 19 Feb 2002 10:53:25 -0500
Received: from [195.63.194.11] ([195.63.194.11]:6929 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S291446AbSBSPxH>;
	Tue, 19 Feb 2002 10:53:07 -0500
Message-ID: <3C7274BE.1030803@evision-ventures.com>
Date: Tue, 19 Feb 2002 16:52:30 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jakob Kemi <jakob.kemi@telia.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hex <-> int conversion routines.
In-Reply-To: <02021915240900.00635@jakob>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Kemi wrote:
> Hi,
> 
> When grepping through the kernel I noticed that there exists at least 27 
> (probably more with non-obvious names) different implementations of hex to
> int conversion functions. 2/3 of them in arch and the rest in drivers and fs.
> All implementations were variations of this function:

Fine...

> +static __inline__ int _hexint_byte(const char *src)
> +{

...

> +}

Not worth inlining. char conversion are seldomly time critical.


> +static __inline__ int hexint_nibble(char x)

Same applies here.

> +static __inline__ char inthex_nibble(int x)
> +{
> +	const char* digits = "0123456789abcdef";
> +
> +	return digits[x & 0x0f];
> +}

perhaps better do static const char *digits.

> +static __inline__ void inthex_byte(int x, char* dest)
> +{
> +	const char* digits = "0123456789abcdef";
> +
> +	dest[0] = digits[(x & 0xf0) >> 4];
> +	dest[1] = digits[x & 0x0f];
> +}

perhaps better do static const char *digits.

Regards.

