Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbUAHDdI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 22:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbUAHDdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 22:33:08 -0500
Received: from users.ccur.com ([208.248.32.211]:8013 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S263564AbUAHDdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 22:33:05 -0500
Date: Wed, 7 Jan 2004 22:32:24 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-ID: <20040108033224.GA13325@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <20040107165607.GA11483@rudolph.ccur.com> <20040107170650.0fca07a7.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107170650.0fca07a7.pj@sgi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 05:06:50PM -0800, Paul Jackson wrote:
> Joe proposed this change to the loop displaying masks:
> -		len += snprintf(buf+len, buflen-len, "%s%x", sep, wordp[i]);
> +		len += snprintf(buf+len, buflen-len, "%x%s", wordp[i], sep);
> 
> 
> I doubt that your patch is correct, Joe.
> 
> Consider for example the case that exactly three words are displayed.
> 
> Before your patch, the code would output one hex word, then (after
> looping around once) the "," separator and the second word, then on the
> final loop another separator and word, resulting in something such as:
> 
>     deadbeef,12345678,87654321
> 
> After your patch, it would output the first word, then the second word,
> then a trailing separator, and then the third word and separator,
> resulting in something such as:
> 
>     deadbeef12345678,87654321,

Sorry about the bit of conceptual dylexia on my part.

Paul, there might be a problem with __mask_snprintf_len.  Won't a
value that should be displayed as:

     d,00abcdef      be displayed as
     d,abcdef

Joe
