Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUGMFXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUGMFXT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 01:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbUGMFXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 01:23:19 -0400
Received: from palrel12.hp.com ([156.153.255.237]:6313 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263962AbUGMFXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 01:23:16 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16627.29119.12240.152760@napali.hpl.hp.com>
Date: Mon, 12 Jul 2004 22:23:11 -0700
To: Ingo Molnar <mingo@redhat.com>
Cc: davidm@hpl.hp.com, Linus Torvalds <torvalds@osdl.org>,
       Jakub Jelinek <jakub@redhat.com>, suresh.b.siddha@intel.com,
       jun.nakajima@intel.com, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: serious performance regression due to NX patch
In-Reply-To: <Pine.LNX.4.58.0407122358570.13111@devserv.devel.redhat.com>
References: <200407100528.i6A5SF8h020094@napali.hpl.hp.com>
	<Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407110550340.4229@devserv.devel.redhat.com>
	<20040711123803.GD21264@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407121402160.2451@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407121315170.1764@ppc970.osdl.org>
	<16626.62318.880165.774044@napali.hpl.hp.com>
	<Pine.LNX.4.58.0407122358570.13111@devserv.devel.redhat.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 13 Jul 2004 00:23:29 -0400 (EDT), Ingo Molnar <mingo@redhat.com> said:

  Ingo> it's not just about the stack! It's a "is the value of the
  Ingo> PROT_EXEC bit just an embelishment of /proc output or is it
  Ingo> taken seriously" thing.

Fine, but it seems to me NX bit patch wasn't properly integrated with
VM_DATA_DEFAULT_FLAGS.  In fact, if you hadn't changed the x86 version
of VM_DATA_DEFAULT_FLAGS and instead had in mm/mmap.c replaced the
macro with (VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE), then
things would have behaved exactly right with my patch applied and the
logic would make much more sense.

There would also need to be a small change to arch/ia64/mm/init.c, but
I'd be happy to take care of that.

	--david
