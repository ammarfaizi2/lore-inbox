Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbUL2Ald@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbUL2Ald (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 19:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbUL2Ald
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 19:41:33 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:53793 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261195AbUL2AlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 19:41:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=T2X0F28f0T7qQmHjlIuHUVy8oLsLg0pBodFo+dzNWWJQUrX0qeC/b2vmutNJrZlsVGEDNNMX5QIu2Fs4wsUQPh1y0yN+oroW5zz7c7Ol7p7h7OB3gjHQUR9RmxgI90fp/gZKKGeHFAiDSIj0CY1wX0Jg/v7/Cp+0hKeKrzFusv0=
Message-ID: <41D1FD25.3020403@gmail.com>
Date: Tue, 28 Dec 2004 16:41:09 -0800
From: Jonathan Ho <jonathanho15@gmail.com>
Reply-To: jonathanho15@gmail.com
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel lib parser: cleaned up code and fixed redundancies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just cleaned up code and fixed variable assignment redundancies.

Signed-off-by: <jonathanho15@gmail.com>

----------------------------------

--- linux-2.6.10/lib/parser.c.orig    Fri Dec 24 13:34:33 2004
+++ linux-2.6.10/lib/parser.c    Tue Dec 28 12:35:38 2004
@@ -104,8 +104,7 @@ int match_token(char *s, match_table_t t
 {
     struct match_token *p;
 
-    for (p = table; !match_one(s, p->pattern, args) ; p++)
-        ;
+    for (p = table; !match_one(s, p->pattern, args); p++);
 
     return p->token;
 }
@@ -122,9 +121,8 @@ int match_token(char *s, match_table_t t
  */
 static int match_number(substring_t *s, int *result, int base)
 {
-    char *endp;
-    char *buf;
-    int ret;
+    char *endp, *buf;
+    int ret = 0;
 
     buf = kmalloc(s->to - s->from + 1, GFP_KERNEL);
     if (!buf)
@@ -132,7 +130,6 @@ static int match_number(substring_t *s,
     memcpy(buf, s->from, s->to - s->from);
     buf[s->to - s->from] = '\0';
     *result = simple_strtol(buf, &endp, base);
-    ret = 0;
     if (endp == buf)
         ret = -EINVAL;
     kfree(buf);

