Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291621AbSBAJMY>; Fri, 1 Feb 2002 04:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291624AbSBAJMP>; Fri, 1 Feb 2002 04:12:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:32644 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291621AbSBAJME>;
	Fri, 1 Feb 2002 04:12:04 -0500
Date: Fri, 01 Feb 2002 01:10:10 -0800 (PST)
Message-Id: <20020201.011010.45741509.davem@redhat.com>
To: velco@fadata.bg
Cc: mingo@elte.hu, anton@samba.org, torvalds@transmeta.com, andrea@suse.de,
        riel@conectiva.com.br, stoffel@casc.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <87u1t1shhd.fsf@fadata.bg>
In-Reply-To: <Pine.LNX.4.33.0202011125030.5026-100000@localhost.localdomain>
	<87u1t1shhd.fsf@fadata.bg>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Momchil Velikov <velco@fadata.bg>
   Date: 01 Feb 2002 11:01:50 +0200
   
   Does cache line bounce (shared somewhere -> exclusive elsewhere) cost
   more that a simple miss (present nowhere -> exclusive somewhere) ?

They are about equal.  For coherency purposes all cpus have to listen
to all the transactions anyways to see if they have a match in their
L2 caches (and thus must provide the data to the requestor).

Perhaps the exclusive somewhere --> exclusive somewhere else is a bit
more expensive because you eat a write port for the cache line move on
the processor providing the data.
