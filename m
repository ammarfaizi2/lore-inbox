Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261264AbSIZAEe>; Wed, 25 Sep 2002 20:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261342AbSIZAEd>; Wed, 25 Sep 2002 20:04:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:64896 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261264AbSIZAEd>;
	Wed, 25 Sep 2002 20:04:33 -0400
Date: Wed, 25 Sep 2002 17:03:36 -0700 (PDT)
Message-Id: <20020925.170336.77023245.davem@redhat.com>
To: niv@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D924F9D.C2DCF56A@us.ibm.com>
References: <3D924F9D.C2DCF56A@us.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Nivedita Singhvi" <niv@us.ibm.com>
   Date: 25 Sep 2002 17:06:53 -0700
   ...
   
   > Everything, from packet forwarding, to firewalling, to TCP socket
   > packet receive, can be described with routes.  It doesn't make sense
   > for forwarding, TCP, netfilter, and encapsulation schemes to duplicate
   > all of this table lookup logic and in fact it's entirely superfluous.
   
   Are you saying combine the tables themselves? 
   
   One of the tradeoffs would be serialization of the access, then,
   right? i.e. Much less stuff could happen in parallel? Or am I 
   completely misunderstanding your proposal?
   
In fact the exact opposite, such a suggested flow cache is about
as parallel as you can make it.

Even if the per-cpu toplevel flow cache idea were not implemented and
we used the current top-level route lookup infrastructure, it is fully
parallelized since the toplevel hash table uses per-hashchain locks.
Please see net/ipv4/route.c:ip_route_input() and friends.

I don't understand why you think using the routing tables to their
full potential would imply serialization.  If you still believe this
you have to describe why in more detail.
