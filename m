Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbVJUNGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbVJUNGP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 09:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbVJUNGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 09:06:15 -0400
Received: from qproxy.gmail.com ([72.14.204.204]:4953 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964937AbVJUNGO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 09:06:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H+naKx9+0AwQ/e6cIheIzeIw2nBWFfJsoZthwLdKrCmAl6KNtxo42M7Lm9AQz6638SeQRLlS6Bv0kTTRXLFJx8dSmAF3wnE70bbLYuEtueywm1E1Aa2bWz6Y8OXsHGButJ9xoKGl0yUJ8wF6Ey+BZq0vTgDXF4D2XQfmN+wGViM=
Message-ID: <9a8748490510210606n186d054cuc81a75211ab6d5d5@mail.gmail.com>
Date: Fri, 21 Oct 2005 15:06:13 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: Allow users to force a panic on NMI
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1129900906.26367.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1129900906.26367.33.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> The default Linux behaviour on an NMI of either memory or unknown is to
> continue operation. For many environments such as scientific computing
> it is preferable that the box is taken out and the error dealt with than
> an uncorrected parity/ECC error get propogated.
>
[snip]
>  {
>         printk("Uhhuh. NMI received. Dazed and confused, but trying to continue\n");
>         printk("You probably have a hardware problem with your RAM chips\n");
> +
> +       if(panic_on_unrecovered_nmi)
> +               panic("NMI: Not continuing");
>

How about something like this instead?

printk(KERN_WARNING "Uhhuh. NMI received. Dazed and confused\n");
printk(KERN_WARNING "You probably have a hardware problem with your
RAM chips\n");

if (panic_on_unrecovered_nmi)
        panic("NMI: panic_on_unrecovered_nmi enabled - Not continuing");
else
        printk(KERN_WARNING "NMI: panic_on_unrecovered_nmi disabled -
continuing\n");


First of all then it won't start out by saying that it's going to
continue, only to panic a few lines down.
Secondly it shows clearly to anyone reading the messages that there's
a control available for changing the behaviour, and that person can
then go look up how that's done.

Just a suggestion...


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
