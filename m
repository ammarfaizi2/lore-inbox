Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVF1ThK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVF1ThK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVF1Tgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:36:53 -0400
Received: from ns2.suse.de ([195.135.220.15]:1153 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261219AbVF1Td2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 15:33:28 -0400
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Read only syscall tables for x86_64 and i386
References: <Pine.LNX.4.62.0506281141050.959@graphe.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Jun 2005 21:33:26 +0200
In-Reply-To: <Pine.LNX.4.62.0506281141050.959@graphe.net.suse.lists.linux.kernel>
Message-ID: <p73r7emuvi1.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@lameter.com> writes:

> Place x86_64 and i386 syscall table into the read only section.
> 
> Remove the syscall tables from the data section and place them into the 
> readonly section (like IA64).

It's unfortunately useless because all the kernel is mapped in the
same 2 or 4MB page has to be writable because it overlaps with real
direct mapped memory.

On x86-64 there is a separate kernel mapping which could be made
read only. But that would be useless again because the memory
is aliased in the real direct mapping which has the same
overlapping problem.

The only way to write protect the kernel would be to pad
it to 2MB (or 4MB on i386/non PAE) which would be a big waste
of memory or use significantly more TLB entries in normal
operation.

Both is probably not worth the modest safety increase you
get from such a change.

-Andi

