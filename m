Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265726AbTL3J7H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 04:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265730AbTL3J7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 04:59:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:26272 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265726AbTL3J7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 04:59:04 -0500
Date: Tue, 30 Dec 2003 01:58:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] optimize ia32 memmove
In-Reply-To: <3FF12FC7.5030202@pobox.com>
Message-ID: <Pine.LNX.4.58.0312300152250.2065@home.osdl.org>
References: <200312300713.hBU7DGC4024213@hera.kernel.org> <3FF129F9.7080703@pobox.com>
 <20031229235158.755e026c.akpm@osdl.org> <3FF12FC7.5030202@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Dec 2003, Jeff Garzik wrote:
> 
> I'm confused... that doesn't say anything to me about overlap.
> 
> They can still overlap:  Consider if dest is 1 byte less than src, and 
> n==128...

But then anything that does the loads in ascending order is still ok, so
it shouldn't matter - by the time "dest" has been overwritten, the source
data has already been read. And all the "memcpy()"  implementations had
better do that anyway, in order to get nice memory access patterns. "rep
movsl" certainly does.

So assuming we have an ascending "memcpy()", the only case we need to care 
about is "overlap && dest > src".

Now, if we have a non-ascending memcpy(), we have trouble. 

		Linus
