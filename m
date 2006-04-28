Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751713AbWD1AUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbWD1AUE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbWD1ATy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:19:54 -0400
Received: from cantor2.suse.de ([195.135.220.15]:32213 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751732AbWD1ATh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:19:37 -0400
Date: Thu, 27 Apr 2006 17:18:04 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Eric Sesterhenn <snakebyte@gmx.de>, smurf@smurf.noris.de,
       Adrian Bunk <bunk@stusta.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 06/24] USB: fix array overrun in drivers/usb/serial/option.c
Message-ID: <20060428001804.GG18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-fix-array-overrun-in-drivers-usb-serial-option.c.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Eric Sesterhenn <snakebyte@gmx.de>

since the arrays are declared as in_urbs[N_IN_URB]
and out_urbs[N_OUT_URB] both for loops, go one
over the end of the array. This fixes coverity id #555

This patch was already included in Linus' tree.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/serial/option.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.16.11.orig/drivers/usb/serial/option.c
+++ linux-2.6.16.11/drivers/usb/serial/option.c
@@ -582,14 +582,14 @@ static void option_setup_urbs(struct usb
 	portdata = usb_get_serial_port_data(port);
 
 	/* Do indat endpoints first */
-	for (j = 0; j <= N_IN_URB; ++j) {
+	for (j = 0; j < N_IN_URB; ++j) {
 		portdata->in_urbs[j] = option_setup_urb (serial,
                   port->bulk_in_endpointAddress, USB_DIR_IN, port,
                   portdata->in_buffer[j], IN_BUFLEN, option_indat_callback);
 	}
 
 	/* outdat endpoints */
-	for (j = 0; j <= N_OUT_URB; ++j) {
+	for (j = 0; j < N_OUT_URB; ++j) {
 		portdata->out_urbs[j] = option_setup_urb (serial,
                   port->bulk_out_endpointAddress, USB_DIR_OUT, port,
                   portdata->out_buffer[j], OUT_BUFLEN, option_outdat_callback);

--
