Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVBJAer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVBJAer (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 19:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVBJAer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 19:34:47 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:41670 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261988AbVBJAcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 19:32:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ORJgT8fbRxpVOFEnR0i29qfJALjFNTgVPCtm64movxeZJiF8CddCPDPkFEFB0hWOie3Zp9xloWLUUXrwkHPS12/R/EzyWyFQya/RwcjWrgdsKU7X4h0LanHhnPYKTlcUkQVguoXrPOtkZTpbRH1lDZJXyvGyZCtXznBQhOwW6yk=
Message-ID: <420AAB9D.6010801@gmail.com>
Date: Wed, 09 Feb 2005 16:32:29 -0800
From: Jonathan Ho <jonathanho15@gmail.com>
Reply-To: jonathanho15@gmail.com
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] string lib redundancy and whitespace clarity fixes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed some weird whitespace, solved redundancies (applies to v2.6.10).


Signed-off-by: Jonathan Ho <jonathanho15@gmail.com>


--- lib/string.c    Fri Dec 24 13:35:25 2004
+++ \documents and settings\jonathan\desktop/string.c    Wed Feb 09 
16:21:28 2005
@@ -38,7 +38,7 @@ int strnicmp(const char *s1, const char
     /* Yes, Virginia, it had better be unsigned */
     unsigned char c1, c2;
 
-    c1 = 0;    c2 = 0;
+    c1 = c2 = 0;
     if (len) {
         do {
             c1 = *s1; c2 = *s2;
@@ -253,12 +253,12 @@ EXPORT_SYMBOL(strncmp);
  * @s: The string to be searched
  * @c: The character to search for
  */
-char * strchr(const char * s, int c)
+char *strchr(const char * s, int c)
 {
-    for(; *s != (char) c; ++s)
+    for( ; *s != (char) c; s++)
         if (*s == '\0')
             return NULL;
-    return (char *) s;
+    return (char *)s;
 }
 EXPORT_SYMBOL(strchr);
 #endif
@@ -390,14 +390,14 @@ EXPORT_SYMBOL(strcspn);
  * @cs: The string to be searched
  * @ct: The characters to search for
  */
-char * strpbrk(const char * cs,const char * ct)
+char * strpbrk(const char *cs, const char *ct)
 {
-    const char *sc1,*sc2;
+    const char *sc1, *sc2;
 
-    for( sc1 = cs; *sc1 != '\0'; ++sc1) {
-        for( sc2 = ct; *sc2 != '\0'; ++sc2) {
+    for(sc1 = cs; *sc1 != '\0'; sc1++) {
+        for(sc2 = ct; *sc2 != '\0'; sc2++) {
             if (*sc1 == *sc2)
-                return (char *) sc1;
+                return (char *)sc1;
         }
     }
     return NULL;
@@ -417,7 +417,7 @@ EXPORT_SYMBOL(strpbrk);
  * of that name. In fact, it was stolen from glibc2 and de-fancy-fied.
  * Same semantics, slimmer shape. ;)
  */
-char * strsep(char **s, const char *ct)
+char *strsep(char **s, const char *ct)
 {
     char *sbegin = *s, *end;
 
@@ -444,9 +444,9 @@ EXPORT_SYMBOL(strsep);
  *
  * Do not use memset() to access IO space, use memset_io() instead.
  */
-void * memset(void * s,int c,size_t count)
+void *memset(void *s, int c, size_t count)
 {
-    char *xs = (char *) s;
+    char *xs = (char *)s;
 
     while (count--)
         *xs++ = c;
@@ -469,7 +469,7 @@ EXPORT_SYMBOL(memset);
  * You should not use this function to access IO space, use memcpy_toio()
  * or memcpy_fromio() instead.
  */
-void bcopy(const void * srcp, void * destp, size_t count)
+void bcopy(const void *srcp, void *destp, size_t count)
 {
     const char *src = srcp;
     char *dest = destp;
@@ -490,7 +490,7 @@ EXPORT_SYMBOL(bcopy);
  * You should not use this function to access IO space, use memcpy_toio()
  * or memcpy_fromio() instead.
  */
-void * memcpy(void * dest,const void *src,size_t count)
+void *memcpy(void *dest, const void *src, size_t count)
 {
     char *tmp = (char *) dest, *s = (char *) src;
 
@@ -563,17 +563,17 @@ EXPORT_SYMBOL(memcmp);
  * returns the address of the first occurrence of @c, or 1 byte past
  * the area if @c is not found
  */
-void * memscan(void * addr, int c, size_t size)
+void *memscan(void *addr, int c, size_t size)
 {
-    unsigned char * p = (unsigned char *) addr;
+    unsigned char *p = (unsigned char *)addr;
 
     while (size) {
         if (*p == c)
-            return (void *) p;
+            return (void *)p;
         p++;
         size--;
     }
-      return (void *) p;
+      return (void *)p;
 }
 EXPORT_SYMBOL(memscan);
 #endif
@@ -584,18 +584,18 @@ EXPORT_SYMBOL(memscan);
  * @s1: The string to be searched
  * @s2: The string to search for
  */
-char * strstr(const char * s1,const char * s2)
+char *strstr(const char *s1, const char *s2)
 {
     int l1, l2;
 
     l2 = strlen(s2);
     if (!l2)
-        return (char *) s1;
+        return (char *)s1;
     l1 = strlen(s1);
     while (l1 >= l2) {
         l1--;
-        if (!memcmp(s1,s2,l2))
-            return (char *) s1;
+        if (!memcmp(s1, s2, l2))
+            return (char *)s1;
         s1++;
     }
     return NULL;
@@ -618,7 +618,7 @@ void *memchr(const void *s, int c, size_
     const unsigned char *p = s;
     while (n-- != 0) {
             if ((unsigned char)c == *p++) {
-            return (void *)(p-1);
+            return (void *)(p - 1);
         }
     }
     return NULL;

