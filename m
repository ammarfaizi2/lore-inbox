Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbUBXG5E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 01:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbUBXG5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 01:57:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:63112 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262090AbUBXG5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 01:57:01 -0500
Date: Mon, 23 Feb 2004 22:56:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: dsw@gelato.unsw.edu.au, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.3 Slab corruption: errors are triggered when memory
 exceeds 2.5GB (correction)
Message-Id: <20040223225659.4c58c880.akpm@osdl.org>
In-Reply-To: <403AF155.1080305@colorfullife.com>
References: <403AF155.1080305@colorfullife.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
>  From your logs:
> 
> >Feb 23 14:54:24 calypso kernel: Slab corruption: start=e00000017e84ea00, expend=e00000017e84f1ff, problemat=e00000017e84f020
> >Feb 23 14:54:24 calypso kernel: Last user: [<a0000001003c9f30>](kfree_skbmem+0x30/0x80)
> >Feb 23 14:54:24 calypso kernel: Data: ************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************!
**!
> ***************************************
> >Feb 23 14:54:28 calypso kernel: **************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************6A *************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************!
**!
> ***************************************
> >Feb 23 14:54:28 calypso kernel: ************************************************************A5 
> >  
> >
> "6a" instead of 0x6b. One bit is wrong, this is often an indication of a 
> hardware problem. Do you use ECC memory and is ECC enabled in the BIOS?

Actually, it's often caused by someone doing atomic_dec_and_test() against
something which was already freed.  Or spin_lock().  One would need to work
out what field is at that offset.  If it is an atomic_t or a spinlock_t,
there you are.


