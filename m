Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbVK2NB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbVK2NB4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 08:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVK2NB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 08:01:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45069 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751341AbVK2NB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 08:01:56 -0500
Date: Tue, 29 Nov 2005 14:01:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>
Cc: gregkh@suse.de, Thomas Winischhofer <thomas@winischhofer.net>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/misc/sisusbvga/sisusb.c: remove dead code
Message-ID: <20051129130155.GH31395@stusta.de>
References: <20051120232239.GI16060@stusta.de> <20051123190237.GA28080@kroah.com> <20051123203150.GT3963@stusta.de> <20051128205220.GE17740@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051128205220.GE17740@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 12:52:20PM -0800, Greg KH wrote:
> On Wed, Nov 23, 2005 at 09:31:50PM +0100, Adrian Bunk wrote:
> > On Wed, Nov 23, 2005 at 11:02:37AM -0800, Greg KH wrote:
> > > On Mon, Nov 21, 2005 at 12:22:39AM +0100, Adrian Bunk wrote:
> > > > The Coverity checker found this obviously dead code.
> > > 
> > > I think the checker is wrong, this does not look correct to me.
> > 
> > Why?
> > 
> > Due to the while(length), length can't be 0 at the switch.
> 
> Doh, ok, nevermind.  Care to resend this?

It's below.

> thanks,
> 
> greg k-h

cu
Adrian


<--  snip  -->


The Coverity checker found this dead code.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/misc/sisusbvga/sisusb.c |    6 ------
 1 file changed, 6 deletions(-)

--- linux-2.6.15-rc1-mm2-full/drivers/usb/misc/sisusbvga/sisusb.c.old	2005-11-20 22:56:41.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/usb/misc/sisusbvga/sisusb.c	2005-11-20 22:58:22.000000000 +0100
@@ -861,13 +861,10 @@
 
 	while (length) {
 
 	    switch (length) {
 
-		case 0:
-			return ret;
-
 		case 1:
 			if (userbuffer) {
 				if (get_user(swap8, (u8 __user *)userbuffer))
 					return -EFAULT;
 			} else
@@ -1219,13 +1216,10 @@
 
 	while (length) {
 
 	    switch (length) {
 
-		case 0:
-			return ret;
-
 		case 1:
 
 			ret |= sisusb_read_memio_byte(sisusb, SISUSB_TYPE_MEM,
 								addr, &buf[0]);
 			if (!ret) {

