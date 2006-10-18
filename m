Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423145AbWJRXf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423145AbWJRXf0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 19:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423148AbWJRXf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 19:35:26 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:48631 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1423145AbWJRXfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 19:35:24 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: IS_ERR Threshold Value
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Ralf Baechle <ralf@linux-mips.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       Erik Frederiksen <erik_frederiksen@pmc-sierra.com>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Thu, 19 Oct 2006 01:29:29 +0200
References: <6sPiW-295-5@gated-at.bofh.it> <6sPsw-2y4-19@gated-at.bofh.it> <6t9hu-6l6-11@gated-at.bofh.it> <76GtI-T6-21@gated-at.bofh.it> <77jbT-1y3-29@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1GaKr7-0001A5-Mg@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

>>> +#define IS_ERR_VALUE(x) unlikely((x) >= (unsigned long)-MAX_ERRNO)
> 
> There seems to be a slight problem with doing that. Running
> `ldd /bin/bash` prints out
> 
> linux-gate.so.1 =>  (0xffffe000)
> 
> and the topmost address a kernel function can return is 0xFFFFf000 when
> MAX_ERRNO=4095, but that is going to be tight with the vdso mapped at
> 0xffffE000.

http://www.trilithium.com/johan/2005/08/linux-gate/

"... an x86 box where processes live in plain old 32-bit address spaces
divided into pages of 4096 bytes, making ffffe000 the penultimate page.
The very last page is reserved to catch accesses through invalid pointers,
e.g. dereferencing a decremented NULL pointer or a MAP_FAILED pointer
returned from mmap."

Therefore, MAX_ERRNO < PAGE_SIZE is safe.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
