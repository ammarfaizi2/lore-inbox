Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWCTXw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWCTXw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 18:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWCTXw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 18:52:59 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:16581 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750916AbWCTXw6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 18:52:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WH8LWqJuMb5Rztn6Umwyl7gLOHLePcPzRFCfjNFA4a+tcYa7vi3QdCtFUAPh0ZBpfAxXZkR8Cb+KSImIDMFa+CTzKH6sE5qYhoYNsPqnxSAR1lrWyc/CjlNhJ2JT0hgntqib2MtZqmugK3sDb2GQY3kjuWB9dLjCV0PrCLjKrWo=
Message-ID: <5c49b0ed0603201552j58150a18lbf4d0a9b0406d175@mail.gmail.com>
Date: Mon, 20 Mar 2006 15:52:55 -0800
From: "Nate Diller" <nate.diller@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [PATCH][0/8] (Targeting 2.6.17) Posix memory locking and balanced mlock-LRU semantic
Cc: "Stone Wang" <pwstone@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <1142862078.3114.47.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bc56f2f0603200535s2b801775m@mail.gmail.com>
	 <1142862078.3114.47.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > 1. Posix mlock/munlock/mlockall/munlockall.
> >    Get mlock/munlock/mlockall/munlockall to Posix definiton: transaction-like,
> >    just as described in the manpage(2) of mlock/munlock/mlockall/munlockall.
> >    Thus users of mlock system call series will always have an clear map of
> >    mlocked areas.
> > 2. More consistent LRU semantics in Memory Management.
> >    Mlocked pages is placed on a separate LRU list: Wired List.
>
> please give this a more logical name, such as mlocked list or pinned
> list

Shaoping, thanks for doing this work, it is something I have been
thinking about for the past few weeks.  It's especially nice to be
able to see how many pages are pinned in this manner.

Might I suggest calling it the long_term_pinned list?  It also might
be worth putting ramdisk pages on this list, since they cannot be
written out in response to memory pressure.  This would eliminate the
need for AOP_WRITEPAGE_ACTIVATE.

NATE
