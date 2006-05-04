Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbWEDSKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWEDSKU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 14:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWEDSKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 14:10:20 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:9960 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751506AbWEDSKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 14:10:19 -0400
Date: Thu, 4 May 2006 11:10:18 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Arjan van de Ven <arjan@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: limits / PIPE_BUF?
In-Reply-To: <1146765273.3101.68.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0605041104010.27916@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0605032244230.25908@shell2.speakeasy.net> 
 <1146725882.3101.11.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.58.0605040938310.19371@shell3.speakeasy.net> 
 <1146762968.3101.65.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.58.0605041044270.30003@shell2.speakeasy.net>
 <1146765273.3101.68.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2006, Arjan van de Ven wrote:

> On Thu, 2006-05-04 at 10:50 -0700, Vadim Lobanov wrote:
> > On Thu, 4 May 2006, Arjan van de Ven wrote:
> >
> > > On Thu, 2006-05-04 at 09:39 -0700, Vadim Lobanov wrote:
> > > > How does the kernel
> > > > code ensure that this value is honored, considering that PIPE_BUF is
> > > > not
> > > > referenced in any of the pipe code?
> > >
> > >
> > > the kernel implementation guarantees one page basically, and on all
> > > architectures that I know of that's at least 4096 bytes
> > >
> >
> > Alright, so sounds like this constant should remain inside the
> > include/linux/limits.h file. What about #defining it to be equal to
> > PAGE_SIZE, like ARM (include/linux-arm/limits.h, for example) does?
>
> there is a certain elegance in providing the same value on all
> architectures; it means apps don't suddenly break if you port it to
> a "lesser" one. Also there is a problem with PAGE_SIZE itself, that's a
> config option on several architectures, so it'd have to be a define for
> get_page_size() or something, at which point you change semantics since
> apps can't do
>
> char foo[PIPE_BUF];
>
> anymore
>

Good point.

I suppose this means that the limits.h header file is used, either
directly or indirectly, by both us (the kernel) and by user-space? If
so, blech! What's the policy on keeping around config values that don't
do anything inside the kernel anymore? The short list is:
 NR_OPEN
 ARG_MAX
 CHILD_MAX
 OPEN_MAX
 LINK_MAX
 MAX_CANON
 MAX_INPUT
 RTSIG_MAX

- Vadim Lobanov
