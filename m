Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281129AbRLIBWz>; Sat, 8 Dec 2001 20:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281077AbRLIBWq>; Sat, 8 Dec 2001 20:22:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49163 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281129AbRLIBWb>; Sat, 8 Dec 2001 20:22:31 -0500
Subject: Re: Required Swap for recent 2.4 kernels?
To: qkholland@yahoo.com (=?iso-8859-1?q?Quim=20K.=20Holland?=)
Date: Sun, 9 Dec 2001 01:31:50 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011209010933.64484.qmail@web10001.mail.yahoo.com> from "=?iso-8859-1?q?Quim=20K.=20Holland?=" at Dec 09, 2001 01:09:33 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Csoo-0003Sb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My understanding is that this answer is not
> applicable to post 2.4.10 kernels, but if so then
> would the total usable VM be <physical RAM> +
> <swap> - <kernel itself> - <kernel overhead that
> is not proportional to the VM workload>?

Assuming it hasn't changed with the Andrea VM then the behaviour which we
switched was how the machine handles getting close to running out of swap.

The old 2.4 behaviour was that on swapping a page in from disk we always
left it in swap as well. This is a win since if the page is not dirtied
before we have to swap it out again we avoid a disk write. However it can
mean that an entire copy of RAM is sitting in swap. So a box with 1Gb of
RAM and 2Gb of swap might use 1Gb of swap and gain nothing in total
available virtual memory

The newer behaviour Rik added to the Riel VM was that when we got to about
90% of swap full we began freeing up swap pages also in RAM. That meant that
as things got tight we would migrate to a situation where data was either
in swap or ram but not both, so you went from 2Gb total usable VM to 3Gb
total usable VM on a 1Gb box with 2Gb of swap.

Alan
