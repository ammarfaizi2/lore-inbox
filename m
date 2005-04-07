Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbVDGVdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbVDGVdg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 17:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVDGVdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 17:33:36 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:1239 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262610AbVDGVd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 17:33:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=HdIdOrBhv1/5HjUksokYlyepPa+8BezE6kpWS2UwQrJfoPT5F6NyWiX0T7xzE3Q8Rq7qu6tSOHPREUlY4PzW/9jbHZzQjDWgJtz6pLjCqMEHowEgajesj3o/wGG7EjAjCHQ8tiHHb2hoN7sBUmcUkEqXeXdrwGBhaqHtssaF2Uo=
Message-ID: <aec7e5c3050407143345397639@mail.gmail.com>
Date: Thu, 7 Apr 2005 23:33:25 +0200
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH][RFC] disable built-in modules V2
Cc: AsterixTheGaul <asterixthegaul@gmail.com>,
       Magnus Damm <damm@opensource.se>, linux-kernel@vger.kernel.org
In-Reply-To: <200504070238.j372cGQN005597@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <asterixthegaul@gmail.com>
	 <54b5dbf505040618324186678a@mail.gmail.com>
	 <200504070238.j372cGQN005597@laptop11.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 7, 2005 4:38 AM, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> AsterixTheGaul <asterixthegaul@gmail.com> said:
> > > -#define module_init(x) __initcall(x);
> > > +#define module_init(x) __initcall(x); __module_init_disable(x);
> >
> > It would be better if there is brackets around them... like
> >
> > #define module_init(x) { __initcall(x); __module_init_disable(x); }
> >
> > then we know it wont break some code like
> >
> > if (..)
> >  module_init(x);
> 
> But happily break:
> 
>    if (...)
>     module_init(x);
>    else
>     ...
> 
> This should be:
> 
> #define module_init(x)  do {__initcall(x); __module_init_disable(x);}while(0)

Yes and no. =) Wrapping defines in do {} while(0) is nice when you are
using the defined constants inside functions. module_init() OTOH is
never used inside a function and your suggestion leads to compile
errors:

  CC      arch/i386/kernel/dmi_scan.o
  CC      arch/i386/kernel/bootflag.o
arch/i386/kernel/bootflag.c:99: error: parse error before "do"
arch/i386/kernel/bootflag.c:99: error: parse error before '}' token
make[1]: *** [arch/i386/kernel/bootflag.o] Error 1
make: *** [arch/i386/kernel] Error 2
damm@clementine linux-2.6.12-rc2-disable_builtin $

/ magnus
