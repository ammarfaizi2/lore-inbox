Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262887AbTCSBxX>; Tue, 18 Mar 2003 20:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262888AbTCSBxX>; Tue, 18 Mar 2003 20:53:23 -0500
Received: from pizda.ninka.net ([216.101.162.242]:14501 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262887AbTCSBxW>;
	Tue, 18 Mar 2003 20:53:22 -0500
Date: Tue, 18 Mar 2003 18:02:19 -0800 (PST)
Message-Id: <20030318.180219.91189534.davem@redhat.com>
To: ak@suse.de
Cc: andrea@suse.de, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.4 delayed acks don't work, fixed
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030319015517.GA15150@wotan.suse.de>
References: <20030319002409.GI30541@dualathlon.random>
	<20030318.163701.56035556.davem@redhat.com>
	<20030319015517.GA15150@wotan.suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Wed, 19 Mar 2003 02:55:17 +0100

   > This streamer application should buffer at the sending side, in order
   > to keep the window full.  Introducing artificial delays on the sending
   > side of a unidirectional TCP transfer is really bad for performance
   > and I can assure you that more than just "weird delayed ACK" behavior
   > will result.
   
   The broken tail append patch I did some time ago was supposed to address 
   that (better merging of writes on the sender side even for non SG
   NICs). Perhaps it should be rechecked.
   
   It may fix this.

I think we're talking about independant problems.

This streamer application buffers, but once the buffer is fully pushed
to the other end and the "receiver catches up", we get periodic sends
created at the rate of device data creation.  This cannot fill the
pipe between sender and receiver, thus TCP behaves suboptimally.

TCP needs at least a full window of data on the send side to clock
things properly.  This streamer application doesn't give TCP that
after it's initial send buffering is been shrunk.
