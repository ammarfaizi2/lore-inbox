Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbVAJUDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbVAJUDH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVAJUA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:00:27 -0500
Received: from smtpout01-04.mesa1.secureserver.net ([64.202.165.79]:32992 "HELO
	smtpout01-04.mesa1.secureserver.net") by vger.kernel.org with SMTP
	id S262515AbVAJTuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 14:50:25 -0500
Message-ID: <41E2DC8C.6080101@starnetworks.us>
Date: Mon, 10 Jan 2005 12:50:36 -0700
From: "Kevin P. Fleming" <kpfleming@starnetworks.us>
Organization: Star Networks, LLC
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] 2.4.19-rc1 number() stack reduction
References: <1105378550.4000.132.camel@dyn318077bld.beaverton.ibm.com> <1105378775.4000.138.camel@dyn318077bld.beaverton.ibm.com>
In-Reply-To: <1105378775.4000.138.camel@dyn318077bld.beaverton.ibm.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:

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

Is this actually correct? Since these are declared "static const", they 
are not on the stack anyway, because they have to persist between calls 
to this function and cannot be changed. I'd be very surprised if the 
compiler was copying this data from the static data segment to the stack 
on every entry to this function.
