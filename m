Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318989AbSHFE5v>; Tue, 6 Aug 2002 00:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318990AbSHFE5v>; Tue, 6 Aug 2002 00:57:51 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:53467 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318989AbSHFE5v>;
	Tue, 6 Aug 2002 00:57:51 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15695.22556.128499.64377@napali.hpl.hp.com>
Date: Mon, 5 Aug 2002 22:01:16 -0700
To: "Seth, Rohit" <rohit.seth@intel.com>
Cc: "'frankeh@watson.ibm.com'" <frankeh@watson.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com, gh@us.ibm.com,
       Martin.Bligh@us.ibm.com, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: RE: large page patch (fwd) (fwd)
In-Reply-To: <25282B06EFB8D31198BF00508B66D4FA03EA56CA@fmsmsx114.fm.intel.com>
References: <25282B06EFB8D31198BF00508B66D4FA03EA56CA@fmsmsx114.fm.intel.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 5 Aug 2002 16:30:54 -0700 , "Seth, Rohit" <rohit.seth@intel.com> said:

  Rohit> I'm afraid you may be wasting a lot of extra memory by
  Rohit> replicaitng these PTEs(Take an example of one 4G large TLB
  Rohit> size entry and assume there are few hunderd processes using
  Rohit> that same physical page.)

In my opinion, this is perhaps the strongest argument *for* a separate
"giant page" syscall interface.  It will be very hard (perhaps
impossible) to optimize superpages to work efficiently when the ratio
of superpage/basepage grows huge (as, by definition, the kernel would
manage them as a set of basepages).  For example, even if we used a
base page-size of 64KB, a 4GB giant page (as supported by Itanium 2)
would correspond to 65536 base pages.  A superpage of this size would
almost certainly still do a lot better than 65536 base pages, but
compared to a single giant page, it probably stands no chance
performance-wise.

	--david
