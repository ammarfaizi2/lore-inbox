Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262849AbTCSA21>; Tue, 18 Mar 2003 19:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262854AbTCSA20>; Tue, 18 Mar 2003 19:28:26 -0500
Received: from pizda.ninka.net ([216.101.162.242]:52388 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262849AbTCSA2F>;
	Tue, 18 Mar 2003 19:28:05 -0500
Date: Tue, 18 Mar 2003 16:37:01 -0800 (PST)
Message-Id: <20030318.163701.56035556.davem@redhat.com>
To: andrea@suse.de
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: 2.4 delayed acks don't work, fixed
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030319002409.GI30541@dualathlon.random>
References: <20030318221906.GA30541@dualathlon.random>
	<200303182235.BAA05440@sex.inr.ac.ru>
	<20030319002409.GI30541@dualathlon.random>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Wed, 19 Mar 2003 01:24:09 +0100

   On Wed, Mar 19, 2003 at 01:35:23AM +0300, kuznet@ms2.inr.ac.ru wrote:
   > I do not understand this, to be honest. What does clock this sender?
   > Some internal clock of sender?
   
   I don't know the details of the userspace, but the data is generated in
   real time, it's like if you cat /dev/dsp | netcat -l on the server, and
   the receiver does netcat streamer xx >/dev/dsp
   
This streamer application should buffer at the sending side, in order
to keep the window full.  Introducing artificial delays on the sending
side of a unidirectional TCP transfer is really bad for performance
and I can assure you that more than just "weird delayed ACK" behavior
will result.

In fact, it is the most suboptimal way to send data over a TCP socket.
If you can't keep the window full, you do not end up using the
bandwidth available on the path.

I would not be surprised if the news pulling case you mentioned does
something similar.
