Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291525AbSBSRLK>; Tue, 19 Feb 2002 12:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291522AbSBSRLA>; Tue, 19 Feb 2002 12:11:00 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:22230 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S291520AbSBSRKr>;
	Tue, 19 Feb 2002 12:10:47 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15474.34580.625864.963930@napali.hpl.hp.com>
Date: Tue, 19 Feb 2002 09:10:44 -0800
To: "Dan Maas" <dmaas@dcine.com>
Cc: <linux-kernel@vger.kernel.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "Ben Collins" <bcollins@debian.org>
Subject: Re: readl/writel and memory barriers
In-Reply-To: <092401c1b8e7$1d190660$1a01a8c0@allyourbase>
In-Reply-To: <092401c1b8e7$1d190660$1a01a8c0@allyourbase>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 18 Feb 2002 20:45:29 -0500, "Dan Maas" <dmaas@dcine.com> said:

  Dan> In a quick survey of architectures that need explicit memory
  Dan> barriers to enforce ordering of PCI accesses, it seems that
  Dan> alpha and PPC include memory barriers inside readl() and
  Dan> writel(), whereas MIPS, sparc64, ia64, and s390 do not include
  Dan> them. (I'm not intimately familiar with these architectures so
  Dan> forgive me if I got some wrong...). What is the official story
  Dan> here?

On ia64, the fact that readl()/writel() are accessing uncached space
ensures the CPU doesn't reorder the accesses.  Furthermore, the
accesses are performed through "volatile" pointers, which ensures that
the compiler doesn't reorder them (and, as a side-effect, such
pointers also generate ordered loads/stores, but this isn't strictly
needed, due to accessing uncached space).

	--david
