Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285907AbRLYVqm>; Tue, 25 Dec 2001 16:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285910AbRLYVqb>; Tue, 25 Dec 2001 16:46:31 -0500
Received: from petasus.iil.intel.com ([192.198.152.69]:33775 "EHLO
	petasus.iil.intel.com") by vger.kernel.org with ESMTP
	id <S285907AbRLYVqQ>; Tue, 25 Dec 2001 16:46:16 -0500
Message-ID: <3C28F3A4.4010808@intel.com>
Date: Tue, 25 Dec 2001 23:46:12 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Organization: Intel
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: (v)sscanf handles %i improperly (+patch)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found (v)sscanf included in last kernels handles %i format improperly. 
Currently, up to 2.4.17, %i is handled identical to %d. However, 
accordingly to man for sscanf,

       i      Matches an  optionally  signed  integer;  the  next
              pointer  must  be a pointer to int.  The integer is
              read in base 16 if it begins with `0x' or `0X',  in
              base 8 if it begins with `0', and in base 10 other­
              wise.  Only characters that correspond to the  base
              are used.

Please, when replying, CC me: mailto:vladimir.kondratiev@intel.com

Patch is quite small (against 2.4.17):

--- vsprintf.c.orig    Thu Oct 11 20:17:22 2001
+++ vsprintf.c    Tue Dec 25 23:29:31 2001
@@ -616,8 +616,9 @@
         case 'X':
             base = 16;
             break;
-        case 'd':
         case 'i':
+            base = 0; /* autodetect */
+        case 'd':
             is_sign = 1;
         case 'u':
             break;


