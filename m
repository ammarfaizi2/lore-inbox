Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWAIUSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWAIUSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWAIUSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:18:07 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:15054 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751307AbWAIUSG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:18:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PvxKWtW0E6w72he9QGwv0bYT+8C6DXnTFZSeCXqnDQdrjOMx4ZAlZ7ZMRvzj5AOQjG338vwchOdeoaHD0GSOAtSAOEyqlnPHcnTzwTpVwGUVqwwOSOq3eiDjWPaPA1QU1PK/UzG+W7pbR66fgHLXyudafuhQWSORkSNykUviMoM=
Message-ID: <9a8748490601091218m1ff0607h79207cfafe630864@mail.gmail.com>
Date: Mon, 9 Jan 2006 21:18:05 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: LKML List <linux-kernel@vger.kernel.org>
Subject: Athlon 64 X2 cpuinfo oddities
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently bought a Dual Core AMD Athlon 64 X2 4400+ CPU and dropped a
2.6.15 kernel on the box and it runs very nice, but /proc/cpuinfo
shows a few things that seem slightly odd to me (haven't tried earlier
kernels on this so I don't know if cpuinfo looked different
previously).
It may be that it's absolutely correct and not odd at all, but I
thought I'd just ask :)

Here's what  cat /proc/cpuinfo  shows :

juhl@dragon:~$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 2200.260
cache size      : 1024 KB
physical id     : 0
siblings        : 1
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 4403.36

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 2200.260
cache size      : 1024 KB
physical id     : 127
siblings        : 1
core id         : 1
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 4399.53


So, what's odd with that?

Well, first of all you'll notice that the second core shows a
"physical id" of 127 while the first core shows an id of 0.  Shouldn't
the second core be id 1, just like the "core id" fields are 0 & 1?

Second thing I find slightly odd is the lack of "sse3" in the "flags" list.
I was under the impression that all AMD Athlon 64 X2 CPU's featured SSE3?
Is it a case of:
 a) Me being wrong, not all Athlon 64 X2's feature SSE3?
 b) The CPU actually featuring SSE3 but Linux not taking advantage of it?
 c) The CPU features SSE3 and it's being utilized, but /proc/cpuinfo
doesn't show that fact?
 d) Something else?


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
