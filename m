Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSJZRH2>; Sat, 26 Oct 2002 13:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261308AbSJZRH2>; Sat, 26 Oct 2002 13:07:28 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:24838 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261290AbSJZRH1>;
	Sat, 26 Oct 2002 13:07:27 -0400
Date: Sat, 26 Oct 2002 10:11:45 -0700
From: Greg KH <greg@kroah.com>
To: Kevin Brosius <cobra@compuserve.com>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.44-ac3 usb audio - illegal sleep call
Message-ID: <20021026171145.GD2720@kroah.com>
References: <3DBAA320.B02AB7FC@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DBAA320.B02AB7FC@compuserve.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2002 at 10:13:52AM -0400, Kevin Brosius wrote:
> I've been trying to get USB up to test a audio device and just managed
> to get it all working to some extent.  When using xmms to play audio
> (usb audio module - oss soundcore) I see the following kernel messages
> repeatedly, maybe once a second or so:

Can you try this patch and let us know if it fixes your problem?

thanks,

greg k-h


===== drivers/usb/class/audio.c 1.43 vs edited =====
--- 1.43/drivers/usb/class/audio.c	Fri Oct 18 21:31:28 2002
+++ edited/drivers/usb/class/audio.c	Sat Oct 26 10:22:43 2002
@@ -914,7 +914,7 @@
 	if (!usbin_retire_desc(u, urb) &&
 	    u->flags & FLG_RUNNING &&
 	    !usbin_prepare_desc(u, urb) && 
-	    (suret = usb_submit_urb(urb, GFP_KERNEL)) == 0) {
+	    (suret = usb_submit_urb(urb, GFP_ATOMIC)) == 0) {
 		u->flags |= mask;
 	} else {
 		u->flags &= ~(mask | FLG_RUNNING);
@@ -1274,7 +1274,7 @@
 	if (!usbout_retire_desc(u, urb) &&
 	    u->flags & FLG_RUNNING &&
 	    !usbout_prepare_desc(u, urb) && 
-	    (suret = usb_submit_urb(urb, GFP_KERNEL)) == 0) {
+	    (suret = usb_submit_urb(urb, GFP_ATOMIC)) == 0) {
 		u->flags |= mask;
 	} else {
 		u->flags &= ~(mask | FLG_RUNNING);
