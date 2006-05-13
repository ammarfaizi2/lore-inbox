Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWEMTVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWEMTVk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 15:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWEMTVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 15:21:40 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:58542 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964780AbWEMTVj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 15:21:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nvwk2u18klW349XOUKTI+eDaKM0WFQv86EFffg8mWE36i5chZhx1ml7Klwyuw7CSsQehqLZu1Gy041FSjXYykpPTKvHuBR3UxAzP4UYQNNLQzZrgNpr7Kd3foeSXQ5ahZDvLOJlI1Q7CgfyKgxAPlVDoZ4A1KNw/bI9GqGHrdXA=
Message-ID: <9a8748490605131221nbadedf4p8904d9627f61f425@mail.gmail.com>
Date: Sat, 13 May 2006 21:21:38 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.17-rc4 6/6] Remove some of the kmemleak false positives
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060513160625.8848.76947.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060513155757.8848.11980.stgit@localhost.localdomain>
	 <20060513160625.8848.76947.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
>
> There are allocations for which the main pointer cannot be found but they
> are not memory leaks. This patch fixes some of them.
>
[snip]
> +#ifdef CONFIG_DEBUG_MEMLEAK
> +               /* avoid a false alarm. That's not a memory leak */
> +               memleak_free(out);
> +#endif

Hmm, so eventually we are going to end up with a bunch of ugly #ifdef
CONFIG_DEBUG_MEMLEAK's all over the place?

Wouldn't it be better to just make memleak_free() an empty stub in the
!CONFIG_DEBUG_MEMLEAK case?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
