Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbUAAK2r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 05:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265391AbUAAK2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 05:28:47 -0500
Received: from dp.samba.org ([66.70.73.150]:11697 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265390AbUAAK2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 05:28:46 -0500
Date: Thu, 1 Jan 2004 21:27:20 +1100
From: Anton Blanchard <anton@samba.org>
To: Joonas Kortesalmi <joneskoo@derbian.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: swapper: page allocation failure. order:3, mode:0x20
Message-ID: <20040101102720.GL28023@krispykreme>
References: <20040101093553.GA24788@derbian.org> <20040101101541.GJ28023@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040101101541.GJ28023@krispykreme>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Now e1000 uses TSO (and can regularly ask for 32kB+ kmallocs in
> interrupt context) perhaps we should look moving the rx buffer refill code
> into a context that can sleep. Then again its not like we can tolerate
> much latency in this code path, your rx ring will run out quite quickly :)

I hate to argue with myself, but thats crap. TSO only affects the TX
path and its buffers are created outside interrupt context. So it must be
a large MTU causing the failures, regardless it still makes sense to explore
rx skb refill outside of interrupt context idea.

Anton
