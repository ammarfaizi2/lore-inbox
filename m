Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWAQRcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWAQRcb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWAQRca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:32:30 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:35038 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932232AbWAQRca convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:32:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sCexE208PiT7A4V3j5fI7EvphPzjloRGkDxe8DMpHGESsXSa5SxxxOLuWKFt99k/6QG0JbUSITCjmCCCFLi5TCwJCjuEuenZaAYDoOzYzvAw7ztrlSUEpvGvl/09V5nmakxnfMtECY5dtrXhqhzTugT6zpYtW6N6Z2PXKaxpDXw=
Message-ID: <a36005b50601170932r1f0a9eb8kea35015ede1e9b8f@mail.gmail.com>
Date: Tue, 17 Jan 2006 09:32:29 -0800
From: Ulrich Drepper <drepper@gmail.com>
To: david singleton <dsingleton@mvista.com>
Subject: Re: [robust-futex-3] futex: robust futex support
Cc: akpm@osdl.org, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <C59522FA-8700-11DA-B27C-000A959BB91E@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43C84D4B.70407@mvista.com>
	 <a36005b50601141602y641567ebh5ff9b6a1fad4d7d2@mail.gmail.com>
	 <746DBAD6-855A-11DA-A824-000A959BB91E@mvista.com>
	 <a36005b50601142118h3a07a640ra668dab13129683b@mail.gmail.com>
	 <C59522FA-8700-11DA-B27C-000A959BB91E@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/06, david singleton <dsingleton@mvista.com> wrote:
>         I've fixed another memory leak in free_robust_list.   The entries in
> the slab caches
> now look correct through the full test suite up to 7500 threads.   Does
> your glibc
> work correctly with this patch?

I'll see shortly.

But looking at the patch, I don't understand the use of
FUTEX_ATTR_SHARED.  The EADDRNOTAVAIL error is something the kernel
has to return if the address is not that of an object in a shared
memory region.  It's not information directly provided by the user of
futex_register.

So, I suggest removing the attr parameter from futex_register and
after get_futex_key, when you know where the futex is actually
located, return -EADDRNOTAVAIL if the futex is in private memory.
