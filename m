Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbTEHQLQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbTEHQLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:11:16 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:260 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261835AbTEHQLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:11:14 -0400
Date: Thu, 8 May 2003 13:24:35 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, haveblue@us.ibm.com, akpm@digeo.com,
       rmk@arm.linux.org.uk, rddunlap@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: The magical mystical changing ethernet interface order
Message-ID: <20030508162434.GB9526@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
	haveblue@us.ibm.com, akpm@digeo.com, rmk@arm.linux.org.uk,
	rddunlap@osdl.org, linux-kernel@vger.kernel.org
References: <3EB98878.5060607@us.ibm.com> <1052395526.23259.0.camel@rth.ninka.net> <1052405730.10038.51.camel@dhcp22.swansea.linux.org.uk> <20030508.075438.52189319.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508.075438.52189319.davem@redhat.com>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 08, 2003 at 07:54:38AM -0700, David S. Miller escreveu:
>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 08 May 2003 15:55:31 +0100
> 
>    Unfortunately for the ISA driver code we *have* to rely on link
>    order or rip out the __init stuff and use Space.c type hacks.
>    
> I do no argue that needing an invocation order is bogus.
> I merely disagree with the way we're trying to achieve it.
> 
> You don't need Space.c magic, the linker in binutils has mechanisms by
> which this can be accomplished and we already use this in 2.5.x
> 
> Have a peek at __define_initcall($NUM,fn), imagine it with one more
> argument $PRIO.  It might look like this:
> 
> #define __define_initcall(level,prio,fn) \
>         static initcall_t __initcall_##fn __attribute__
>         ((unused,__section__ ("\.initcall" level "." prio ".init"))) = fn
> 
> Use the 'prio' number to define the ordering.  The default for
> modules that don't care about relative ordering within a class
> use a value like "9999" or something like that.

I was thinking of a different implementation, that I just made sure to forgot
as this one seems _much_ nicer indeed.
 
- Arnaldo
