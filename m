Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUL0RSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUL0RSq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 12:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbUL0RSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 12:18:46 -0500
Received: from [62.206.217.67] ([62.206.217.67]:57809 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261932AbUL0RSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 12:18:37 -0500
Message-ID: <41D043AC.2070203@trash.net>
Date: Mon, 27 Dec 2004 18:17:32 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maillist netdev <netdev@oss.sgi.com>
Subject: Re: PATCH: kmalloc packet slab
References: <1104156983.20944.25.camel@localhost.localdomain>
In-Reply-To: <1104156983.20944.25.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> The networking world runs in 1514 byte packets pretty much all the time.
> This adds a 1620 byte slab for such objects and is one of the internally
> generated Red Hat patches we use on things like Fedora Core 3. Original:
> Arjan van de Ven.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

Why 1620 bytes ? Most drivers allocate packet_size + 2 bytes.
dev_alloc_skb adds another 16 bytes, finally alloc_skb adds
sizeof(struct skb_shared_info). So we get:

(32bit): 1514b + 2b + 16b + 160b = 1692b
(64bit): 1514b + 2b + 16b + 312b = 1844b

On paths using alloc_skb instead of dev_alloc_skb it's 16 bytes
less, but 1620 bytes is still too small for full-sized packets.

Regards
Patrick
