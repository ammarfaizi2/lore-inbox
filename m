Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318023AbSGLWEm>; Fri, 12 Jul 2002 18:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318025AbSGLWEl>; Fri, 12 Jul 2002 18:04:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29100 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318023AbSGLWEk>;
	Fri, 12 Jul 2002 18:04:40 -0400
Date: Fri, 12 Jul 2002 14:58:35 -0700 (PDT)
Message-Id: <20020712.145835.91443486.davem@redhat.com>
To: matts@ksu.edu
Cc: shemminger@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 64 bit netdev stats counter
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.33L.0207121628100.19313-100000@unix2.cc.ksu.edu>
References: <1026503694.26819.4.camel@dell_ss3.pdx.osdl.net>
	<Pine.GSO.4.33L.0207121628100.19313-100000@unix2.cc.ksu.edu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matt Stegman <matts@ksu.edu>
   Date: Fri, 12 Jul 2002 17:02:07 -0500 (CDT)

   On 12 Jul 2002, Stephen Hemminger wrote:
   
   > 64 bit values are not atomic so on x86 there will be glitches if this
   > ever wraps over on an SMP machine.  One other engineer is already
   > adressing this for inode values like size; but this would introduce the
   > same problem for network stuff.
   
   One other solution I thought of would be to have an rx_bytes_wrap counter
   in the struct.

32-bit values aren't atomic either, what is the issue?
We don't use atomic_t ops on these counters so they aren't
guarenteed in any way right now even.  GCC is going to
output "incl MEM" or similar for net_stats->counter++, since
it lacks the 'lock;' prefix it is not atomic.
