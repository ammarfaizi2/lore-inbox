Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311907AbSCTSM6>; Wed, 20 Mar 2002 13:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311914AbSCTSMr>; Wed, 20 Mar 2002 13:12:47 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:47529 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S311909AbSCTSMi>; Wed, 20 Mar 2002 13:12:38 -0500
Date: Wed, 20 Mar 2002 18:15:10 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Andrea Arcangeli <andrea@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scalability problem (kmap_lock) with -aa kernels
In-Reply-To: <257350410.1016612071@[10.10.2.3]>
Message-ID: <Pine.LNX.4.21.0203201757030.1428-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My guess: persistent kmaps are okay, kmapped high pagetables are okay,
persistent kmapped high pagetables are okay.  What's wrong is how we
flush_all_zero_pkmaps on all cpus, synchronously while holding the
kmap_lock everyone needs to get a new kmap (and hopefully more often,
just inc or dec the pkmap_count of kmap already got).  That's what
cries out for redesign: it's served us well but should now be improved.

Hugh

