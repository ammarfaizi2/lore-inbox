Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278084AbRJKDt3>; Wed, 10 Oct 2001 23:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278086AbRJKDtT>; Wed, 10 Oct 2001 23:49:19 -0400
Received: from quattro-eth.sventech.com ([205.252.89.20]:55057 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S278085AbRJKDtE>; Wed, 10 Oct 2001 23:49:04 -0400
Date: Wed, 10 Oct 2001 23:52:32 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Colin Bayer <vogon_jeltz@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB "raced timeout" errors on boot (2.4.11)
Message-ID: <20011010235232.J9457@sventech.com>
In-Reply-To: <3BC51513.8040604@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BC51513.8040604@users.sourceforge.net>; from vogon_jeltz@users.sourceforge.net on Wed, Oct 10, 2001 at 08:42:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001, Colin Bayer <vogon_jeltz@users.sourceforge.net> wrote:
> Whenever I boot with my brand-new 2.4.11 kernel, I get the following 
> series of errors (this snippet's from /var/log/messages):

This patch fixed the problem.

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
