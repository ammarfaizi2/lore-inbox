Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318302AbSHEFrU>; Mon, 5 Aug 2002 01:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318303AbSHEFrU>; Mon, 5 Aug 2002 01:47:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:22463 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318302AbSHEFrT>;
	Mon, 5 Aug 2002 01:47:19 -0400
Date: Sun, 04 Aug 2002 22:37:46 -0700 (PDT)
Message-Id: <20020804.223746.89817190.davem@redhat.com>
To: george@mvista.com
Cc: willy@debian.org, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: softirq parameters
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D4D668F.3A29DD10@mvista.com>
References: <20020804172650.N24631@parcelfarce.linux.theplanet.co.uk>
	<3D4D668F.3A29DD10@mvista.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: george anzinger <george@mvista.com>
   Date: Sun, 04 Aug 2002 10:38:23 -0700

   Matthew Wilcox wrote:
   > what do you guys think about this patch?  nobody's using the data argument
   > to the softirq routines, but most of the routines want to know which
   > CPU they're running on.
   
   I would vote no on this.  While no one is currently using
   the data argument, it would be _hard_ to replace it if it
   were needed.  The cpu, on the other hand, is available
   regardless of it being passed or not and thus does not
   _need_ to be passed.

I totally disagree.  It is easy to put the specified argument back if
people really need it, because so FEW people use softirq's directly.

It's a 5 minute grep + edit job to put it back.  Prove me wrong.

Next, show me one case where it is actually useful to be able to
specify this argument even theoretically!  All such examples end
up being addresses or tables which could be made available to
the softint handler itself.  Remember, softint's are only for
core subsystems and are to be used rarely.  Tasklets foot the
bill for almost anything else.

Furthermore, this is one of the most important hot paths in
the entire kernel, any simplification and or improvement
in code generated to implement these paths is desirable.

I fully supporty Matthew's change.
