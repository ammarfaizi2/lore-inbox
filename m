Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133086AbRASRqT>; Fri, 19 Jan 2001 12:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136247AbRASRqH>; Fri, 19 Jan 2001 12:46:07 -0500
Received: from exit1.i-55.com ([204.27.97.1]:19678 "EHLO exit1.i-55.com")
	by vger.kernel.org with ESMTP id <S133086AbRASRqB>;
	Fri, 19 Jan 2001 12:46:01 -0500
Message-ID: <3A687C00.FAD6FFBE@mailhost.cs.rose-hulman.edu>
Date: Fri, 19 Jan 2001 11:40:16 -0600
From: Leslie Donaldson <donaldlf@hermes.cs.rose-hulman.edu>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test12 alpha)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Patch for aic7xxx 2.4.0 test12 hang
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a temporary patch to keep the scsi driver from eating
your data.... I am working on a real fix....

Leslie Donaldson


*** linux/drivers/scsi/aic7xxx.c.2.4.0-12       Sat Jan  6 21:55:47 2001
--- linux/drivers/scsi/aic7xxx.c        Sat Jan  6 22:08:12 2001
***************
*** 7073,7078 ****
--- 7073,7092 ----
        else
        {
  
+         if(((strcmp("Adaptec AIC-7892 Ultra 160/m SCSI host
adapter",board_names[p->board_name_index])) == 0 ) ||
+            ((strcmp("Adaptec AIC-7899 Ultra 160/m SCSI host
adapter",board_names[p->board_name_index])) == 0 ))
+         {
+           /* The TCQ code for 160M devices is BROKEN */
+           /* This is a quick, dirty, sad fix until I have time for a
better */
+           /* one. We do it this way in case the driver is supporting
two seperate */
+           /* styles of scsi chipsets... I do have two boards so it
does happen */
+           tag_enabled = FALSE;
+           device->queue_depth = 3;  /* Tagged queueing is disabled. */
+           printk(INFO_LEAD "DISABLED TAGGED QUEUING, queue depth
%d.\n",
+                  p->host_no, device->channel, device->id,
+                  device->lun, 0);
+         }
+         else
          if (aic7xxx_tag_info[p->instance].tag_commands[tindex] == 255)
          {
            tag_enabled = FALSE;

-- 
/----------------------------\ Current Contractor: None
|    Leslie F. Donaldson     | Current Customer  : None
|    Computer Contractor     | Skills:
Unix/OS9/VMS/Linux/SUN-OS/C/C++/assembly
| Have Computer will travel. | WWW  :
http://www.cs.rose-hulman.edu/~donaldlf
\----------------------------/ Email: mail://donaldlf@cs.rose-hulman.edu
Goth Code V1.1: GoCS$$ TYg(T6,T9) B11Bk!^1 C6b-- P0(1,7) M+ a24 n---
b++:+
                H6'11" g m---- w+ r+++ D--~!% h+ s10 k+++ R-- Ssw
LusCA++
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
