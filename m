Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262694AbVAJVuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbVAJVuw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 16:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbVAJVdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:33:41 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:8684 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262675AbVAJVaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:30:00 -0500
Message-ID: <41E2F3CC.7040103@us.ibm.com>
Date: Mon, 10 Jan 2005 13:29:48 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] 2.4.19-rc1 number() stack reduction
References: <1105378550.4000.132.camel@dyn318077bld.beaverton.ibm.com> <1105378775.4000.138.camel@dyn318077bld.beaverton.ibm.com>
In-Reply-To: <1105378775.4000.138.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg-KH told me that, this patch is useless.  He told me that,
this won't save any stack since  "static constants" won't be
on the stack. I will take his word for it :)

Please ignore this patch.

Thanks,
Badari

Badari Pulavarty wrote:

> 
> ------------------------------------------------------------------------
> 
> Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
> --- linux-2.4.29-rc1.org/lib/vsprintf.c	2004-02-18 05:36:32.000000000 -0800
> +++ linux-2.4.29-rc1/lib/vsprintf.c	2005-01-07 07:56:00.000000000 -0800
> @@ -128,12 +128,16 @@ static int skip_atoi(const char **s)
>  #define SPECIAL	32		/* 0x */
>  #define LARGE	64		/* use 'ABCDEF' instead of 'abcdef' */
>  
> + /* Move these off of the stack for number().  This way we reduce the
> +  * size of the stack and don't have to copy them every time we are called.
> +  */
> +const char small_digits[] = "0123456789abcdefghijklmnopqrstuvwxyz";
> +const char large_digits[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
> +
>  static char * number(char * buf, char * end, long long num, int base, int size, int precision, int type)
>  {
>  	char c,sign,tmp[66];
>  	const char *digits;
> -	static const char small_digits[] = "0123456789abcdefghijklmnopqrstuvwxyz";
> -	static const char large_digits[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
>  	int i;
>  
>  	digits = (type & LARGE) ? large_digits : small_digits;

