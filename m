Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282662AbRKZXyV>; Mon, 26 Nov 2001 18:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282663AbRKZXyL>; Mon, 26 Nov 2001 18:54:11 -0500
Received: from pizda.ninka.net ([216.101.162.242]:52866 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282662AbRKZXx7>;
	Mon, 26 Nov 2001 18:53:59 -0500
Date: Mon, 26 Nov 2001 15:53:47 -0800 (PST)
Message-Id: <20011126.155347.45872112.davem@redhat.com>
To: neilb@cse.unsw.edu.au
Cc: trond.myklebust@fys.uio.no, nfs@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: Fix knfsd readahead cache in 2.4.15
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15362.53694.192797.275363@esther.cse.unsw.edu.au>
In-Reply-To: <15362.18626.303009.379772@charged.uio.no>
	<15362.53694.192797.275363@esther.cse.unsw.edu.au>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Neil Brown <neilb@cse.unsw.edu.au>
   Date: Tue, 27 Nov 2001 10:35:26 +1100 (EST)
   
   This is definately a bug, but I don't think it is quite as dramatic as
   you suggest.
   
   The "struct raparms" that ra points to will almost always be the last
   one on the list, so ra->p_next will almost always be NULL anyway.
   Nevertheless, it is a bug and your fix looks good.

There are other problems remaining, this function is a logical
mess.

1) depth is computed in the loop, but thrown away.
   It is basically reassigned to a constant before
   being used to index the statistics it is for.

2) raparm_cache is reassigned, and since the ra param list is
   NULL terminated this can make the list shorter and shorter
   and shorter until it is one entry deep.

Yikes :)
