Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVCCM0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVCCM0o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 07:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVCCMYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 07:24:43 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:1934 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261554AbVCCMT1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 07:19:27 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
CC: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu,_03_Mar_2005_12_19_20_+0000_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20050303121920.1E8B9774D8@merlin.emma.line.org>
Date: Thu,  3 Mar 2005 13:19:20 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

this patch speeds up your "stupid release" script; in fact the hog was
in changelog itself the use of bk prs; this is known to be slow, and I'd
asked Larry if bk changes (which is A LOT faster) would have the same
effect months ago, and he approved using bk changes after bk set -d.

So I've switched your "changelog" script and diffed the output of
changelog v2.6.11-rc5 to v2.6.11 and found no changes in the output, but
a massive decrease in time taken:

changelog speed for Linux v2.6.11-rc5 to v2.6.11 is down from 51s at 97%
CPU to 6.5s at 46% CPU on a system with 7200/min IDE HDD and Athlon XP 2500+.

------

You can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.278, 2005-03-03 13:15:55+01:00, matthias.andree@gmx.de
  Add one address -> name mapping.

ChangeSet@1.277, 2005-03-03 13:13:10+01:00, matthias.andree@gmx.de
  Major speed up for generating changelog output.

ChangeSet@1.276, 2005-03-03 12:36:39+01:00, matthias.andree@gmx.de
  Cosmetic: make ==== underline as long as the title "Summary of changes from ... to ...".

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 changelog |    4 ++--
 shortlog  |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

##### GNUPATCH #####
--- 1.6/changelog	2002-05-13 17:51:44 +02:00
+++ 1.8/changelog	2005-03-03 13:13:09 +01:00
@@ -17,6 +17,6 @@
 fi
 echo
 echo Summary of changes from $FROMNAME to $TONAME
-echo ============================================
+echo Summary of changes from $FROMNAME to $TONAME | sed -e 's/./=/g'
 echo
-bk set -n -d -r"$FROM" -r"$TO" | bk -R prs -h -d'$unless(:MERGE:){<:P:@:HOST:>\n$each(:C:){\t(:C:)\n}\n}' -
+bk set -d -r"$FROM" -r"$TO" | bk changes -aefd'$unless(:MERGE:){<:P:@:HOST:>\n$each(:C:){\t(:C:)\n}\n}' -

--- 1.242/shortlog	2005-02-23 15:43:14 +01:00
+++ 1.243/shortlog	2005-03-03 13:15:54 +01:00
@@ -506,6 +506,7 @@
 'c-d.hailfinger.kernel.2002-q4:gmx.net' => 'Carl-Daniel Hailfinger', # himself
 'c-d.hailfinger.kernel.2003:gmx.net' => 'Carl-Daniel Hailfinger', # himself
 'c-d.hailfinger.kernel.2004:gmx.net' => 'Carl-Daniel Hailfinger',
+'c.lucas@com.rmk.(none)' => 'Christophe Lucas',
 'c.lucas:ifrance.com' => 'Christophe Lucas',
 'cagle:mindspring.com' => 'John Cagle', # Alan
 'calum.mackay:cdmnet.org' => 'Calum Mackay', # lbdb



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAMcAJ0ICA9VXbVPjNhD+jH/FTo5OuOHsSLZlx56GgUtyB3NQmAAz/cAXYSuxS2xlLJmX
qfvfu7YhATrpFUqHXrKxLVla7e7z6LHzAQ5G4YaWxTWfx2p3IfJZmeaWLniuMqG5FcmsGiY8
n4lToSubEBu/1HaIx4LKDjzGKmELxiKX8ku/74vINj7AuRJFuJFxrZOUK4vncSEE9u9LpcON
WXZrxXVzIiU2e6pUonclilzMe5+/oZltw9RSzpWBA0+4jhK4FoUKN6jlLHv03UKEG5Px1/PD
vYlhDAawjBUGA+ON81q5W0SBTyyp4rkli9lTR4zYtkuZywipPGYT1xgBtWzfA8J6xEEDaoeO
FzrBNqEhIfCsTrttfWCbgkmMz/DGWQyNCIaynp9GIa59JbBUWLkyj0UxT3MBXMFc5rP6rBMB
OtVzAZ3TMst4cQdyClGzpIJpITOwLAtDrE8dy/gGnuvZzDhZAWGYL/wYBuHE2FnlnchMPEu6
jWAuZ/dJUzTqu05FXEKD6pJ7TkSoR2PXibnH15T4qRtGHOJQ6nhOUDl9PBrGmmnP8F5Na5Nv
8fYf4e2EtZF3w/uI/yYLUAshYigXMMXGTOSi4DpFnJdVAFnqRanvYST9HxhGmzqkhrFPyEtg
xGmUVG3yLYz9pzCykLF3g3EvjkHWGzTGBZUCcwdyngmMZLFAIO9xo/Q/x00lstBL2BjtE9/1
ab9yqB+waioCPo18EnAiYn4Zr4PtsZeH8jPmVg6jttuo+YqZj9X83xPpJb4YUoIx6mJcuMX9
hhb+a7Sc/nBa3qrgMZjFzW1t5i0ya1meVzBrZBOgxkFzFFEiYV0gm18mx0e/7B2N63A2z46b
ywoU6pcpoKt6Vm/Qm3XXbu3vCHuNYf+5PpP3w/Dv9bkGbpnQJ7hJdYJCDXw6FVEz4EG2I0A7
TPPyFq5ty7MoNYuI1SW8b0KqIJY3eVtkRhVwDYH/EwxPzuthnsWaLtdrutCbzIGDulNaZM3C
4GNWvSzN8cVxDPujEWCRYE8nyDL49QRsfO3ZbrlTS++bcsduuFMfL6+QChpMZEPRabjSaa7O
jjvIErz7QCaTi2nc3SzzOerlVng0nnwdhx9//zk8CXfD/ePTs3DnIt8UPEq2wiHeuNDN+SL/
A60LZqNCDzr1PRF6mSoa/0gVbdtB6cEfeqGu0z6UXOcvDyX3//xQagX9GRce8nwFFQ4Y6SML
upE1LyOudjF0q8iurK0cA/nYhcEOdIdJkSotF7h3DutB3U+rPxJRIqIrVWYDn3g8EAEz/gQ1
g060CA0AAA==

