Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbUBXRke (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 12:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbUBXRke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 12:40:34 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:4262 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262336AbUBXRkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 12:40:23 -0500
Message-ID: <403B8C78.2020606@colorfullife.com>
Date: Tue, 24 Feb 2004 18:40:08 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: dsw@gelato.unsw.edu.au, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.3 Slab corruption: errors are triggered when memory
 exceeds 2.5GB (correction)
References: <403AF155.1080305@colorfullife.com> <20040223225659.4c58c880.akpm@osdl.org>
In-Reply-To: <20040223225659.4c58c880.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Actually, it's often caused by someone doing atomic_dec_and_test() against
>something which was already freed.
>
The previous user is always kfree_skbmem - I would be surprised if there 
are atomic operations against the skb data area.

Darren, could you try the latest bk snapshot? Linus yesterday merged a 
patch that hexdumps the affected bytes. We must try to find a pattern - 
always same offset into a page, always same physical address, always 
same offset into the object, etc.

--
    Manfred

