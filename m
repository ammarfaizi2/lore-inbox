Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWHICUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWHICUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 22:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWHICUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 22:20:21 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50124 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751257AbWHICUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 22:20:19 -0400
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 2.6.18-rc3-mm2] KPROBE_ENTRY ends up putting code into .fixup
Date: Wed, 9 Aug 2006 04:13:54 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <44D937EE.1020404@goop.org>
In-Reply-To: <44D937EE.1020404@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608090413.54286.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 03:18, Jeremy Fitzhardinge wrote:
> KPROBE_ENTRY does a .section .kprobes.text, and expects its users to
> do a .previous at the end of the function.
> 
> Unfortunately, if any code within the function switches sections, for
> example .fixup, then the .previous ends up putting all subsequent code
> into .fixup.  Worse, any subsequent .fixup code gets intermingled with
> the code its supposed to be fixing (which is also in .fixup).  It's
> surprising this didn't cause more havok.
> 
> The fix is to use .pushsection/.popsection, so this stuff nests
> properly.  A further cleanup would be to get rid of all
> .section/.previous pairs, since they're inherently fragile.

Added thanks.
-Andi
