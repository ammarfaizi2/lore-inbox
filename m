Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWBMTQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWBMTQh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWBMTQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:16:37 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:2448 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S964809AbWBMTQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:16:36 -0500
X-IronPort-AV: i="4.02,109,1139212800"; 
   d="scan'208"; a="255214349:sNHT33563904"
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>, Hugh Dickins <hugh@veritas.com>
Subject: Re: [openib-general] Re: madvise MADV_DONTFORK/MADV_DOFORK
X-Message-Flag: Warning: May contain useful information
References: <20060213154114.GO32041@mellanox.co.il>
	<Pine.LNX.4.64.0602131104460.3691@g5.osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 13 Feb 2006 11:16:32 -0800
In-Reply-To: <Pine.LNX.4.64.0602131104460.3691@g5.osdl.org> (Linus
 Torvalds's message of "Mon, 13 Feb 2006 11:05:37 -0800 (PST)")
Message-ID: <adar767133j.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 13 Feb 2006 19:16:33.0574 (UTC) FILETIME=[00779460:01C630D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Linus> Why?

    Linus> That VM_DONTCOPY _is_ DONTFORK.

    Linus> Don't add a new useless DONTFORK that doesn't have any
    Linus> value.

VM_DONTCOPY is hardly used in the kernel, so the semantics aren't very
precisely defined.  But the idea is that a driver setting VM_DONTCOPY
probably has a good reason for doing it, and we don't want userspace
to be able to erase that flag through madvise().

As Hugh said in his suggestion for a better changelog entry:

    > Explain that MADV_DONTFORK should be reversible, hence
    > MADV_DOFORK; but should not be reversible on areas a driver has
    > so marked, hence VM_DONTFORK distinct from VM_DONTCOPY.

Perhaps we don't care for now, and we should wait and add
VM_KERNEL_DONTCOPY later if we really need it.  I honestly don't know.

 - Roland
