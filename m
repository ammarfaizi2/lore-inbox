Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSEMQgy>; Mon, 13 May 2002 12:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314239AbSEMQgx>; Mon, 13 May 2002 12:36:53 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:52167 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S314149AbSEMQgv>;
	Mon, 13 May 2002 12:36:51 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15583.60301.410541.204804@napali.hpl.hp.com>
Date: Mon, 13 May 2002 09:36:29 -0700
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: davidm@hpl.hp.com, torvalds@transmeta.com, engebret@vnet.ibm.com,
        justincarlson@cmu.edu, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, anton@samba.org, ak@suse.de,
        paulus@samba.org
Subject: Re: Memory Barrier Definitions
In-Reply-To: <20020513132605.06b44d85.rusty@rustcorp.com.au>
X-Mailer: VM 7.03 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 13 May 2002 13:26:05 +1000, Rusty Russell <rusty@rustcorp.com.au> said:

  Rusty> OK.  So ignoring the fact that you somehow have to attach
  Rusty> your barriers to a load or store for the moment, we have
  Rusty> before vs. after (ia64), read vs. write (most archs), io vs
  Rusty> mem (ppc, ppc64), data dependency vs non-data dependency
  Rusty> (alpha), and smp vs up.

An alternative way to think about the ia64 model is that it provides
"ordering" variables.  Accesses to those variables won't be reordered
by the compiler or the CPU and also order other (normally unordered
accesses).  One way to support this is have an ORDERING attribute for
variables (which would expand into "volatile" on ia64).  This would
have to be complemented by a set of barrier routines which will
achieve the desired ordering on machines that don't have the
acquire/release model of ia64 (and on ia64, they would expand into
nothing).

	--david
