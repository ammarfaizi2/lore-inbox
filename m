Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWGAWjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWGAWjf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 18:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWGAWje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 18:39:34 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:9105 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751243AbWGAWjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 18:39:33 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: make PROT_WRITE imply PROT_READ
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Ulrich Drepper <drepper@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       Jason Baron <jbaron@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sat, 01 Jul 2006 15:19:15 +0200
References: <6qIEW-1Tx-23@gated-at.bofh.it> <6qIEW-1Tx-21@gated-at.bofh.it> <6qUwd-2Aq-9@gated-at.bofh.it> <6qUwd-2Aq-7@gated-at.bofh.it> <6qUFV-2N8-13@gated-at.bofh.it> <6qUFY-2N8-33@gated-at.bofh.it> <6rlmT-8op-37@gated-at.bofh.it> <6siwJ-3dC-5@gated-at.bofh.it> <6sLoY-4GV-31@gated-at.bofh.it> <6sZUS-V5-19@gated-at.bofh.it> <6tib4-2wA-3@gated-at.bofh.it> <6tmHL-Oq-5@gated-at.bofh.it> <6tpZ7-5Tj-13@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1FwfNo-00012H-Gz@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Gwe, 2006-06-30 am 10:35 +0200, ysgrifennodd Arjan van de Ven:

>> apps like JVM's forgot PROT_EXEC and break when the hardware enforces it
>> apps that forget PROT_READ break when the kernel/hardware enforce it
>> 
>> not too much difference....
> 
> There is quite a difference. The _EXEC case behaves predictably for the
> platforms that support it. At least I am not aware of cases that is not
> true. The _READ case without the fault handling patch behaves

predictable on platforms that support it, but since you're testing on a
platform where it isn't fully supported, it behaves

> unpredictably depending on the precise ordering of events on a clean
> page.

You asked for a fault, and as long as the hardware supports it, you'll
get one (and you're supposed to). If the hardware doesn't support read
faults on mapped pages, you may not get all the read faults you want. The
proposed patch makes the situation worse by disabeling the _requested_
failures even in situations where it can be done.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
