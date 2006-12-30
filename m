Return-Path: <linux-kernel-owner+w=401wt.eu-S1755104AbWL3AFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755104AbWL3AFX (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 19:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbWL3AFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 19:05:23 -0500
Received: from moutng.kundenserver.de ([212.227.126.174]:52042 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104AbWL3AFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 19:05:21 -0500
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Dec 2006 19:05:21 EST
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Want comments regarding patch
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Daniel =?ISO-8859-1?Q?Marjam=E4ki?= <daniel.marjamaki@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sat, 30 Dec 2006 01:00:50 +0100
References: <7x8ul-7NU-7@gated-at.bofh.it> <7x8E5-80F-13@gated-at.bofh.it> <7xdkq-7tB-25@gated-at.bofh.it> <7xjSQ-1fR-13@gated-at.bofh.it> <7xn0j-6rY-7@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1H0Rec-00011Y-55@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@gmx.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> On Dec 29 2006 07:57, Daniel Marjamäki wrote:

>> It was my goal to improve the readability. I failed.
>>
>> I personally prefer to use standard functions instead of writing code.
>> In my opinion using standard functions means less code that is easier to
>> read.
> 
> Hm in that case, what about having something like
> 
> void *memset_int(void *a, int x, int n) {
>     asm("mov %0, %%esi;
>          mov %1, %%eax;
>          mov %2, %%ecx;
>          repz movsd;",
>        a,x,n);
> }

This would copy the to-be-initialized buffer somewhere, if it compiles.

1) You want stosd, "store string", not "move string"
2) You'll want to set %%di (destination index) instead of %%si.
3) repz should be illegal for movs, it might be interpreted as rep by
   defective assemblers, since it generates the same prefix. "rep" is
   correct here, since you don't want to break on (non-)zero-words.
4) Mind the direction flag.

