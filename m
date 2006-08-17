Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbWHQOAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWHQOAG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWHQN77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:59:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:30362 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932498AbWHQN7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:59:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uFhxFcHxNalEOQXCw1vLNWlSXMi03Z1C3xh7H1iZ5C82BX5L/GAL2mfcMAbPOeSCnpAZvcskpUcSm1qNBw1J3l8qSS3gccrE5zLELpRbVcEOVXxfHNErPCbCyJMii8McaKHVzwUiH4Bnf3+M9jQWjdwqy4v5ZEBQ01mFVxaCwLE=
Message-ID: <3f250c710608170659l3d0f92c7qfe2503ce8ab58dd5@mail.gmail.com>
Date: Thu, 17 Aug 2006 09:59:37 -0400
From: "Mauricio Lin" <mauriciolin@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Some issues about the kernel memory leak detector: __scan_block() function
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <b0943d9e0608170128l5f9cec1ej3d46ac797c4c4738@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3f250c710608161519o54433300heb1c79de6cbf6ce5@mail.gmail.com>
	 <b0943d9e0608170128l5f9cec1ej3d46ac797c4c4738@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 8/17/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> Hi Mauricio,
>
> On 16/08/06, Mauricio Lin <mauriciolin@gmail.com> wrote:
> > Let's suppose the a kmalloc() was executed without storing the
> > returned pointer to the memory area and its fictitious returned value
> > would be the address 0xb7d73000 as:
> >
> > kmalloc(32, GFP_KERNEL);  // Cause memory leak
> >
> > Is there any possibility the __scan_block() scans a memory block that
> > contains the memory area allocated by the previous kmalloc?
>
> That's what the memleak-test module does.
>
> Yes, there is a chance and this is called a false negative. If there
> is a (non-)pointer location having this value (especially the stack),
> it won't be reported. However, these locations might change and at
> some point you will get the leak reported.

Do you mean that the (non-)pointer location might be moved to another
memory location?

Let's say that the fictitious address 0xb7d73000 can be changed to
another memory address, right?

BR,

Mauricio Lin.
