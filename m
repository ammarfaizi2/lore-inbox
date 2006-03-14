Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751747AbWCNBKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbWCNBKP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 20:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbWCNBKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 20:10:15 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:11149 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751747AbWCNBKN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 20:10:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eCexW0qDpPq6dNQxOfj9edNatMyPkrtQT6VAy7mPBkfYIy8QwLI5z86n/G5/IX6yHPlEVrk4RbdlVpEpduu7Q09h+d/iBcNgqGtsEYvWij3HPfZMhg4g535dZWsf/yQUoqmp4mihp247big0jyUOVhE/gjz33aOqSTqTde4vkwI=
Message-ID: <38c09b90603131710p7932c12qf6e8602b9b0b59c8@mail.gmail.com>
Date: Tue, 14 Mar 2006 09:10:13 +0800
From: "Lanslott Gish" <lanslott.gish@gmail.com>
To: "Daniel Ritz" <daniel.ritz-ml@swissonline.ch>
Subject: Re: [RFC][PATCH] USB touch screen driver, all-in-one
Cc: "Greg KH" <greg@kroah.com>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>, tejohnson@yahoo.com,
       hc@mivu.no, vojtech@suse.cz
In-Reply-To: <38c09b90603121701q69c61221lf92bb150e419b1c9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <38c09b90603100124l1aa8cbc6qaf71718e203f3768@mail.gmail.com>
	 <200603112155.38984.daniel.ritz-ml@swissonline.ch>
	 <38c09b90603121701q69c61221lf92bb150e419b1c9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Daniel,

i fixed some codes and add swap_x & swap_y functions.
and test your patch passed for my touchset hrdware.
here is the patch only for your usbtouchscreen.c
could you help to apply this?
thank you.

Regards,

Lanslott Gish

==============================================================
--- linux-2.6.16-rc6.patched/drivers/usb/input/usbtouchscreen.c
+++ linux-2.6.16-rc6/drivers/usb/input/usbtouchscreen.c
@@ -224,13 +224,24 @@
  * PanJit Part
  */
 #ifdef CONFIG_USB_TOUCHSCREEN_PANJIT
+
+static int swap_x;
+module_param(swap_x, bool, 0644);
+MODULE_PARM_DESC(swap_x, "If set X axe is swapped before XY swapped.");
+static int swap_y;
+module_param(swap_y, bool, 0644);
+MODULE_PARM_DESC(swap_y, "If set Y axe is swapped before XY swapped.");
+
 static int panjit_read_data(char *pkt, int *x, int *y, int *touch, int *press)
 {
-       *x = pkt[1] | (pkt[2] << 8);
-       *y = pkt[3] | (pkt[4] << 8);
+       *x = (pkt[1] & 0x0F) | ((pkt[2]& 0xFF) << 8);
+       *y = (pkt[3] & 0x0F) | ((pkt[4]& 0xFF) << 8);
        *touch = (pkt[0] & 0x01) ? 1 : 0;

-       return 1;
+	if(swap_x) *x = *x ^ 0x0FFF;
+	if(swap_y) *y = *y ^ 0x0FFF;
+
+ 	return 1;
 }
 #endif

==============================================================



On 3/13/06, Lanslott Gish <lanslott.gish@gmail.com> wrote:
> Hi, Daniel,
> it's great. i will test touchset part today.
>
> Regards,
>
> Lanslott Gish
>
> On 3/12/06, Daniel Ritz <daniel.ritz-ml@swissonline.ch> wrote:
> > hi
> >
> > here my merge of the USB touchscreen drivers, based on my patch from
> > thursday for touchkitusb. this time it's a new driver...
> >
> > and of course it's untested. i can test the egalax part next week...
> >
> > [ also cc'ing the authors of the other drivers ]
> >
> > the sizes for comparison:
> >    text    data     bss     dec     hex filename
> >    2942     724       4    3670     e56 touchkitusb.ko
> >    2647     660       0    3307     ceb mtouchusb.ko
> >    2448     628       0    3076     c04 itmtouch.ko
> >    4097    1012       4    5113    13f9 usbtouchscreen.ko
> >
> > comments?
> >
> > rgds
> > -daniel
> >
>


--
L.G, Life's Good~
