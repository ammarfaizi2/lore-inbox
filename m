Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289089AbSBSAvB>; Mon, 18 Feb 2002 19:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289096AbSBSAuv>; Mon, 18 Feb 2002 19:50:51 -0500
Received: from mail.gmx.de ([213.165.64.20]:14561 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S289089AbSBSAum>;
	Mon, 18 Feb 2002 19:50:42 -0500
Message-ID: <3C71A149.3030706@GMX.li>
Date: Tue, 19 Feb 2002 01:50:17 +0100
From: Jan Schubert <Jan.Schubert@GMX.li>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, boris@kista.gajba.net
Subject: Re: mdacon driver updates
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've posted a small fix to mdacon.c at the end of last year (while 
Marcello was in vacation). It has'nt made it to the kernel yet, nor was 
there any feedback. I've thought, thats the way like open source works...

So, here we go again (against 2.4.17; my MDA is detected, but not 
initialized, see my last posting):

--- drivers/video/mdacon.c.orig    Sun Dec 30 02:44:25 2001
+++ drivers/video/mdacon.c    Sun Dec 30 21:36:50 2001
@@ -24,6 +24,7 @@
  *
  *  Changelog:
  *  Paul G. (03/2001) Fix mdacon= boot prompt to use __setup().
+ *  20011230 Jan.Schubert@GMX.li - consider non-Hercules MDA compatible
  */

 #include <linux/types.h>
@@ -291,6 +292,10 @@
                                break;
                }
        }
+       else {  /* consider non-Hercules as Hercules-compatible */
+               mda_type = TYPE_HERC;
+               mda_type_name = "Hercules compatible (hopefully)";
+       }

        return 1;
 }
@@ -342,9 +347,8 @@
                return NULL;
        }

-       if (mda_type != TYPE_MDA) {
-               mda_initialize();
-       }
+       /* at this point, we found an MDA */
+       mda_initialize();

        /* cursor looks ugly during boot-up, so turn it off */
        mda_set_cursor(mda_vram_len - 1);

