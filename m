Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLPPMm>; Sat, 16 Dec 2000 10:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLPPMc>; Sat, 16 Dec 2000 10:12:32 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:1033 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S129340AbQLPPM1>;
	Sat, 16 Dec 2000 10:12:27 -0500
Date: Sat, 16 Dec 2000 16:41:44 +0200 (EET)
From: Jani Monoses <jani@virtualro.ic.ro>
To: twaugh@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: kernel-doc minor fix
Message-ID: <Pine.LNX.4.10.10012161636480.10851-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi 

	inline docs are not generated for functions which return a 'const'
because this modifier is not checked for (only inline extern and static)
when verifying the function prototype.
This patch fixes it and hopefully doesn't break anything else(I am
Perl----)

Jani.

--- /usr/src/linux/scripts/kernel-doc	Tue Dec 12 11:25:59 2000
+++ kernel-doc	Sat Dec 16 15:53:17 2000
@@ -664,10 +664,11 @@
 
 ##
 # takes a function prototype and spits out all the details
-# stored in the global arrays/hsahes.
+# stored in the global arrays/hashes.
 sub dump_function {
     my $prototype = shift @_;
 
+    $prototype =~ s/^const+ //;
     $prototype =~ s/^static+ //;
     $prototype =~ s/^extern+ //;
     $prototype =~ s/^inline+ //;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
