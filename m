Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031334AbWI1Cas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031334AbWI1Cas (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 22:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031335AbWI1Cas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 22:30:48 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:13206 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1031334AbWI1Car (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 22:30:47 -0400
Message-ID: <451B33C8.4080107@hitachi.com>
Date: Thu, 28 Sep 2006 11:30:32 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Organization: Systems Development Lab., Hitachi, Ltd., Japan
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: karim@opersys.com
Cc: Richard J Moore <richardj_moore@uk.ibm.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       "Frank Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Ingo Molnar <mingo@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       SystemTAP <systemtap@sources.redhat.com>,
       Satoshi Oshima <soshima@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       William Cohen <wcohen@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: Does this work? "dcprobes" an x86-hack simple djprobes-equivalent?
References: <45163D3D.4010108@opersys.com>
In-Reply-To: <45163D3D.4010108@opersys.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karim,

Thank you for new idea.
I discussed your proposal deeply with my coworkers.

I think your approach has following advantages/disadvantages/problem;
<advantages>
(a) Able to be inserted into the target address of the branch.
(b) So, binary analysis tool becomes simple.
<disadvantages>
(c) Implementation is much complicated.
(d) Highly depend on the x86 arch.
(e) Bigger overhead than djprobe.
(f) There will be side effect(*)
<problem>
(g) User applications can modify LDT. (ex. wine)

I think the dcprobe will work, but, unfortunately, it has
an vulnerability by the problem (g).

(*) In the following code:
---
a=0
do {
...
a++;
}while (a <= 100)
---
In case of inserting dcprobe at the 1st line (a=0),
it will replace 2nd (or more) instructions.
In this case, the fix up routine (based on int3)
will be invoked one hundred times.

Thanks,



-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com


