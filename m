Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285000AbRL3VDq>; Sun, 30 Dec 2001 16:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284987AbRL3VDg>; Sun, 30 Dec 2001 16:03:36 -0500
Received: from mail.gmx.de ([213.165.64.20]:34403 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S285000AbRL3VD3>;
	Sun, 30 Dec 2001 16:03:29 -0500
Message-ID: <3C2F8100.6070701@GMX.li>
Date: Sun, 30 Dec 2001 22:02:56 +0100
From: Jan Schubert <Jan.Schubert@GMX.li>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-video@atrey.karlin.mff.cuni.cz
Subject: [PATCH] drivers/video/mdacon.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against linux-2417/drivers/video/mdacon.c to get 
non-Hercules MDA working. Actually it does nothing, than assume a non 
Hercules-MDA is compatible to "normal" Hercules. The current behaviour 
is something confussing...

The problem whith the current version is, if you have such a 
non-Hercules MDA it will detected while booting the kernel and you see a 
message like "MDA with 8k RAM detected". Unfortunatley this message is 
printed, but your card will _not_ be initialized, is it not recognized 
as Hercules-compatible. So you will see the boot-message (and assume it 
is working), but nothing on your MDA-console/monitor. So we have to 
change this. It would be correct, to modify mdacon.c to _not_ print a 
message about detecting a MDA is it not Hercules-compatible. But as i 
mentioned above, at least my card is detected as non-Hercules but seems 
fully compatible. So I would prefer, to consider any detected 
non-Hercules MDA as Hercules-compatible. Please note, there is also some 
special detection of "HerculesPlus" and "HerculesColor" in mdacon.c. 
Does anybody know about any non Hercules compatible MDA ?

TiA,
Jan

------------------

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

