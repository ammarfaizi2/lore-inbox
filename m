Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264676AbTGJSHd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 14:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269590AbTGJSHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 14:07:33 -0400
Received: from palrel10.hp.com ([156.153.255.245]:6593 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S264676AbTGJSH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 14:07:26 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16141.44749.105050.260268@napali.hpl.hp.com>
Date: Thu, 10 Jul 2003 11:22:05 -0700
To: Linus Torvalds <torvalds@osdl.org>
Cc: davidm@hpl.hp.com, Rusty Russell <rusty@rustcorp.com.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, <ak@suse.de>
Subject: Re: per_cpu fixes 
In-Reply-To: <Pine.LNX.4.44.0307101112320.16847-100000@home.osdl.org>
References: <16141.43130.657025.952793@napali.hpl.hp.com>
	<Pine.LNX.4.44.0307101112320.16847-100000@home.osdl.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 10 Jul 2003 11:15:25 -0700 (PDT), Linus Torvalds <torvalds@osdl.org> said:

  Linus> On Thu, 10 Jul 2003, David Mosberger wrote:
  >> 
  >> You mean there would be three primitives:
  >> 
  >> (1) get value from a per-CPU variable
  >> (2) set value of a per-CPU variable
  >> (3) get the (canonical) address of a per-CPU variable

  Linus> Argh.

  Linus> We'd better have the rule that if there are any virtual
  Linus> caches or other issues, then the "canonical address" had
  Linus> better be the _only_ address (or at least any virtual
  Linus> remapping has to be done in such a way that it never causes
  Linus> aliasing or other performance problems with the canonical
  Linus> address).

  Linus> This is already turning fairly ugly, and I just don't want to
  Linus> see even more ugly rules like "you can't mix direct accesses
  Linus> with pointer accesses"

Yes, Rusty's proposal (as I think I summarized above) would do exactly
that: the only address that you'll ever see for a per-CPU variable
will be the canonical one.  The get/set macros can use an alias on
platforms where this is more efficient, but the alias will never be
visible outside the macros.

	--david
