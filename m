Return-Path: <linux-kernel-owner+w=401wt.eu-S1947308AbWLHVeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947308AbWLHVeV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 16:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947310AbWLHVeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 16:34:21 -0500
Received: from styx.suse.cz ([82.119.242.94]:33341 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1947308AbWLHVeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 16:34:20 -0500
Date: Fri, 8 Dec 2006 22:34:16 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Marcel Holtmann <marcel@holtmann.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <gregkh@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] HID patches for 2.6.19
In-Reply-To: <1165606697.400.2.camel@localhost>
Message-ID: <Pine.LNX.4.64.0612082231180.4215@jikos.suse.cz>
References: <20061208185419.GA6912@kroah.com>  <Pine.LNX.4.64.0612081126420.3516@woody.osdl.org>
 <1165606697.400.2.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006, Marcel Holtmann wrote:

> since we don't have any user-space or out of kernel HID transport 
> drivers at the moment it would make sense to simply select HID if 
> someone selects USB_HID or the upcoming Bluetooth transport.

OK, I agree. Something like this? (applies on top of previous patches, 
or I could collapse all the Kconfig changes into one patch if desired)

Thanks.

[PATCH] Generic HID layer - build: USB_HID should select HID, not depend on it

Let CONFIG_USB_HID imply CONFIG_HID. Making it only dependent might confuse
users to choose CONFIG_HID, but no particular HID transport drivers.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>

---
commit a94cfd7aa1df1e89b058d6eaf347ce94cd10ba71
tree b11cb076d4528603c8c11220691801231d6236c8
parent 3ecbf35f6a6b45ecbf03002da8dd6fe030196ed3
author Jiri Kosina <jkosina@suse.cz> Fri, 08 Dec 2006 22:29:13 +0100
committer Jiri Kosina <jkosina@suse.cz> Fri, 08 Dec 2006 22:29:13 +0100

 drivers/usb/input/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/input/Kconfig b/drivers/usb/input/Kconfig
index 8a62d47..e308f6d 100644
--- a/drivers/usb/input/Kconfig
+++ b/drivers/usb/input/Kconfig
@@ -7,7 +7,8 @@ comment "USB Input Devices"
 config USB_HID
 	tristate "USB Human Interface Device (full HID) support"
 	default y
-	depends on USB && HID
+	depends on USB
+	select HID
 	---help---
 	  Say Y here if you want full HID support to connect USB keyboards,
 	  mice, joysticks, graphic tablets, or any other HID based devices

-- 
Jiri Kosina
