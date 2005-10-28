Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbVJ1BnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbVJ1BnS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 21:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbVJ1BnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 21:43:18 -0400
Received: from xproxy.gmail.com ([66.249.82.203]:39745 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965046AbVJ1BnR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 21:43:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R+dr11aY/VXA6dvxkqnxDKBC7YufFifQJkk4TCDL7kjfA9knGz6LragC9xpk6aw/EhGhp+YxS0klvU/ZA4aRdwYJQSulNfA4Hv5sHdM44ld9lEDZRGTQGf/6mhIO6DqhzB9K0ybLkNk7ciniHpjQ4I5+oO0bTQUKWG5Q9vVrIiI=
Message-ID: <1e62d1370510271843y18fbeca9o52606b0c684c9884@mail.gmail.com>
Date: Fri, 28 Oct 2005 06:43:17 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Mishael A Sibiryakov <death@junki.org>
Subject: Re: Lock page with HIGHMEM
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1130457144.23846.40.camel@me.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1130457144.23846.40.camel@me.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/05, Mishael A Sibiryakov <death@junki.org> wrote:
>
> I have "little" troubles with HIGHMEM.
>
> The situation:
> I have a some pages which allocated via kmalloc(), after this pages is
> locked by get_page(). This pages is used in interrupt context, also in
> #PF too. When this code working on kernel without HIGHMEM support, then
> everything is fine. But when kernel with HIGHMEM then pages will be
> unmapped from linear space (i think) and i have a triple exception and
> you know that happens further :)
> I've try lock pages via get_user_pages, w/wo vma, by set
> SetPageReserved , Locked and etc. But nothing.
>

Here you mean that you allocated memory from kmalloc which corresponds
to some pages and then you are dealing with those pages ! right ? Then
you can use alloc_page/pages to get the page directly or there is some
reason for not to use them ?

AFAIK kernel keeps the seperate virtual addresses range for mapping
HIGHMEM to ZONE_NORMAL (PKMAP_BASE to PKMAP_BASE + LAST_PKMAP) which
is from the area called as VMALLOC_RESERVE used for holding temporary
mappings and kmalloc like rountines returned memory will never be
unmapped or at-least I havn't saw this behaviour.

> How i can avoid this problem ? E.g. how i can lock page in kernel and be
> assured about that that it will not be unmapped, and can be accessed via
> linear address every time ?
>

If you got page/memory from the kernel functions like
alloc_page/kmalloc then they are not unmapped and if they unmapped in
any case (which I think won't) then kernel is responsible to mapping
them back when ever you will be going to use it !

--
Fawad Lateef
