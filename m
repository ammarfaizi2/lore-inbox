Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbTDPPdL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbTDPPdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:33:11 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.26]:45012 "EHLO
	mwinf0504.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264537AbTDPPdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:33:09 -0400
Date: Wed, 16 Apr 2003 17:44:55 +0200
Subject: PATCH: usb-uhci: interrupt out with urb->interval 0 
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v551)
Cc: linux-kernel@vger.kernel.org
To: usb@in.tum.de
From: Frode Isaksen <fisaksen@bewan.com>
Content-Transfer-Encoding: 7bit
Message-Id: <5EDFED9C-7022-11D7-8F05-003065EF6010@bewan.com>
X-Mailer: Apple Mail (2.551)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A recent change (2.4.21) in the usb-uhci driver calls 
"uhci_clean_iso_step2" after the completion of one-shot (urb->interval 
0) interrupt out transfers. This call clears the list of descriptors. 
However, it crashes when trying to get the next desciptor in the "for" 
loop in the "process_interrupt" function, since the list of descriptors 
are already cleared. A simple change I did was to do a "break" to quit 
the "for" loop for interrupt out transfers with urb->interval 0.

Thanks,
Frode


--- drivers/usb/usb-uhci.c.orig	2003-04-16 15:39:04.000000000 +0200
+++ drivers/usb/usb-uhci.c	2003-04-16 15:39:56.000000000 +0200
@@ -2628,6 +2628,7 @@
  				// correct toggle after unlink
  				usb_dotoggle (urb->dev, usb_pipeendpoint (urb->pipe), usb_pipeout 
(urb->pipe));
  				clr_td_ioc(desc); // inactivate TD
+				break;
  			}
  		}
  	}

