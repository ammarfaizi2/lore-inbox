Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbSIWVDC>; Mon, 23 Sep 2002 17:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261392AbSIWVDC>; Mon, 23 Sep 2002 17:03:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29883 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261391AbSIWVDB>;
	Mon, 23 Sep 2002 17:03:01 -0400
Date: Mon, 23 Sep 2002 13:57:08 -0700 (PDT)
Message-Id: <20020923.135708.10698522.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: dmo@osdl.org, axboe@suse.de, phillips@arcor.de, _deepfire@mail.ru,
       linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15759.32569.964762.776074@napali.hpl.hp.com>
References: <15759.26918.381273.951266@napali.hpl.hp.com>
	<20020923.134000.123546377.davem@redhat.com>
	<15759.32569.964762.776074@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Mon, 23 Sep 2002 13:53:13 -0700
   
     > Or perhaps every platform should provide a writeq(), on 32-bit systems
     > it may merely be implemented as two consequetive writel() calls.
   
   True, but I was wondering whether driver writers will have an implicit
   assumption on readX/writeX being atomic.  I don't think anyone ever
   promised that, but I suspect all existing implementations are indeed
   atomic (it's true even for old Alphas which don't have sub-word
   load/stores).
   
On many platforms, two consequetive __raw_writel()'s might even
combine to an atomic 64-bit store to PCI space. :-)

I don't think the proposed 32-bit behavior is off the mark, and
anyways x86 can actually make the 64-bit store I believe if it
wants at least on more recent processors.
