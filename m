Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267207AbTGHLf6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 07:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267213AbTGHLf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 07:35:58 -0400
Received: from tmi.comex.ru ([217.10.33.92]:36997 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S267207AbTGHLf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 07:35:57 -0400
X-Comment-To: Andi Kleen
To: Andi Kleen <ak@suse.de>
Cc: bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org
Subject: Re: [RFC] parallel directory operations
From: bzzz@tmi.comex.ru
Date: Tue, 08 Jul 2003 15:50:27 +0000
In-Reply-To: <20030708134601.7992e64a.ak@suse.de> (Andi Kleen's message of
 "Tue, 8 Jul 2003 13:46:01 +0200")
Message-ID: <87fzlhuif0.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <87wuetukpa.fsf@gw.home.net.suse.lists.linux.kernel>
	<p73brw5qmxk.fsf@oldwotan.suse.de> <87of05ujfo.fsf@gw.home.net>
	<20030708134601.7992e64a.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andi Kleen (AK) writes:

 AK> On Tue, 08 Jul 2003 15:28:27 +0000
 AK> bzzz@tmi.comex.ru wrote:


 >> dynlocks implements 'lock namespace', so you can lock A for namepace N1 and
 >> lock B for namespace N1 and so on. we need this because we want to take lock
 >> on _part_ of directory.

 AK> Ok, a mini database lock manager. Wouldn't it be better to use a small hash 
 AK> table and lock escalation on overflow for this?  Otherwise you could
 AK> have quite a lot of entries queued up in the list if the server is slow.

well, it makes sense. AFAIU, only problem with this solution is that we need
very well-tuned hash function. BTW, dynlocks are taken for operation time only.
so, in most often case, for dir entry creation/lookup we need two locks: one for
dcache locking and another for htree's leaf locking.

