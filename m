Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271685AbTHMLRX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 07:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271743AbTHMLRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 07:17:22 -0400
Received: from mail.suse.de ([213.95.15.193]:38148 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S271685AbTHMLRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 07:17:21 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
References: <20030813045638.GA9713@middle.of.nowhere.suse.lists.linux.kernel>
	<20030813014746.412660ae.akpm@osdl.org.suse.lists.linux.kernel>
	<20030813091958.GA30746@gates.of.nowhere.suse.lists.linux.kernel>
	<20030813025542.32429718.akpm@osdl.org.suse.lists.linux.kernel>
	<1060772769.8009.4.camel@localhost.localdomain.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 13 Aug 2003 13:17:18 +0200
In-Reply-To: <1060772769.8009.4.camel@localhost.localdomain.suse.lists.linux.kernel>
Message-ID: <p73adad7qo1.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Put the likely(pos) in the asm/prefetch for Athlon until someone can
 out what is going on with some specific Athlons, 2.6 and certain
> kernels (notably 4G/4G)

You can use the same workaround as x86-64. add an exception handler and
just jump back. Advantage is that it is completely outside the fast path.

But note you also have to add runtime sorting of __ex_table when you
do this, otherwise the __ex_table becomes unsorted when someone uses
list_for_each (which does prefetch) in a __init function

(all code is available in x86-64, just needs to be ported over)

-Andi
