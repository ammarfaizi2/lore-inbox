Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWJQIFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWJQIFV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 04:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWJQIFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 04:05:21 -0400
Received: from poczta.o2.pl ([193.17.41.142]:49879 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S932229AbWJQIFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 04:05:19 -0400
Date: Tue, 17 Oct 2006 10:10:20 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: Amit Choudhary <amit2030@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: potential mem leak when system is low on memory
Message-ID: <20061017081020.GB1742@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	Amit Choudhary <amit2030@gmail.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <123917630610161552o3d71416yf3df76c49c3e7c22@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-10-2006 00:52, Amit Choudhary wrote:
> Hi All,
> 
> I was just scrubbing the kernel for checking the return ststus of
> kmalloc(), and I saw at many places the following things. I just
> wanted to report this.
> 
> 1. If there are more than one kmalloc() calls in the same function,
> and if kmalloc() returns NULL for one of them, then the memory
> obtained from previous kmalloc() calls is not released.
> 
> Something like:
> 
> func()
> {
>    var1 = kmalloc(size);
>    if (!var1)
>         return -ENOMEM;
> 
>    var2 = kmalloc(size);
>    if (!var2)
>         return -ENOMEM;
> 
> /* mem  leak as var1 is not freed */
> 
> }
> 
> 2. Sometimes, memory is allocated in a loop. So, if kmalloc() fails at
> some point, memory allocated previously is not released.
> 
> func()
> {
>    for (i = 0; i < LENGTH; i++) {
>            var1[i] = kmalloc(size);
>            if (!var1[i])
>                 return -ENOMEM;
> 
> /* mem leak as var1[0] to var1[i - 1] is not freed */
> 
>    }
> }
> 
> So, already the system is running low on memory and on top of it there
> are leaks.

So you've found elementary programming bugs and it would
be nice to point this places.

Jarek P.
