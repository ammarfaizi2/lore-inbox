Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVCHPOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVCHPOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 10:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVCHPOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 10:14:46 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:26043 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261401AbVCHPOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 10:14:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=jc13C0J13Q4ATaWl/GuipD8ewNgYlttYgRQBVSZOi5xqOlSwgIMOco+QVbKYlmftimi767X08p5M2VJDAK9eEwdQVEHz1W2khG/xKWHLJuBf3+LSvXhs+D6ZpkM6Z2th2413F+BWqeLqzuDY63aJSZr7JQfK4rwqehUXJaDSs/k=
Message-ID: <d120d5000503080714ba3843d@mail.gmail.com>
Date: Tue, 8 Mar 2005 10:14:32 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Henk Vergonet <rememberme@god.dyndns.org>
Subject: Re: RFC: Harmonised parameter passing
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050308145923.GA9914@god.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050308145923.GA9914@god.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005 15:59:23 +0100, Henk Vergonet
<rememberme@god.dyndns.org> wrote:
> 
> Hi,
> 
> The current method of parameter passing to drivers build as a module is extremely usefull.
> Modules don't have to write there own parsing code, there's a nice macro that can be used to document specifics of the parameter and so on.
> 
> Could we extend this method where we use the same methodology for inbound drivers? (Currently a lot of drivers use their own parameter parsing code when it comes to passing values at kernel boot time.)
> 
> so we could do the regular:
> 
>        insmod mcd io=0x340
> 
> for modules, or with kernel boot parameters:
> 
>        mcd.io=0x340
> 
> for in-kernel drivers.
> 

Umm.. This is already done. For parameters defined with module_param()
you use <paramname>=<value> for modules and
<modulename>.<paramname>=<value> for built-in case.

> My proposal would be to introduce something like:
> 
> DRIVER_PARM_DESC(variable, description);
> DRIVER_PARM(variable, type, scope);
> 
>    where scope can be:
>        PARM_SCOPE_MODULE       => This parameter is used in module context.
>        PARM_SCOPE_KERNEL       => This parameter is used in kernel context.
>        PARM_SCOPE_MODULE | PARM_SCOPE_KERNEL
>                                => This parameter is used in both kernel and module context, which should be the default if scope is omitted.
> 

Why would you want parameters that only work for modules? I'd consider
it a bug, not a feature, when parameter works only when code is
modularized.

-- 
Dmitry
