Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277356AbRJJS3p>; Wed, 10 Oct 2001 14:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277352AbRJJS3g>; Wed, 10 Oct 2001 14:29:36 -0400
Received: from quattro-eth.sventech.com ([205.252.89.20]:29971 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S277356AbRJJS3V>; Wed, 10 Oct 2001 14:29:21 -0400
Date: Wed, 10 Oct 2001 14:32:44 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11 uhci problem ( and maybe more ) ...
Message-ID: <20011010143244.C19707@sventech.com>
In-Reply-To: <Pine.LNX.4.40.0110101041150.984-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0110101041150.984-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Wed, Oct 10, 2001 at 10:54:12AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001, Davide Libenzi <davidel@xmailserver.org> wrote:
> Kernel 2.4.11 - gcc 3.0.1
> I've got raced timeouts from uhci and a couple of complete kernel freeze.
> No usb devices attached to my usb bus.
> 2.4.x , x <= 10 are fine

This patch will fix the problem.

JE

diff --minimal -Nru a/drivers/usb/uhci.c b/drivers/usb/uhci.c
--- a/drivers/usb/uhci.c	Wed Oct 10 07:32:38 2001
+++ b/drivers/usb/uhci.c	Wed Oct 10 07:32:38 2001
@@ -1594,9 +1594,7 @@
 	}
 
 	uhci_unlink_generic(uhci, urb);
-	uhci_destroy_urb_priv(urb);
-
-	usb_dec_dev_use(urb->dev);
+	uhci_call_completion(urb);
 
 	return ret;
 }
