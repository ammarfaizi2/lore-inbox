Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271703AbTHRQYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 12:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272454AbTHRQYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 12:24:44 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:56338 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S271703AbTHRQYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 12:24:42 -0400
Message-ID: <3F410185.2090804@techsource.com>
Date: Mon, 18 Aug 2003 12:40:37 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Forrest <forrest@lmcg.wisc.edu>
CC: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
       "'Willy Tarreau'" <willy@w.ods.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: generic strncpy - off-by-one error
References: <D069C7355C6E314B85CF36761C40F9A42E20BC@mailse02.se.axis.com> <20030816050415.A6986@rda07.lmcg.wisc.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Daniel Forrest wrote:

>  
> -	if (count) {
> +	if (count >= sizeof(long)) {
>  		size_t count2;
>  

I like this size check here, but the comparison should be to some number 
greater than sizeof(long).  There is a threshold below which it's not 
worth it to do all of the extra loops.  If you're going to fill only 
four bytes, it's probably best to do it just using the last loop.

Maybe through some trial and error, we could determine what that 
threshold is.  I'm betting it's something around 2* or 3* word size.


[snip]

> +
> +	while (count) {
> +		*tmp++ = '\0';
> +		count--;
>  	}
>  
>  	return dest;
>  }
> 


