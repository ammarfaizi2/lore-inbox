Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbVCBMUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVCBMUZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 07:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbVCBMUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 07:20:24 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:59229 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262278AbVCBMUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 07:20:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TQ9J/zBkqsVi/o2r3KQ1n9nJpMlt4ouoyPTw8HtI2yUYhbeFZP/U4/uEbAVh4YdSbS8QfB9249S9AnQnrR6QHbevTWmRoVUBHarwEXEC5gQJpZ+nTR0fxGxJ7qta/iD2tH7npzTDqlehs7l2ojgcWJM5AZa3qwlBxN3QtVHmoCk=
Message-ID: <3f250c71050302042059f36525@mail.gmail.com>
Date: Wed, 2 Mar 2005 08:20:13 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] A new entry for /proc
Cc: Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, rrebel@whenu.com,
       marcelo.tosatti@cyclades.com, nickpiggin@yahoo.com.au
In-Reply-To: <3f250c710503010744390391e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050106202339.4f9ba479.akpm@osdl.org>
	 <3f250c710502240343563c5cb0@mail.gmail.com>
	 <20050224035255.6b5b5412.akpm@osdl.org>
	 <3f250c7105022507146b4794f1@mail.gmail.com>
	 <3f250c71050228014355797bd8@mail.gmail.com>
	 <3f250c7105022801564a0d0e13@mail.gmail.com>
	 <Pine.LNX.4.61.0502282029470.28484@goblin.wat.veritas.com>
	 <3f250c7105030100085ab86bd2@mail.gmail.com>
	 <3f250c710503010617537a3ca@mail.gmail.com>
	 <3f250c710503010744390391e2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know if the place I put pte_unmap is logical and safe
after several pte increments?

	pte = pte_offset_map(pmd, address);
	address &= ~PMD_MASK;
	end = address + size;
	if (end > PMD_SIZE)
		end = PMD_SIZE;
	do {
		pte_t page = *pte;

		address += PAGE_SIZE;
		pte++;
		if (pte_none(page) || (!pte_present(page)))
			continue;
		*rss += PAGE_SIZE;
	} while (address < end);
	pte_unmap(pte);

BR,

Mauricio Lin.
