Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285042AbRLFH51>; Thu, 6 Dec 2001 02:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285041AbRLFH5Q>; Thu, 6 Dec 2001 02:57:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11140 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285036AbRLFH5H>;
	Thu, 6 Dec 2001 02:57:07 -0500
Date: Wed, 05 Dec 2001 23:56:17 -0800 (PST)
Message-Id: <20011205.235617.23011309.davem@redhat.com>
To: davidel@xmailserver.org
Cc: rusty@rustcorp.com.au, lm@bitmover.com, Martin.Bligh@us.ibm.com,
        riel@conectiva.com.br, lars.spam@nocrew.org, alan@lxorguk.ukuu.org.uk,
        hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.40.0112051915440.1644-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <20011206135224.12c4b123.rusty@rustcorp.com.au>
	<Pine.LNX.4.40.0112051915440.1644-100000@blue1.dev.mcafeelabs.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Davide Libenzi <davidel@xmailserver.org>
   Date: Wed, 5 Dec 2001 19:19:19 -0800 (PST)

   On Thu, 6 Dec 2001, Rusty Russell wrote:
   
   > I'd love to say that I can solve this with RCU, but it's vastly non-trivial
   > and I haven't got code, so I'm not going to say that. 8)
   
   Lockless algos could help if we're able to have "good" quiescent point
   inside the kernel. Or better have a good quiescent infrastructure to have
   lockless code to plug in.

Lockless algorithms don't get rid of the shared cache lines.

I used to once think that lockless algorithms were the SMP holy-grail,
but this was undone when I realized they had the same fundamental
overhead spinlocks do.

These lockless algorithms, instructions like CAS, DCAS, "infinite
consensus number", it's all crap.  You have to seperate out the access
areas amongst different cpus so they don't collide, and none of these
mechanisms do that.

That is, unless some lockless algorithm involving %100 local dirty
state has been invented while I wasn't looking :-)
