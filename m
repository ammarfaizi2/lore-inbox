Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbWDUI5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWDUI5e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 04:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWDUI5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 04:57:34 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:20427 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750797AbWDUI5d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 04:57:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=daXFtEl3E/e2H8Plx7kOLvMZjy6n/9u0v3V5hgCGQSr0ge89aSvgP2BEFStpJVPv2F6Ov1F3W0TMYUWUCViyy6VsOu8uBNwdN86hISgzNTWfBbiCrz+/CT1fqWFeUlJu9X3MH6m/gVE2XMLuNskEGTv4Mw5h6h1qR3FT23I4Nsw=
Message-ID: <84144f020604210157s406a08a7yd3c43d9ef2939ce@mail.gmail.com>
Date: Fri, 21 Apr 2006 11:57:32 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Nick Piggin" <npiggin@suse.de>
Subject: Re: [patch] mm: introduce remap_vmalloc_range (pls. drop previous patchset)
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Memory Management List" <linux-mm@kvack.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060421084503.GS21660@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060421084503.GS21660@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On 4/21/06, Nick Piggin <npiggin@suse.de> wrote:
> +       addr = (void *)((unsigned long)addr + (pgoff << PAGE_SHIFT));

As Andrew said, you can get rid of the casting with:

  addr += pgoff << PAGE_SHIFT;

> +       do {
> +               struct page *page = vmalloc_to_page(addr);
> +               ret = vm_insert_page(vma, uaddr, page);
> +               if (ret)
> +                       return ret;
> +
> +               uaddr += PAGE_SIZE;
> +               addr = (void *)((unsigned long)addr+PAGE_SIZE);

Same here.

                                        Pekka
