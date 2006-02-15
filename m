Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWBOGJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWBOGJi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 01:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWBOGJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 01:09:38 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:56966 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751018AbWBOGJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 01:09:37 -0500
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@osdl.org>,
       Hugh Dickins <hugh@veritas.com>, William Irwin <wli@holomorphy.com>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] madvise MADV_DONTFORK/MADV_DOFORK
X-Message-Flag: Warning: May contain useful information
References: <20060213154114.GO32041@mellanox.co.il>
	<Pine.LNX.4.64.0602131104460.3691@g5.osdl.org>
	<adar767133j.fsf@cisco.com>
	<Pine.LNX.4.64.0602131125180.3691@g5.osdl.org>
	<Pine.LNX.4.61.0602131943050.9573@goblin.wat.veritas.com>
	<20060213210906.GC13603@mellanox.co.il>
	<Pine.LNX.4.61.0602132157110.3761@goblin.wat.veritas.com>
	<Pine.LNX.4.64.0602131426470.3691@g5.osdl.org>
	<20060213225538.GE13603@mellanox.co.il>
	<Pine.LNX.4.61.0602132259450.4627@goblin.wat.veritas.com>
	<20060213233517.GG13603@mellanox.co.il>
	<43F2AEAE.5010700@yahoo.com.au>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 14 Feb 2006 22:09:34 -0800
In-Reply-To: <43F2AEAE.5010700@yahoo.com.au> (Nick Piggin's message of "Wed,
 15 Feb 2006 15:31:42 +1100")
Message-ID: <adawtfxqhk1.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 15 Feb 2006 06:09:35.0883 (UTC) FILETIME=[655B35B0:01C631F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Nick> May I ask, what is the rationale for ignoring the apparent
    Nick> conventions of all architectures? For example parisc, you
    Nick> appear to even go contrary to the comment.

Looking through include/asm-*/mman.h, I have to agree.  The parisc
example seemly especially bad, as (in addition to being in the
reserved range as Nick notes) the DONTFORK/DOFORK values are stuck in
a block with the page size values instead of the previous block where
they seem more sensible.  However, in other files like the alpha
version, where the rest of the values are in decimal, the hex defines
look rather jarring.

Michael, what led you to choose 0x30 and 0x31 for the two new values?
It does seem that keeping them uniform across architectures is a
reasonable thing to do, but as far as I can tell the values 9 and 10
are unused on all architectures, and have the added merit of not
falling in the parisc reserved range.

Do we still have a chance to change this?

 - R.
