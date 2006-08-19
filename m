Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWHSKHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWHSKHI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 06:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbWHSKHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 06:07:08 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:65491 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751688AbWHSKHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 06:07:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JP40kBPfYQKYplZxAdTb8dKwCssUZX4o8Vum20EsTvaJFcxif4mATbFAXhqjrtsFLF0h9zqqC8EHqZLP/0aZZ2nd0JDbMTbm15cHMJlvLBCNrlKpmr89iuu3sWOpslJ+Gx/e+XaLj70vAL82A/HGQbcpq3wkEzv0dbG5dbzZ3lA=
Message-ID: <b0943d9e0608190307v5853f38dja21ad65e2c67840c@mail.gmail.com>
Date: Sat, 19 Aug 2006 11:07:04 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       "Antonino A. Daplas" <adaplas@pol.net>
Subject: Re: [PATCH 2.6.18-rc4 00/10] Kernel memory leak detector 0.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0608181549o3034398fob3763d3ce0869cfe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
	 <b0943d9e0608180627g61007207read993387bf0c0b4@mail.gmail.com>
	 <6bffcb0e0608180655j50332247m8ed393c37d570ee4@mail.gmail.com>
	 <6bffcb0e0608180715v27015481vb7c603c4be356a21@mail.gmail.com>
	 <b0943d9e0608180846s4ed560b7ld4e3081bdc754454@mail.gmail.com>
	 <6bffcb0e0608180942l12e342epd60dffbb5c5d4b3e@mail.gmail.com>
	 <b0943d9e0608180957w60d22261k61b272c9b76505bd@mail.gmail.com>
	 <6bffcb0e0608181438m3406de08q9a168d486127aef@mail.gmail.com>
	 <b0943d9e0608181447t5503b24eyfea6f3903c2ba27d@mail.gmail.com>
	 <6bffcb0e0608181549o3034398fob3763d3ce0869cfe@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> I just added your "Fix memory leak in vc_resize/vc_allocate" patch to
> my series file.
>
> orphan pointer 0xc6110000 (size 12288):
>   c017480e: <__kmalloc>
>   c024dda4: <vc_resize>
>   c020ed9c: <fbcon_startup>
>   c0251028: <register_con_driver>
>   c02511e0: <take_over_console>
>   c020e21e: <fbcon_takeover>
>   c0212b08: <fbcon_fb_registered>
>   c0212ce1: <fbcon_event_notify>
> orphan pointer 0xf55b0000 (size 8208):
>   c017480e: <__kmalloc>
>   c0211bb8: <fbcon_set_font>
>   c0251b17: <con_font_set>
>   c0251c7b: <con_font_op>
>   c0249a97: <vt_ioctl>
>   c024432e: <tty_ioctl>
>   c0189fd1: <do_ioctl>
>   c018a269: <vfs_ioctl>

The second one is probably a false positive as the stored pointer is
different from the one returned by kmalloc (there is some padding).
I'll add it to the kmemleak-false-positives patch.

The first one might be a real leak. Anotonino, any idea about this?

Thanks.

-- 
Catalin
