Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965304AbVKHTjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965304AbVKHTjz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 14:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965305AbVKHTjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 14:39:55 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:54203 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965304AbVKHTjy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 14:39:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=obFGKf7YsdYybgx70UCqr8kcOyyWeS+MuexdUUvMONlt/E84EsNI1+rCizikpzl/g8Oi+UcNgEoe4+55cdK5AObk27lGzOC6YmQclFx+L0UhPqdxRu3W1djqFHw4GIaMjA/Y1n8P4G9OvEkWK0UQzgsjPXJRx58Ch7yxOplTxec=
Message-ID: <b6c5339f0511081139y7ab57ea9y498d9cf4aae9692b@mail.gmail.com>
Date: Tue, 8 Nov 2005 14:39:51 -0500
From: Bob Copeland <email@bobcopeland.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: Compatible fstat()
Cc: Parag Warudkar <kernel-stuff@comcast.net>, Al Viro <viro@ftp.linux.org.uk>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0511081316390.4913@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0511081040580.3894@chaos.analogic.com>
	 <3587A59B-14FA-4E0F-A598-577E944FCF36@comcast.net>
	 <20051108172244.GR7992@ftp.linux.org.uk>
	 <23F8E4C6-3141-4ECB-B3FF-E9BE6D261EE1@comcast.net>
	 <Pine.LNX.4.61.0511081308360.4837@chaos.analogic.com>
	 <C65925DE-0F6F-401E-8D47-2EE3F8D5191C@comcast.net>
	 <Pine.LNX.4.61.0511081316390.4913@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yeah I corrected that before trying but still didn't work on Debian
> > (2.6.8 kernel)...
> > Running root, open successful but size is always zero - Strange..
> >
> > Parag
>
> Also found that the returned value was -1 and errno was EOVERFLOW.
> So, that doesn't work either!

Isn't this just because the device size is > 2**32?  What if you use fseeko(3)
and #define _FILE_OFFSET_BITS 64?

Okay, still not portable and there is probably a better way that doesn't rely
on such nonsense.  For example, since you have a minimum size in mind,
just seek that much and see if it works - you don't really need to know the
whole disk size for that.  Or figure out the best way on all of your platforms
and abstract it.

-Bob
