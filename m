Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751640AbWEEQoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbWEEQoQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 12:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbWEEQoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 12:44:16 -0400
Received: from adsl-71-140-189-62.dsl.pltn13.pacbell.net ([71.140.189.62]:25737
	"EHLO aexorsyst.com") by vger.kernel.org with ESMTP
	id S1751637AbWEEQoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 12:44:16 -0400
From: "John Z. Bohach" <jzb@aexorsyst.com>
Reply-To: jzb@aexorsyst.com
To: linux-kernel@vger.kernel.org
Subject: Elf loader question: who updates .rela.dyn entries for load_bias compensation?
Date: Fri, 5 May 2006 09:44:15 -0700
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605050944.15440.jzb@aexorsyst.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies if this is the wrong forum, but...

I'm porting Linux to a new architecture, and ran into an issue with
the .rela.dyn entries not being adjusted to compensate for the load_bias
of an ET_DYN shared executable:  in particular, this is the ld.so itself that
doesn't get its .rela.dyn entries incremented by +load_bias.  This makes
references from _GLOBAL_OFFSET_TABLE_ refer to the old compile-time
vma addresses, which of course causes runtime  segfaults (appropriately
enough) with ld.so.

I've poured over binfmt_elf.c to see what it does, but it doesn't appear to
touch any of the sections themselves other than to load them, notably at
p_vaddr + load_bias for .so's.

I tried looking at other architectures to see if I could at least determine what
the proper existing operations are, but came up emtpy.  The ET_PLAT_INIT()
macro only updates regisers.  This leaves me to assume that the interpreter
itself updates the .rela.dyn entries for shared libs. besides itself, but I can't find
where/how, and how to get it to do so for itself as well.

This only affects ET_DYN type of .so's, because ET_EXEC's don't get a load_bias
and are loaded at the vma for which they were compiled.

Sorry if I sound like a novice...

Thanks for any pointers anyone could provide...

