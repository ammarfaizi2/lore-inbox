Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbTDQFyI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 01:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbTDQFxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 01:53:11 -0400
Received: from granite.he.net ([216.218.226.66]:56336 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263086AbTDQFvC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 01:51:02 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10505595041530@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.67
In-Reply-To: <10505595042845@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 16 Apr 2003 23:05:04 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1062, 2003/04/14 10:25:40-07:00, henning@meier-geinitz.de

[PATCH] USB scanner.c endpoint detection fix

This patch fixes the endpoint numbers. They were numbered from 1 to n
but that assumption is not correct in all cases.


diff -Nru a/drivers/usb/image/scanner.c b/drivers/usb/image/scanner.c
--- a/drivers/usb/image/scanner.c	Wed Apr 16 10:48:55 2003
+++ b/drivers/usb/image/scanner.c	Wed Apr 16 10:48:55 2003
@@ -355,6 +355,10 @@
  *      is closed and disconnected. Avoids crashes when writing to a 
  *      disconnected device. (Thanks to Greg KH).
  *
+ * 0.4.12  2003-04-11
+ *    - Fixed endpoint detection. The endpoints were numbered from 1 to n but
+ *      that assumption is not correct in all cases.
+ *
  * TODO
  *    - Performance
  *    - Select/poll methods
@@ -957,7 +961,7 @@
 				info ("probe_scanner: ignoring additional bulk_in_ep:%d", ep_cnt);
 				continue;
 			}
-			have_bulk_in = ep_cnt;
+			have_bulk_in = endpoint->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
 			dbg("probe_scanner: bulk_in_ep:%d", have_bulk_in);
 			continue;
 		}
@@ -968,7 +972,7 @@
 				info ("probe_scanner: ignoring additional bulk_out_ep:%d", ep_cnt);
 				continue;
 			}
-			have_bulk_out = ep_cnt;
+			have_bulk_out = endpoint->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
 			dbg("probe_scanner: bulk_out_ep:%d", have_bulk_out);
 			continue;
 		}
@@ -979,7 +983,7 @@
 				info ("probe_scanner: ignoring additional intr_ep:%d", ep_cnt);
 				continue;
 			}
-			have_intr = ep_cnt;
+			have_intr = endpoint->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
 			dbg("probe_scanner: intr_ep:%d", have_intr);
 			continue;
 		}

