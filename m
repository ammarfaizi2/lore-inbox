Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317650AbSFMPJe>; Thu, 13 Jun 2002 11:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317658AbSFMPJd>; Thu, 13 Jun 2002 11:09:33 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:27597 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317650AbSFMPJc>;
	Thu, 13 Jun 2002 11:09:32 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15624.46508.257287.233406@napali.hpl.hp.com>
Date: Thu, 13 Jun 2002 08:09:32 -0700
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] pageattr update
In-Reply-To: <20020613061246.A7121@redhat.com>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

I'm have a concern about the current change_page_attr() patch.  It
gives the impression that the GART memory always gets mapped
write-combined.  This is not always true.  For example, on IA-64,
attribute-aliasing issues are prevented by requiring IA-64 platforms
to use coherent AGP DMA.  In other words, the AGP memory will be
mapped writeback, as usual.

As long as change_page_attr() is used for AGP-related stuff only,
there is probably no real issue with the patch in its current form
(its simply a no-op on most non-x86 platforms).  However, I'm a bit
worried that someone might start to use it for other things, such that
change_page_attr() could no longer be a no-op on those platforms.
Since the DMA coherency issue is an AGP specific issue, perhaps just
renaming the macro to agp_change_page_attr() would take care of my
concern.  What do you think?

	--david
