Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268053AbTAIWZG>; Thu, 9 Jan 2003 17:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268052AbTAIWZG>; Thu, 9 Jan 2003 17:25:06 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:21430 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S268053AbTAIWZF>;
	Thu, 9 Jan 2003 17:25:05 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: linux-kernel@vger.kernel.org
Date: Thu, 9 Jan 2003 23:33:32 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: How build dependencies work/are supposed to work in 2.5.5x
X-mailer: Pegasus Mail v3.50
Message-ID: <CC66A71361E@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I spent last few hours by patching 2.5.54-bk-something back and 
forward to shrink Juriaans patch which reinstates 2.5.50 fbdev. Sometime
during this course something happened, and I ended up with incorrect
build: some code was thinking that "struct vc_data" contains
"vc_font" element, and some parts believed that there is no such element,
and structure is 24 bytes smaller (shifting vc_origin somewhere, causing
crash during bootup) :-( (there was such element, then there was not,
and then element arrived back during evening)

  After I removed drivers/char/*.o and all .o from drivers/video subtree
and rerun "make", problem disappeared. During patching I never used -T/-Z 
option to patch to set dates/times on files and I also did not use -j option
to make.

  So I'd like to ask whether current kernel build system is supposed
to track changes in include files automagically, or whether I'm supposed
to run 'make dep' from time to time?

  When I tried to recreate problem (by doing "touch 
include/linux/console_struct.h"), all objects which use this file were
correctly rebuilt.
                                    Thanks,
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz
                                        
