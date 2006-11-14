Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933407AbWKNK5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933407AbWKNK5S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 05:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933408AbWKNK5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 05:57:18 -0500
Received: from iona.labri.fr ([147.210.8.143]:39374 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S933407AbWKNK5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 05:57:17 -0500
X-Amavis-Alert: BAD HEADER Improper folded header field made up entirely of
	whitespace (char 20 hex): Subject: ...ocess.c:328: error: 'PAGE_SHIFT'
	undeclared\n \n
Message-ID: <4559A0D7.6050808@labri.fr>
Date: Tue, 14 Nov 2006 11:56:23 +0100
From: Emmanuel Fleury <fleury@labri.fr>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: jdike@addtoit.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [UML] arch/um/os-Linux/skas/process.c:328: error: 'PAGE_SHIFT' undeclared 
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some problems in 2.6.18.2 with UML:

arch/um/os-Linux/skas/process.c: In function 'copy_context_skas0':
arch/um/os-Linux/skas/process.c:328: error: 'PAGE_SHIFT' undeclared
(first use in this function)
arch/um/os-Linux/skas/process.c:328: error: (Each undeclared identifier
is reported only once
arch/um/os-Linux/skas/process.c:328: error: for each function it appears
in.)
arch/um/os-Linux/skas/process.c:560:2: warning: #warning need cpu pid in
switch_mm_skas
make[2]: *** [arch/um/os-Linux/skas/process.o] Error 1
make[1]: *** [arch/um/os-Linux/skas] Error 2
make[1]: *** Waiting for unfinished jobs....

Solved with the following patch (probably already solved but just in
case you didn't...):

--- arch/um/include/sysdep-i386/stub.h.orig 2006-11-04
02:33:58.000000000 +0100
+++ arch/um/include/sysdep-i386/stub.h      2006-11-14
11:23:20.000000000 +0100
@@ -12,6 +12,7 @@
 #include "stub-data.h"
 #include "kern_constants.h"
 #include "uml-config.h"
+#include "asm/page.h"

 extern void stub_segv_handler(int sig);
 extern void stub_clone_handler(void);

Regards
-- 
Emmanuel Fleury              | Office: 261
Associate Professor,         | Phone: +33 (0)5 40 00 69 34
LaBRI, Domaine Universitaire | Fax:   +33 (0)5 40 00 66 69
351, Cours de la Libération  | email: emmanuel.fleury@labri.fr
33405 Talence Cedex, France  | URL: http://www.labri.fr/~fleury
