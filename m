Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293072AbSBWBdu>; Fri, 22 Feb 2002 20:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293068AbSBWBdC>; Fri, 22 Feb 2002 20:33:02 -0500
Received: from dsl-213-023-039-244.arcor-ip.net ([213.23.39.244]:46472 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S293067AbSBWBcl>;
	Fri, 22 Feb 2002 20:32:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC] Page table sharing
Date: Fri, 22 Feb 2002 07:32:31 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Hugh Dickins <hugh@veritas.com>, <dmccr@us.ibm.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Robert Love <rml@tech9.net>, <mingo@redhat.com>,
        Andrew Morton <akpm@zip.com.au>, <manfred@colorfullife.com>,
        <wli@holomorphy.com>
In-Reply-To: <Pine.LNX.4.33.0202181758260.24597-100000@home.transmeta.com> <E16e8Gf-0005HN-00@starship.berlin>
In-Reply-To: <E16e8Gf-0005HN-00@starship.berlin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16e9Fw-0005I3-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following gross mistake was noticed promptly by Rik van Riel:

	spin_lock(&page_table_share_lock);
-       if (page_count(virt_to_page(pte)) == 1) {
+	if (put_page_testzero(virt_to_page(pte))) {
		pmd_clear(dir);
		pte_free_slow(pte);
	}
	spin_unlock(&page_table_share_lock);

However, oddly enough, that's not the memory leak.

-- 
Daniel
