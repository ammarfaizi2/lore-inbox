Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWFHNCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWFHNCP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 09:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWFHNCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 09:02:15 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:36110 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S964828AbWFHNCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 09:02:15 -0400
Subject: Re: [PATCH] mm: tracking dirty pages -v6
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1149770654.4408.71.camel@lappy>
References: <20060525135534.20941.91650.sendpatchset@lappy>
	 <Pine.LNX.4.64.0606062056540.1507@blonde.wat.veritas.com>
	 <1149770654.4408.71.camel@lappy>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 15:02:02 +0200
Message-Id: <1149771723.20886.10.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If this one still has some problems there is on more thing we could try
before going back to the old way of doing things.

I found this 'gem' in the drm code:

        vma->vm_page_prot =
            __pgprot(pte_val
                     (pte_wrprotect
                      (__pte(pgprot_val(vma->vm_page_prot)))));

which does exactly what is needed.

OTOH, my alternate version of the mprotect fix leaves dirty pages
writable, which saves a few faults.

Peter

