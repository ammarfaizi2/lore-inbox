Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbWE0UU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWE0UU3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 16:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWE0UU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 16:20:29 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:41343 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964962AbWE0UU2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 16:20:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZTTzMWVqAA1d7rJeF/ONwDtkakp36W5nmgt89iD5uWo+NLUDv/UEk3BtIpegDuoAIfhx0/nv3WwKpGYwFgUIlMuSZnAkGMHG7+O/Eodpt7Dd1ywejTTKRvkkwjlN/CjraNXpwr3/i0oMVv7e2Sxe0sTN+e6nJUS0G/DquNcNrbc=
Message-ID: <b0943d9e0605271320t4a8384f0r376f082e9918350d@mail.gmail.com>
Date: Sat, 27 May 2006 21:20:27 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Anne Thrax" <foobarfoobarfoobar@gmail.com>
Subject: Re: [PATCH 2.6.17-rc5 1/7] Base support for kmemleak
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44789D3D.3020001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060527120709.21451.3187.stgit@localhost.localdomain>
	 <20060527122307.21451.84934.stgit@localhost.localdomain>
	 <44789D3D.3020001@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anne,

On 27/05/06, Anne Thrax <foobarfoobarfoobar@gmail.com> wrote:
>  mm/memleak.c: In function `insert_pointer':
>  mm/memleak.c:216: warning: unused variable `i'
>  mm/memleak.c: At top level:
>  mm/memleak.c:586: warning: 'memleak_scan' defined but not used
[...]
> If I'm not mistaken, you don't use 'i' outside of #ifdef CONFIG_FRAME_POINTER code.

Yes, indeed, I should've added "i" inside the CONFIG_FRAME_POINTER block.

> > +/* Scan the memory and print the orphan pointers */
> > +static void memleak_scan(void)
>
> I don't think this is used anywhere in memleak.c besides
> #ifdef CONFIG_DEBUG_FS code.

I'm actually thinking about removing the conditional compilation on
DEBUG_FS and just mandate this option. At the moment there is no other
way to find the memory leaks apart from /sys/kernel/debug/memleak. The
other option would be to scan the memory periodically from a timer or
kernel thread and print the findings.

Thanks.

-- 
Catalin
