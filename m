Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVIFR0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVIFR0Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 13:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbVIFR0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 13:26:24 -0400
Received: from main.gmane.org ([80.91.229.2]:56528 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750783AbVIFR0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 13:26:24 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Tue, 06 Sep 2005 13:23:51 -0400
Message-ID: <dfkjav$lmd$1@sea.gmane.org>
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com> <1125854398.23858.51.camel@localhost.localdomain> <p73aciqrev0.fsf@verdi.suse.de> <dfk5cp$19p$1@sea.gmane.org> <58d0dbf10509061005358dce91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: lmcgw.cs.sunysb.edu
User-Agent: KNode/0.9.90
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kiszka wrote:

> The only way I see is to switch stacks back on ndiswrapper API entry.
> But managing all those stacks correctly is challenging, as you will
> likely not want to create a new stack on each switching point. Rather,

This is what I had in mind before I saw this thread here. I, in fact, did
some work along those lines, but it is even more complicated than you
mentioned here: Windows uses different calling conventions (STDCALL,
FASTCALL, CDECL) so switching stacks by copying arguments/results gets
complicated. So I gave up on that approach. For X86-64 drivers we use
similar approach, but for that there is only one calling convention and we
don't need to switch stacks, but reshuffle arguments on stack / in
registers.

I am still hoping that Andi's approach is possible (I don't understand how
we can make kernel see current info from private stack).

Giri

