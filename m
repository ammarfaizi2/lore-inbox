Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262835AbSJLGyY>; Sat, 12 Oct 2002 02:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262836AbSJLGyX>; Sat, 12 Oct 2002 02:54:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48002 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262835AbSJLGyV>;
	Sat, 12 Oct 2002 02:54:21 -0400
Date: Fri, 11 Oct 2002 23:53:29 -0700 (PDT)
Message-Id: <20021011.235329.116353173.davem@redhat.com>
To: anton@samba.org
Cc: wli@holomorphy.com, haveblue@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [lart] /bin/ps output
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021012040959.GE7050@krispykreme>
References: <20021012035141.GC7050@krispykreme>
	<20021012035958.GD10722@holomorphy.com>
	<20021012040959.GE7050@krispykreme>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Anton Blanchard <anton@samba.org>
   Date: Sat, 12 Oct 2002 14:09:59 +1000

   Speaking of which, the recent CONFIG_NR_CPUS addition shows just how
   bloated all our [NR_CPU] structures are. We need to get serious about
   using the per cpu data stuff. Going from 32 to 64 was over 500kB on my
   ppc64 build.

In fact, thinking about this some more, we should make the ".per_cpu"
bits emit a table entry instead of some dummy object which takes up
space.  The table entry would be in the special .per_cpu
section still but be just a size value.

We should do this on both SMP and non-SMP and it will shrink the
kernel image size in both cases.

I don't have the time to implement this so I'll shut up now :-)
