Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267191AbTBQRWi>; Mon, 17 Feb 2003 12:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267198AbTBQRWi>; Mon, 17 Feb 2003 12:22:38 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:59586 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267191AbTBQRWh>; Mon, 17 Feb 2003 12:22:37 -0500
Message-Id: <200302171732.SAA00873@post.webmailer.de>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: [RFC] klibc for 2.5.59 bk
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Date: Mon, 17 Feb 2003 18:12:33 +0100
References: <20030217031008$3e63@gated-at.bofh.it> <20030217031008$270a@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:

> should work fine (reminder: "make KBUILD_VERBOSE=0 ..." will give you much 
> more readable output), but I probably broke some non-x86 architectures 
> in the process.

I just tried building on s390x and only needed this trivial fix. Unfortunately,
2.5.61 does not boot on s390x yet, so I could not do run-time tests.

        Arnd <><

===== usr/lib/socketcalls.pl 1.4 vs edited =====
--- 1.4/usr/lib/socketcalls.pl  Sun Feb 16 06:09:33 2003
+++ edited/usr/lib/socketcalls.pl       Mon Feb 17 18:24:39 2003
@@ -39,7 +39,7 @@
            print OUT "\tjmp __socketcall_common\n";
            print OUT "\t.size ${name},.-${name}\n";
        } else {
-           open(OUT, "> ${obj}/${name}.c")
+           open(OUT, "> ${obj}/socketcalls/${name}.c")
                or die "$0: Cannot open socketcalls/${name}.c\n";
            print OUT "#include \"socketcommon.h\"\n\n";
            
