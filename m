Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263995AbUEXFkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263995AbUEXFkx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 01:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUEXFkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 01:40:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:47585 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263995AbUEXFj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 01:39:56 -0400
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@redhat.com>,
       linux-mm@kvack.org
In-Reply-To: <1085376888.24948.45.camel@gaston>
References: <1085369393.15315.28.camel@gaston>
	 <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
	 <1085371988.15281.38.camel@gaston>
	 <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
	 <1085373839.14969.42.camel@gaston>
	 <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
	 <1085376888.24948.45.camel@gaston>
Content-Type: text/plain
Message-Id: <1085377091.15281.49.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 24 May 2004 15:38:12 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, the original scenario triggering that from userland is, imho, so
> broken, that we may just not care losing that dirty bit ... Oh well :)
> Anyway, apply my patch. If pte is not present, this will have no effect,
> if it is, it makes sure we never leave a stale HPTE in the hash, which
> is fatal in far worse ways.

Hrm... Or maybe I should just do in set_pte something like

 BUG_ON(pte_present(ptep))

That would make me sleep better ;)

Ben.


