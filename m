Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932711AbWKGQev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711AbWKGQev (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 11:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbWKGQev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 11:34:51 -0500
Received: from gate.cdi.cz ([80.95.109.117]:63635 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id S932711AbWKGQev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 11:34:51 -0500
Message-ID: <4550B5A8.2050000@cdi.cz>
Date: Tue, 07 Nov 2006 17:34:48 +0100
From: Martin Devera <devik@cdi.cz>
User-Agent: Thunderbird 1.5.0.5 (X11/20060729)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: oops in do_no_page, 2.6.19-rc4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.6 (--)
X-Spam-Report: * -2.6 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
while hunting >=2.6.18 regression my HW (see my older posts) I was able to get
the hw offline for testing. I'm able to reproduce oops below by taking cpu1
offline, then online and running "top".
More info is at http://luxik.cdi.cz/~devik/files/2618-corrupt/oops2/, I have
also /proc/kcore copy if someone wants it.
In reality there was second recursive BUG, see url above.

I run testsuite now in hope to trigger the original bug (without cpu hotplug
involved) and save crashdump using kexec..
devik

[  337.052000] BUG: unable to handle kernel paging request at virtual address 687475f9
[  337.052000]  printing eip:
[  337.052000] c01654cd
[  337.052000] *pde = 00000000
[  337.052000] Oops: 0000 [#1]
[  337.052000] SMP DEBUG_PAGEALLOC
[  337.052000] Modules linked in:
[  337.052000] CPU:    1
[  337.052000] EIP:    0060:[<c01654cd>]    Not tainted VLI
[  337.052000] EFLAGS: 00010206   (2.6.19-rc4 #7)
[  337.052000] EIP is at do_no_page+0x3e/0x2f8
[  337.052000] eax: 68747541   ebx: 00000000   ecx: c04de420   edx: c04de420
[  337.052000] esi: c6af9b7c   edi: c645254c   ebp: c70f1f30   esp: c70f1ef8
[  337.052000] ds: 007b   es: 007b   ss: 0068
[  337.052000] Process httpd (pid: 1405, ti=c70f1000 task=c70f05c0 task.ti=c70f1000)
[  337.052000] Stack: c70f05c0 c70f0ad0 00000001 cddfb85c 00000002 00000246 00000000 00000000
[  337.052000]        c70f1f40 00000246 00000002 00000000 c6af9b7c c645254c c70f1f64 c01659c4
[  337.052000]        c6af8dc8 c04de420 b7d538b5 c645254c c6af9b7c 00000000 00000001 00000001
[  337.052000] Call Trace:
[  337.052000]  [<c01659c4>] __handle_mm_fault+0xdf/0x25f
[  337.052000]  [<c034cfba>] do_page_fault+0x24a/0x5f0
[  337.052000]  [<c034b691>] error_code+0x39/0x40
[  337.052000]  [<b7f83f58>] 0xb7f83f58
[  337.052000]  =======================
[  337.052000] Code: f6 40 15 04 74 08 0f 0b 6d 08 45 0a 38 c0 c7 45 e0 00 00 00 00 c7 45 e4 
00 00
00 00 8b 55 0c 83 7a 48 00 74 1b 8b 4d 0c 8b 41 48 <8b> 80 b8 00 00 00 89 45 e0 8b 70 5c 89 
75 e4 0
f ae e8 66 66 90
[  337.056000] EIP: [<c01654cd>] do_no_page+0x3e/0x2f8 SS:ESP 0068:c70f1ef8
