Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265128AbUFGX1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265128AbUFGX1g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 19:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265126AbUFGX1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 19:27:36 -0400
Received: from palrel12.hp.com ([156.153.255.237]:47791 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265128AbUFGX1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 19:27:34 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16580.63969.502824.882987@napali.hpl.hp.com>
Date: Mon, 7 Jun 2004 16:27:29 -0700
To: Russell Leighton <russ@elegant-software.com>
Cc: davidm@hpl.hp.com, Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using getpid() often, another way? [was Re: clone() <-> getpid()
 bug in 2.6?]
In-Reply-To: <40C4F40A.8060205@elegant-software.com>
References: <40C1E6A9.3010307@elegant-software.com>
	<Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>
	<40C32A44.6050101@elegant-software.com>
	<40C33A84.4060405@elegant-software.com>
	<1086537490.3041.2.camel@laptop.fenrus.com>
	<40C3AD9E.9070909@elegant-software.com>
	<20040607121300.GB9835@devserv.devel.redhat.com>
	<6uu0xn5vio.fsf@zork.zork.net>
	<20040607140009.GA21480@infradead.org>
	<16580.46864.290708.33518@napali.hpl.hp.com>
	<40C4F40A.8060205@elegant-software.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 07 Jun 2004 19:02:34 -0400, Russell Leighton <russ@elegant-software.com> said:

  Russell> So Ia64 does have it..that's good. Does glibc wrap it?

Here is how it works at the user-level:

 - There _is_ a clone(), with the original interface.  However,
   this version only works when you create a new address-space.

 - There is clone2(), which adds the extra "size" argument.  This
   one works for all cases.

  Russell> I agree with the above...could glibc's clone() should have
  Russell> a size added?  Then the arch specific stack issues could be
  Russell> hidden.

In my opinion, it would make sense for all platforms to support
clone2(), since it's more in line with the normal UNIX-convention of
specifying stacks as a memory-range (e.g., see stack_t).  So far, the
interest in doing this has been lack-luster (and, IIRC, Linus was
against it in the past, so I haven't spent a lot of effort on it).

	--david
