Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267298AbUHDGKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267298AbUHDGKI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 02:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267295AbUHDGHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 02:07:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:43934 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267274AbUHDGH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 02:07:26 -0400
Date: Tue, 3 Aug 2004 22:49:17 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] awe_wave (OSS): too much __exit
Message-Id: <20040803224917.23932bcf.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


'make buildcheck' indicates that these functions should not be
in an __exit section, so undo that.  Yes, they can be called
from .text.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 sound/oss/awe_wave.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./sound/oss/awe_wave.c~awe_exit ./sound/oss/awe_wave.c
--- ./sound/oss/awe_wave.c~awe_exit	2004-06-15 22:19:13.000000000 -0700
+++ ./sound/oss/awe_wave.c	2004-08-03 21:42:04.556691656 -0700
@@ -4130,7 +4130,7 @@ static void __init attach_mixer(void)
 	}
 }
 
-static void __exit unload_mixer(void)
+static void unload_mixer(void)
 {
 	if (my_mixerdev >= 0)
 		sound_unload_mixerdev(my_mixerdev);
@@ -4968,7 +4968,7 @@ static void __init attach_midiemu(void)
 		midi_devs[my_mididev] = &awe_midi_operations;
 }
 
-static void __exit unload_midiemu(void)
+static void unload_midiemu(void)
 {
 	if (my_mididev >= 0)
 		sound_unload_mididev(my_mididev);


--
