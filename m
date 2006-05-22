Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWEVD4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWEVD4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 23:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWEVD4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 23:56:24 -0400
Received: from xenotime.net ([66.160.160.81]:5335 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751196AbWEVD4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 23:56:23 -0400
Date: Sun, 21 May 2006 20:57:40 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, schwidefsky@de.ibm.com
Subject: [PATCH 5/14/] Doc. sources: expose s390/
Message-Id: <20060521205740.4d1415b4.rdunlap@xenotime.net>
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

Documentation/s390/:
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
 Documentation/s390/Debugging390.txt |   63 +-----------------------------------
 Documentation/s390/hex2ascii.c      |   59 +++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 61 deletions(-)

--- linux-2617-rc4g9-docsrc-split.orig/Documentation/s390/Debugging390.txt
+++ linux-2617-rc4g9-docsrc-split/Documentation/s390/Debugging390.txt
@@ -1478,67 +1478,8 @@ outputs
 Decoded Hex:=/ d e v / c o n s o l e 0x00 
 We were opening the console device,
 
-You can compile the code below yourself for practice :-),
-/*
- *    hex2ascii.c
- *    a useful little tool for converting a hexadecimal command line to ascii
- *
- *    Author(s): Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com)
- *    (C) 2000 IBM Deutschland Entwicklung GmbH, IBM Corporation.
- */   
-#include <stdio.h>
-
-int main(int argc,char *argv[])
-{
-  int cnt1,cnt2,len,toggle=0;
-  int startcnt=1;
-  unsigned char c,hex;
-  
-  if(argc>1&&(strcmp(argv[1],"-a")==0))
-     startcnt=2;
-  printf("Decoded Hex:=");
-  for(cnt1=startcnt;cnt1<argc;cnt1++)
-  {
-    len=strlen(argv[cnt1]);
-    for(cnt2=0;cnt2<len;cnt2++)
-    {
-       c=argv[cnt1][cnt2];
-       if(c>='0'&&c<='9')
-	  c=c-'0';
-       if(c>='A'&&c<='F')
-	  c=c-'A'+10;
-       if(c>='a'&&c<='f')
-	  c=c-'a'+10;
-       switch(toggle)
-       {
-	  case 0:
-	     hex=c<<4;
-	     toggle=1;
-	  break;
-	  case 1:
-	     hex+=c;
-	     if(hex<32||hex>127)
-	     {
-		if(startcnt==1)
-		   printf("0x%02X ",(int)hex);
-		else
-		   printf(".");
-	     }
-	     else
-	     {
-	       printf("%c",hex);
-	       if(startcnt==1)
-		  printf(" ");
-	     }
-	     toggle=0;
-	  break;
-       }
-    }
-  }
-  printf("\n");
-}
-
-
+You can compile the hex2ascii code yourself for practice :-),
+See Documentation/s390/hex2ascii.c
 
 
 Stack tracing under VM
--- /dev/null
+++ linux-2617-rc4g9-docsrc-split/Documentation/s390/hex2ascii.c
@@ -0,0 +1,59 @@
+/*
+ *    hex2ascii.c
+ *    a useful little tool for converting a hexadecimal command line to ascii
+ *
+ *    Author(s): Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com)
+ *    (C) 2000 IBM Deutschland Entwicklung GmbH, IBM Corporation.
+ */
+#include <stdio.h>
+#include <string.h>
+
+int main(int argc,char *argv[])
+{
+  int cnt1,cnt2,len,toggle=0;
+  int startcnt=1;
+  unsigned char c,hex;
+
+  if(argc>1&&(strcmp(argv[1],"-a")==0))
+     startcnt=2;
+  printf("Decoded Hex:=");
+  for(cnt1=startcnt;cnt1<argc;cnt1++)
+  {
+    len=strlen(argv[cnt1]);
+    for(cnt2=0;cnt2<len;cnt2++)
+    {
+       c=argv[cnt1][cnt2];
+       if(c>='0'&&c<='9')
+	  c=c-'0';
+       if(c>='A'&&c<='F')
+	  c=c-'A'+10;
+       if(c>='a'&&c<='f')
+	  c=c-'a'+10;
+       switch(toggle)
+       {
+	  case 0:
+	     hex=c<<4;
+	     toggle=1;
+	  break;
+	  case 1:
+	     hex+=c;
+	     if(hex<32||hex>127)
+	     {
+		if(startcnt==1)
+		   printf("0x%02X ",(int)hex);
+		else
+		   printf(".");
+	     }
+	     else
+	     {
+	       printf("%c",hex);
+	       if(startcnt==1)
+		  printf(" ");
+	     }
+	     toggle=0;
+	  break;
+       }
+    }
+  }
+  printf("\n");
+}


---
