Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbSIYTHL>; Wed, 25 Sep 2002 15:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262068AbSIYTHL>; Wed, 25 Sep 2002 15:07:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21454 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262067AbSIYTHK>;
	Wed, 25 Sep 2002 15:07:10 -0400
Date: Wed, 25 Sep 2002 12:02:03 -0700 (PDT)
Message-Id: <20020925.120203.49564275.davem@redhat.com>
To: mingo@elte.hu
Cc: green@namesys.com, zaitcev@redhat.com, mingo@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: cmpxchg in 2.5.38
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0209251024580.4690-100000@localhost.localdomain>
References: <20020925120725.A23559@namesys.com>
	<Pine.LNX.4.44.0209251024580.4690-100000@localhost.localdomain>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ingo Molnar <mingo@elte.hu>
   Date: Wed, 25 Sep 2002 10:26:34 +0200 (CEST)
   
   yes. It's only this place in the code that ever modifies that word

I just realized...  how would a crippled spinlock implementation
protect the readers looking at the word?

The operation is decidely non-atomic, because only one side
of the access is being synchronized.

This is another reason you can't use cmpxchg like this and expect
every architecture to be able to do something reasonable.

Use instead some algorithm with xchg() which is supported on every
platform.
