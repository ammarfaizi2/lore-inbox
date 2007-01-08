Return-Path: <linux-kernel-owner+w=401wt.eu-S1422705AbXAHS3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422705AbXAHS3i (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 13:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422706AbXAHS3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 13:29:38 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:50483 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422705AbXAHS3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 13:29:37 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
To: Amit Choudhary <amit2030@yahoo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Reply-To: 7eggert@gmx.de
Date: Mon, 08 Jan 2007 19:29:22 +0100
References: <7ADs5-25a-11@gated-at.bofh.it> <7AP02-3l3-13@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1H3zFK-0001Bw-NI@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@gmx.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit Choudhary <amit2030@yahoo.com> wrote:
> --- Christoph Hellwig <hch@infradead.org> wrote:
>> On Sun, Jan 07, 2007 at 12:46:50AM -0800, Amit Choudhary wrote:

>> > Well, I am not proposing this as a debugging aid. The idea is about correct
>> > programming,
>> atleast
>> > from my view. Ideally, if you kfree(x), then you should set x to NULL. So,
>> > either programmers
>> do
>> > it themselves or a ready made macro do it for them.
>> 
>> No, you should not.  I suspect that's the basic point you're missing.

> Any strong reason why not? x has some value that does not make sense and can
> create only problems. And as I explained, it can result in longer code too.
> So, why keep this value around. Why not re-initialize it to NULL.

1) Because some magic value like 0x23 would be better.
2) Because it hides bugs like double frees or dangeling references while
   creating a race condition. In the end, you'll get more hard-to-find bugs
   in exchange for papering over some easy-to-spot bugs.

> If x should not be re-initialized to NULL, then by the same logic, we should
> not even initialize local variables. And all of us know that local variables
> should be initialized.

That may hide bugs, too. Therefore this isn't done in the kernel unless you
intend to depend on an initial value.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
