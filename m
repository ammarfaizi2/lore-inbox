Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbTAODCo>; Tue, 14 Jan 2003 22:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261354AbTAODCo>; Tue, 14 Jan 2003 22:02:44 -0500
Received: from blizzard.bluegravity.com ([64.57.64.28]:42760 "HELO
	blizzard.bgci.net") by vger.kernel.org with SMTP id <S261337AbTAODCo>;
	Tue, 14 Jan 2003 22:02:44 -0500
Message-ID: <3E24D1D5.5090200@ryanflynn.com>
Date: Tue, 14 Jan 2003 22:13:25 -0500
From: ryan <ryan@ryanflynn.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.56 sound/oss/sb_mixer.c bounds check
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN a/sound/oss/sb_mixer.c b/sound/oss/sb_mixer.c
--- a/sound/oss/sb_mixer.c      Fri Jan 10 15:11:27 2003
+++ b/sound/oss/sb_mixer.c      Tue Jan 14 22:06:20 2003
@@ -333,6 +333,9 @@
                         break;

                 default:
+                       /* bounds check */
+                       if (dev >= sizeof(smw_mix_regs))
+                               return -EINVAL;
                         reg = smw_mix_regs[dev];
                         if (reg == 0)
                                 return -EINVAL;

