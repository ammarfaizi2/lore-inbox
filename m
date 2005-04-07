Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVDGIfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVDGIfU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 04:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVDGIej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 04:34:39 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:943 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262279AbVDGIXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 04:23:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=fs4mwzUYyUYMF2LXYqK+kJ1waGiMx3wnR3A7pd+Ip9ZhQAeR7xDa7sgrdy+Zgg9umXdicLjnqDpcBVrkiv0hUlnDQSqpm9ySiJaEsZEgdXiji8F0QWX3WapRtS7HavNNABjjCgGgifIM8fFnYVDl0MA6mxfFdkzuL2xc+fCoXbE=
Message-ID: <aec7e5c305040701236289aacd@mail.gmail.com>
Date: Thu, 7 Apr 2005 10:23:32 +0200
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Roland Dreier <roland@topspin.com>
Subject: Re: [PATCH][RFC] disable built-in modules V2
Cc: AsterixTheGaul <asterixthegaul@gmail.com>,
       Magnus Damm <damm@opensource.se>, linux-kernel@vger.kernel.org
In-Reply-To: <528y3v72al.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050405225747.15125.8087.59570@clementine.local>
	 <54b5dbf505040618324186678a@mail.gmail.com>
	 <528y3v72al.fsf@topspin.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 7, 2005 4:23 AM, Roland Dreier <roland@topspin.com> wrote:
>  > > -#define module_init(x) __initcall(x);
>  > > +#define module_init(x) __initcall(x); __module_init_disable(x);
>  >
>  > It would be better if there is brackets around them... like
>  >
>  > #define module_init(x) { __initcall(x); __module_init_disable(x); }
>  >
>  > then we know it wont break some code like
>  >
>  > if (..)
>  >  module_init(x);
> 
> This is all completely academic, since module_init() is a declaration
> that won't be inside any code, but in general it's better still to use
> the do { } while (0) idiom like
> 
> #define module_init(x) do { __initcall(x); __module_init_disable(x); } while (0)
> 
> so it won't break code like
> 
>         if (..)
>                 module_init(x);
>         else
>                 something_else();
> 
> (Yes, that code is nonsense but if you're going to nitpick, go all the way...)

Right. =)
Anyway, besides nitpicking, is there any reason not to include this
code? Or is the added feature considered plain bloat? Yes, the kernel
will become a bit larger, but all the data added by this patch will go
into the init section.

/ magnus
