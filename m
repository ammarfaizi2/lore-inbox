Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277365AbRJJSjP>; Wed, 10 Oct 2001 14:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277363AbRJJSjH>; Wed, 10 Oct 2001 14:39:07 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:20241 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S277359AbRJJSis>;
	Wed, 10 Oct 2001 14:38:48 -0400
Date: Wed, 10 Oct 2001 11:31:45 -0700
From: Greg KH <greg@kroah.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB SMP race in 2.4.11
Message-ID: <20011010113145.E7782@kroah.com>
In-Reply-To: <20011010222223.A1223@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011010222223.A1223@linuxhacker.ru>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 10:22:23PM +0400, Oleg Drokin wrote:
> Hello!
> 
>    I have caught kernel oops that is related to SMP race on usb modules
>    deregistering.
>    2.4.10 was fine with the same setup.
>    USB core is compiled-in, hub driver is uhci (as module).
>    Here is the decoded oops:

Can you try the attached patch and let us know if the oops still
happens?

thanks,

greg k-h


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
