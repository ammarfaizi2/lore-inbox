Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVEDRq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVEDRq3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVEDRqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:46:21 -0400
Received: from quark.didntduck.org ([69.55.226.66]:37538 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261314AbVEDRpu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:45:50 -0400
Message-ID: <42790A86.9070002@didntduck.org>
Date: Wed, 04 May 2005 13:46:46 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timmy Douglas <timmy+lkml@cc.gatech.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: macro in linux/compiler.h pollutes gcc __attribute__ namespace
References: <87vf5y99o3.fsf@mail.gatech.edu>
In-Reply-To: <87vf5y99o3.fsf@mail.gatech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timmy Douglas wrote:
> (I'm not subscribed so please CC me replies that you want me to reply
> to.)
> 
> Recently I've found a problem with emacs where gcc optimizes a
> function to be inline where it shouldn't be. The emacs developers use
> a macro like this:
> 
> #define NO_INLINE __attribute__((noinline))
> 
> that would normally work fine but when we compile the file with
> NO_INLINE, the -E output looks like:
> 
> static void __attribute__(())
> x_error_quitter (display, error)
>      Display *display;
>      XErrorEvent *error;
> {
>   char buf[256], buf1[356];
> 
> ...etc
> 
> 
> I've realized that this file includes linux/compiler.h which does:
> 
> 
>    139
>    140  #ifndef noinline
>    141  #define noinline
>    142  #endif
>    143
> 
> which causes __atribute__((noinline)) to change into
> __attribute__(()). I'm not sure how linux developers keep a function
> from getting inlined, but I'm hoping someone will consider removing or
> changing this macro.

The right question to be asking is why is emacs including kernel headers?

--
				Brian Gerst
