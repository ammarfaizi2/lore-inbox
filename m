Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285312AbRLFXs4>; Thu, 6 Dec 2001 18:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285319AbRLFXsl>; Thu, 6 Dec 2001 18:48:41 -0500
Received: from pizda.ninka.net ([216.101.162.242]:6272 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285312AbRLFXsD>;
	Thu, 6 Dec 2001 18:48:03 -0500
Date: Thu, 06 Dec 2001 15:47:35 -0800 (PST)
Message-Id: <20011206.154735.71088809.davem@redhat.com>
To: lm@bitmover.com
Cc: alan@lxorguk.ukuu.org.uk, phillips@bonn-fries.net, davidel@xmailserver.org,
        rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
        lars.spam@nocrew.org, hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011206153257.T27589@work.bitmover.com>
In-Reply-To: <20011206151504.R27589@work.bitmover.com>
	<20011206.151945.57439059.davem@redhat.com>
	<20011206153257.T27589@work.bitmover.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Larry McVoy <lm@bitmover.com>
   Date: Thu, 6 Dec 2001 15:32:57 -0800
   
   And, the ccCluster approach moves most of the nasty locking
   problems into a ccCluster specific filesystem rather than buggering
   up the generic paths.

I still don't believe this, you are still going to need a lot of
generic VFS threading.  This is why myself and others keep talking
about ftruncate(), namei() et al.

If I look up "/etc" on bigfoot, littletoe, or whatever fancy name you
want to call the filesystem setup, SOMETHING has to control access to
the path name components (ie. there has to be locking).

You are not "N*M scaling" lookups on filesystem path components.
In fact, bigfoot sounds like it would make path name traversal more
heavyweight than it is now because these stripes need to coordinate
with each other somehow.

You keep saying "it'll be in the filesystem" over and over.  And the
point I'm trying to make is that this is not going to do away with the
fundamental problems.  They are still there with a ccCluster, they are
still there with bigfoot, and you are not getting N*M scaling on
filesystem name component walks.
