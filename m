Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318369AbSHBGWv>; Fri, 2 Aug 2002 02:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318398AbSHBGWv>; Fri, 2 Aug 2002 02:22:51 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:14819 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318369AbSHBGWu>;
	Fri, 2 Aug 2002 02:22:50 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15690.9727.831144.67179@napali.hpl.hp.com>
Date: Thu, 1 Aug 2002 23:26:07 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, gh@us.ibm.com,
       riel@conectiva.com.br, akpm@zip.com.au, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, rohit.seth@intel.com, sunil.saxena@intel.com,
       asit.k.mallick@intel.com
Subject: Re: large page patch 
In-Reply-To: <20020801.222053.20302294.davem@redhat.com>
References: <Pine.LNX.4.44L.0208012246390.23404-100000@imladris.surriel.com>
	<E17aSCT-0008I0-00@w-gerrit2>
	<15690.6005.624237.902152@napali.hpl.hp.com>
	<20020801.222053.20302294.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 01 Aug 2002 22:20:53 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:

  DaveM>    From: David Mosberger <davidm@napali.hpl.hp.com> Date:
  DaveM> Thu, 1 Aug 2002 22:24:05 -0700

  DaveM>    In my opinion the proposed large-page patch addresses a
  DaveM> relatively pressing need for databases (primarily).

  DaveM> Databases want large pages with IPC_SHM, how can this
  DaveM> special syscal hack address that?

I believe the interface is OK in that regard.  AFAIK, Oracle is happy
with it.

  DaveM> It's great for experimentation, but give up syscall slots
  DaveM> for this?

I'm a bit concerned about this, too.  My preference would have been to
use the regular mmap() and shmat() syscalls with some
augmentation/hint as to what the preferred page size is (Simon
Winwood's OLS 2002 paper talks about some options here).  I like this
because hints could be useful even with a transparent superpage
scheme.

The original Intel patch did use more of a hint-like approach (the
hint was a simple binary flag though: give me regular pages or give me
large pages), but Linus preferred a separate syscall interface, so the
Intel folks switched over to doing that.

	--david
