Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265932AbUFDSsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUFDSsT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265921AbUFDSsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:48:19 -0400
Received: from [141.156.69.115] ([141.156.69.115]:18049 "EHLO
	mail.infosciences.com") by vger.kernel.org with ESMTP
	id S265949AbUFDSry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:47:54 -0400
Message-ID: <40C0C3D7.3090007@infosciences.com>
Date: Fri, 04 Jun 2004 14:47:51 -0400
From: nardelli <jnardelli@infosciences.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Memory leak in visor.c and ftdi_sio.c
References: <40C08E6D.8080606@infosciences.com> <20040604181252.GA11499@kroah.com>
In-Reply-To: <20040604181252.GA11499@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

^*(&*(# editor not copying tabs - I should have caught that.
Here's another try: 


This was prepared against 2.6.7-rc2.

Signed-off-by: Joe Nardelli <jnardelli@infosciences.com>

diff -uprN -X dontdiff linux-2.6.7-rc2.orig/drivers/usb/serial/ftdi_sio.c linux-2.6.7-rc2/drivers/usb/serial/ftdi_sio.c
--- linux-2.6.7-rc2.orig/drivers/usb/serial/ftdi_sio.c	2004-06-04 10:10:21.112743024 -0400
+++ linux-2.6.7-rc2/drivers/usb/serial/ftdi_sio.c	2004-06-04 09:53:27.000000000 -0400
@@ -1504,6 +1504,7 @@ static int ftdi_write (struct usb_serial
 	if (status) {
 		err("%s - failed submitting write urb, error %d", __FUNCTION__, status);
 		count = status;
+		kfree (buffer);
 	}
 
 	/* we are done with this urb, so let the host driver
diff -uprN -X dontdiff linux-2.6.7-rc2.orig/drivers/usb/serial/visor.c linux-2.6.7-rc2/drivers/usb/serial/visor.c
--- linux-2.6.7-rc2.orig/drivers/usb/serial/visor.c	2004-06-04 10:10:21.210728128 -0400
+++ linux-2.6.7-rc2/drivers/usb/serial/visor.c	2004-06-04 10:13:10.214035720 -0400
@@ -515,6 +515,7 @@ static int visor_write (struct usb_seria
 		dev_err(&port->dev, "%s - usb_submit_urb(write bulk) failed with status = %d\n",
 			__FUNCTION__, status);
 		count = status;
+		kfree (buffer);
 	} else {
 		bytes_out += count;
 	}



Greg KH wrote:
> 
> 
> This patch has all of the tabs stripped out of it and can not be applied
> :(
> 
> Care to try it again?
> 
> thanks,
> 
> greg k-h
> 


-- 
Joe Nardelli
jnardelli@infosciences.com
