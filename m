Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWCTNQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWCTNQq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWCTNQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:16:46 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:18612 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932288AbWCTNQp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:16:45 -0500
Date: Mon, 20 Mar 2006 15:16:18 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Denis Vlasenko <vda@ilport.com.ua>
cc: Oliver Neukum <oliver@neukum.org>, Arjan van de Ven <arjan@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, viro@zeniv.linux.org.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]use kzalloc in vfs where appropriate
In-Reply-To: <200603201508.47960.vda@ilport.com.ua>
Message-ID: <Pine.LNX.4.58.0603201515020.19645@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0603172153160.30725@fachschaft.cup.uni-muenchen.de>
 <200603192150.23444.oliver@neukum.org> <84144f020603192325h54fd3212l1f4846fd40b9f074@mail.gmail.com>
 <200603201508.47960.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 March 2006 09:25, Pekka Enberg wrote:
> > > Rewriting the test as:
> > > n!=0 && n > INT_MAX / size
> > > saves the division because size is much likelier to be a constant, and indeed
> > > the code is better:
> > >
> > >         cmpq    $268435455, %rax
> > >         movq    $0, 40(%rsp)
> > >         ja      .L313
> > >
> > > Is there anything I am missing?

On Mon, 20 Mar 2006, Denis Vlasenko wrote:
> You may drop "n!=0" part, but you must check size!=0.
> Since if size is 0, kcalloc returns NULL, then
> 
>         if (!size || n > INT_MAX / size)
>                 return NULL;

Uh, oh, I must be getting blind to have missed that...

				Pekka
