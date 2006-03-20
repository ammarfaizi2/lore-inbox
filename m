Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWCTHZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWCTHZJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 02:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWCTHZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 02:25:09 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:61049 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932183AbWCTHZH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 02:25:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QAWRIziitDJIJBC3oSadED6LDZwTO4P+A6xsqyDEwi+Z7fhyQIGNANaiBy6msiuaga6Pk6fJN87z123jWNOnAFEr9BFLbbSTGwtg3Lu8IXSu4fLcQ5gMGnaJnf8h0CtaH5puT12/2pK9XfinkVhcUJhNjFywQwY+YNqFM6XZKus=
Message-ID: <84144f020603192325h54fd3212l1f4846fd40b9f074@mail.gmail.com>
Date: Mon, 20 Mar 2006 09:25:06 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Oliver Neukum" <oliver@neukum.org>
Subject: Re: [PATCH]use kzalloc in vfs where appropriate
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Matthew Wilcox" <matthew@wil.cx>, viro@zeniv.linux.org.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <200603192150.23444.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0603172153160.30725@fachschaft.cup.uni-muenchen.de>
	 <200603191429.21776.oliver@neukum.org>
	 <1142784566.3018.18.camel@laptopd505.fenrus.org>
	 <200603192150.23444.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On 3/19/06, Oliver Neukum <oliver@neukum.org> wrote:
> Yes it is. The generated code is identical. But on second thought this is still
> not optimal. A full division is generated:
>
>         xorl    %edx, %edx
>         movl    $2147483647, %eax
>         movq    $0, 40(%rsp)
>         divq    %rcx
>         movl    $8, %edx
>         cmpq    %rax, %rdx
>         ja      .L313
>
> Rewriting the test as:
> n!=0 && n > INT_MAX / size
> saves the division because size is much likelier to be a constant, and indeed
> the code is better:
>
>         cmpq    $268435455, %rax
>         movq    $0, 40(%rsp)
>         ja      .L313
>
> Is there anything I am missing?

Did you check allyesconfig vmlinux size before and after? If it helps,
like it probably does, post a patch!

                                   Pekka
