Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbWEVD7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWEVD7v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 23:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWEVD7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 23:59:50 -0400
Received: from xenotime.net ([66.160.160.81]:6871 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751556AbWEVD4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 23:56:25 -0400
Date: Sun, 21 May 2006 20:57:42 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, linux@dominikbrodowski.net
Subject: [PATCH 6/14/] Doc. sources: expose pcmcia/
Message-Id: <20060521205742.0cd2273b.rdunlap@xenotime.net>
In-Reply-To: <20060521203349.40b40930.rdunlap@xenotime.net>
References: <20060521203349.40b40930.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Documentation/pcmcia/:
Expose example and tool source files in the Documentation/ directory in
their own files instead of being buried (almost hidden) in readme/txt files.

This will make them more visible/usable to users who may need
to use them, to developers who may need to test with them, and
to janitors who would update them if they were more visible.

Also, if any of these possibly should not be in the kernel tree at
all, it will be clearer that they are here and we can discuss if
they should be removed.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/pcmcia/crc32hash.c     |   32 +++++++++++++++++++++++++++++++
 Documentation/pcmcia/devicetable.txt |   36 ++---------------------------------
 2 files changed, 35 insertions(+), 33 deletions(-)

--- /dev/null
+++ linux-2617-rc4g9-docsrc-split/Documentation/pcmcia/crc32hash.c
@@ -0,0 +1,32 @@
+/* crc32hash.c - derived from linux/lib/crc32.c, GNU GPL v2 */
+/* Usage example:
+$ ./crc32hash "Dual Speed"
+*/
+
+#include <string.h>
+#include <stdio.h>
+#include <ctype.h>
+#include <stdlib.h>
+
+unsigned int crc32(unsigned char const *p, unsigned int len)
+{
+	int i;
+	unsigned int crc = 0;
+	while (len--) {
+		crc ^= *p++;
+		for (i = 0; i < 8; i++)
+			crc = (crc >> 1) ^ ((crc & 1) ? 0xedb88320 : 0);
+	}
+	return crc;
+}
+
+int main(int argc, char **argv) {
+	unsigned int result;
+	if (argc != 2) {
+		printf("no string passed as argument\n");
+		return -1;
+	}
+	result = crc32(argv[1], strlen(argv[1]));
+	printf("0x%x\n", result);
+	return 0;
+}
--- linux-2617-rc4g9-docsrc-split.orig/Documentation/pcmcia/devicetable.txt
+++ linux-2617-rc4g9-docsrc-split/Documentation/pcmcia/devicetable.txt
@@ -27,37 +27,7 @@ pcmcia:m0149cC1ABf06pfn00fn00pa725B842Dp
 The hex value after "pa" is the hash of product ID string 1, after "pb" for
 string 2 and so on.
 
-Alternatively, you can use this small tool to determine the crc32 hash.
-simply pass the string you want to evaluate as argument to this program,
-e.g.
+Alternatively, you can use crc32hash (see Documentation/pcmcia/crc32hash.c)
+to determine the crc32 hash.  Simply pass the string you want to evaluate
+as argument to this program, e.g.:
 $ ./crc32hash "Dual Speed"
-
--------------------------------------------------------------------------
-/* crc32hash.c - derived from linux/lib/crc32.c, GNU GPL v2 */
-#include <string.h>
-#include <stdio.h>
-#include <ctype.h>
-#include <stdlib.h>
-
-unsigned int crc32(unsigned char const *p, unsigned int len)
-{
-	int i;
-	unsigned int crc = 0;
-	while (len--) {
-		crc ^= *p++;
-		for (i = 0; i < 8; i++)
-			crc = (crc >> 1) ^ ((crc & 1) ? 0xedb88320 : 0);
-	}
-	return crc;
-}
-
-int main(int argc, char **argv) {
-	unsigned int result;
-	if (argc != 2) {
-		printf("no string passed as argument\n");
-		return -1;
-	}
-	result = crc32(argv[1], strlen(argv[1]));
-	printf("0x%x\n", result);
-	return 0;
-}


---
