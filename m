Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUIOB3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUIOB3X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 21:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUIOB3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 21:29:23 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.78]:49305 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S265395AbUIOB3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 21:29:20 -0400
Date: Tue, 14 Sep 2004 21:29:44 -0400
From: Avi Norowitz <anorowitz@fortressitx.com>
Subject: High Memory Results in Poor Performance on Asus P4P800-MX Motherboard
To: linux-kernel@vger.kernel.org
Message-id: <009f01c49ac3$7b04aa20$0100000a@FIRE>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

At the dedicated hosting company I work for we have been having some serious
performance problems with Linux 2.6.8.1 on Pentium 4 servers running the
Asus P4P800-MX motherboard. Some of these servers run as if they were
Pentium 1s, while others run as if they were 386s. (I am not exaggerating.)

Eventually I found that this problem is resolved with a compiled kernel with
high memory disabled. Of course, this is not an attractive solution, since
many of our servers have over 1GB of memory. However, I came across this
solution on linux-kernel, archived at Google:

http://groups.google.com/groups?selm=1bD5H-1aI-9%40gated-at.bofh.it

This solution worked for servers with 1GB of memory, but not servers with
1.5GB. However, I was able to modify the commands so it worked with servers
with 1.5GB of memory, and presumably servers up to 4GB:

echo "disable=9" >| /proc/mtrr
echo "disable=8" >| /proc/mtrr
echo "disable=7" >| /proc/mtrr
echo "disable=6" >| /proc/mtrr
echo "disable=5" >| /proc/mtrr
echo "disable=4" >| /proc/mtrr
echo "disable=3" >| /proc/mtrr
echo "disable=2" >| /proc/mtrr
echo "disable=1" >| /proc/mtrr
echo "disable=0" >| /proc/mtrr
echo "base=0x00000000 size=0x100000000 type=write-back" > /proc/mtrr

I am very glad that I was able to resolve the problem, but I have three
further questions.

1. Is there a better fix to use than to have the above commands run at boot?

2. Which is at fault: the motherboard or the Linux kernel?

3. Should I expect this problem to be resolved in future kernels?

If any developers would like root access to a test server having this
problem to investigate the problem, please let me know.

Thank you for your time.

Sincerely,
Avi Norowitz
Unix Technical Support
Fortress ITX / DedicatedNOW / Pegasus Web Technologies

