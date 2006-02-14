Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161108AbWBNVDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161108AbWBNVDL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbWBNVDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:03:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6064 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161108AbWBNVDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:03:10 -0500
Date: Tue, 14 Feb 2006 13:02:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: PATCH: rio driver, boot code (1 of 3)
In-Reply-To: <1139947720.11979.15.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0602141302320.3691@g5.osdl.org>
References: <1139944938.11979.5.camel@localhost.localdomain> 
 <200602141938.12041.s0348365@sms.ed.ac.uk> <1139947720.11979.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Feb 2006, Alan Cox wrote:
> 
> Harmless but yes I'll send a diff to clean them up once the other three
> are applied.

Not harmless. The other patches seem to assume that the first one was 
_not_ done. IOW, patch #2 contains:

	-
	-#define        HOST_DISABLE \
	-               HostP->Flags &= ~RUN_STATE; \
	-               HostP->Flags |= RC_STUFFED; \
	-               RIOHostReset( HostP->Type, (struct DpRam *)HostP->CardP, HostP->Slot );\
	-               continue
	-
	-                       HOST_DISABLE;

and will thus obviously not apply at all if patch #1 was applied.

It looks like the indent was done _after_ patch #1 was applied, but then 
the result was diffed against the state _before_ patch #1 was applied.

So I'll flush the series, hoping for a corrected one that actually applies 
in order..

		Linus
