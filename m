Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbUKCOdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbUKCOdj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 09:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbUKCOdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 09:33:39 -0500
Received: from imap.gmx.net ([213.165.64.20]:39087 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261248AbUKCOdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 09:33:35 -0500
Date: Wed, 3 Nov 2004 15:33:34 +0100 (MET)
From: "Alexander Stohr" <Alexander.Stohr@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: kai@germaschewski.name, sam@ravnborg.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary316291099492414"
Subject: [PATCH] fix for pseudo symbol swapping with scripts/kallsyms - linux-2.6.10-rc1-bk12 & gcc 3.4.2
X-Priority: 3 (Normal)
X-Authenticated: #15156664
Message-ID: <31629.1099492414@www8.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary316291099492414
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

when trying out gcc 3.4.2 (in contrast to my former gcc 3.3.3)
with a recent bitkeeper snapshot of the linux kernel (2.6.10-rc1-bk12)
i suddenly got a notification about problems with symbol check
and hinting me for turning on CONFIG_KALLSYMS_EXTRA_PASS, thus
suggesting me to turn on tripple pass bzImage linking as a 
short term work around.

a deeper analysis of the symbols (using nm and a hacked in table
dump for kallsyms) showed me that the symbols "__sched_text_start"
and "__down" did fall onto the very same memory location in 
linker run 2 and 3 and further did swap their order! (a-z sorted?)
in linker run 1, there was a small offset between them for whatever
reason which prevented them from beeing consolidated and swapped.
(i dont see what makes up the difference here. take it as a hint.)

as such names, like the *_start and *_end symbols, are only used
for the kernel integrated stack dumps range checking, and even
that is only needed for some two archs, my solution of choice
was to add all similar "no real data" symbols to the list of
stripped symbols in the sources of the kallsyms application.

Below you will find my patch for inclusion into the Linux kernel.

-Alex.

PS: please CC me on replys as i am not subscribed to the lkml.

-- 
Geschenkt: 3 Monate GMX ProMail + 3 Top-Spielfilme auf DVD
++ Jetzt kostenlos testen http://www.gmx.net/de/go/mail ++
--========GMXBoundary316291099492414
Content-Type: application/octet-stream; name="linux-2.6.10-rc1-bk12-kallsyms.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.10-rc1-bk12-kallsyms.patch.bz2"

QlpoOTFBWSZTWRK/rakAAV3fgAIwUB//MHYBCAC/79/gQAJVc2bQASppMhMTTMoNABoZPUaaASJA
VHogGJoxAA9T1NMgwGjIaDCAaAaaAACqImkYFPSTZNNJkYgANNMCasJDLkFBClEG4zFNDEENGXNd
8lnWeApCaaOVa5zPR0e8rVC395WJhfEWYuqx8ZF0E2RrGxJBiYVlFtEvkvH9G++FG3+z/KuCsQ3P
uELad7NiNoiOxNI8kI6Oa7zei/rJqeRx6vnu8zIsS5nAqdLk4GJKUvRc4NlyzwLyq5/TbdWlzbcw
0JgpIy+S5CljpG0gsahfOiXlNkICdTAKHVI6SWRGfccPdtttuFYBjGgNhI8JqRwF7BBjkUBWxbbg
ILwhU8aN2KoJmIzzKkfh2e2z8sCPat/79hzjuKRvPKNydxg5OCyPVgVAxRID1D0ERBSHwykXJzqt
IvZrUsoUSurYR8tWzudso/VWjLPCuZ/u3BjKJb1VKnffNaKqtEo1YcmK/RLgjAtC2bHW5cjUzep4
sjoxb1TnxTK2rGOtFhetFkZLlniUlC3JKTinpKKVpRD3YJZFSkOHva03w1aXKInmVjXRGMNG+Vyf
A2LkwvWXyR7Ttvl3mxoijVpyJijt1x42sEwxR3F2O+g8UxLhnMpThYjZlUpkvilKrQwOqzHNpmjF
zMs8tqxl1nmoaI0vbkR/xdyRThQkBK/rakA=

--========GMXBoundary316291099492414--

