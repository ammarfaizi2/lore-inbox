Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285380AbRLGCiG>; Thu, 6 Dec 2001 21:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285381AbRLGCh4>; Thu, 6 Dec 2001 21:37:56 -0500
Received: from pizda.ninka.net ([216.101.162.242]:26497 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285380AbRLGChk>;
	Thu, 6 Dec 2001 21:37:40 -0500
Date: Thu, 06 Dec 2001 18:37:09 -0800 (PST)
Message-Id: <20011206.183709.71088955.davem@redhat.com>
To: lm@bitmover.com
Cc: alan@lxorguk.ukuu.org.uk, phillips@bonn-fries.net, davidel@xmailserver.org,
        rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
        lars.spam@nocrew.org, hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011206161744.V27589@work.bitmover.com>
In-Reply-To: <20011206153257.T27589@work.bitmover.com>
	<20011206.154735.71088809.davem@redhat.com>
	<20011206161744.V27589@work.bitmover.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Larry McVoy <lm@bitmover.com>
   Date: Thu, 6 Dec 2001 16:17:44 -0800
   
   There are /gproc, /gtmp, and /gdev
   which are in the global namespace and do for the cluster what /<xxx>
   does for a regular machine.
   
And /getc, which is where my /getc/passwd is going to be.

   We can go around and around on this and the end result will be that
   I will have narrowed the locking problem down to the point that
   only the processes which are actually using the resource have to
   participate in the locking.  In a traditional SMP OS, all processes
   have to participate.

We can split up name spaces today with Al Viro's namespace
infrastructure.

But frankly for the cases where scalability matters, like a http
server, they are all going at the same files in a global file
space.

I still think ccClusters don't solve any new problems in the
locking space.  "I get rid of it by putting people on different
filesystems" is not an answer which is unique to ccClusters, current
systems can do that.
