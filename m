Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261436AbSJMG2q>; Sun, 13 Oct 2002 02:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261437AbSJMG2q>; Sun, 13 Oct 2002 02:28:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14220 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261436AbSJMG2p>;
	Sun, 13 Oct 2002 02:28:45 -0400
Date: Sat, 12 Oct 2002 23:27:44 -0700 (PDT)
Message-Id: <20021012.232744.10131509.davem@redhat.com>
To: rth@twiddle.net
Cc: anton@samba.org, wli@holomorphy.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [lart] /bin/ps output
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021012131501.C25740@twiddle.net>
References: <20021012040959.GE7050@krispykreme>
	<20021011.235329.116353173.davem@redhat.com>
	<20021012131501.C25740@twiddle.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Richard Henderson <rth@twiddle.net>
   Date: Sat, 12 Oct 2002 13:15:01 -0700

   On Fri, Oct 11, 2002 at 11:53:29PM -0700, David S. Miller wrote:
   > In fact, thinking about this some more, we should make the ".per_cpu"
   > bits emit a table entry instead of some dummy object which takes up
   > space.  The table entry would be in the special .per_cpu
   > section still but be just a size value.
   
   That's more complicated.

Hmm, we put arbitrary tables of information into seperate elf sections
already.  Consider the exception fixup mechanism for example.  That's
the kind of thing I was thinking about.

Oh I see, you're saying that then getting at the things symbolically
will be painful.  Yes it needs more thought.

   If you want to omit the per-cpu area from the kernel image, then
   arrange for it to be .bss.
   
Good idea, well on SMP it can be marked throw-away (ie. __init_data).
