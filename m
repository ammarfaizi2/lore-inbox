Return-Path: <linux-kernel-owner+w=401wt.eu-S1750979AbXAUCrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbXAUCrW (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 21:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbXAUCrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 21:47:22 -0500
Received: from web52901.mail.yahoo.com ([206.190.49.11]:34292 "HELO
	web52901.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750979AbXAUCrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 21:47:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=dXOBSRHn8kGlG5nBFHC8iGSJXYvagdrw4mOFusmC5paiVkinPmkRo1uE0pR+IBbfeDXavjfaqb1n3VCGIRdunUlMyAclAIc1VYdUCbbJLzOcBCNEDNdmvL+2LVlPYvJ3xwpw8WJzg1d13EJqaW79aHwx6ZCjagKWGj/9OtLmnQs=;
X-YMail-OSG: 1goo8uwVM1n10v_GRPFFLMPm86AALnAJNx0bNlGk3BgLhJKf6caoqVT3YAi_7w.Hs0GwdnpWECX7hFNOtOPnDOroDEXcY8Xf9_dwzU5eJSQfpsLplipEJ5emnA_gKRXxdpVX23SPKns5mdE-
Date: Sun, 21 Jan 2007 02:47:20 +0000 (GMT)
From: Chris Rankin <rankincj@yahoo.com>
Subject: [PATCH] Register the bus, vendor and product IDs for dvb-usb remote device
To: v4l-dvb-maintainer@linuxtv.org
Cc: linux-dvb@linuxtv.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <879469.96393.qm@web52901.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch writes the USB vendor and product IDs into the /sys/class/input/inputX/id/ files, so
that udev can find them. A rule like this does the trick for me:

KERNEL="event*", SYSFS{../id/vendor}=="2040", SYSFS{../id/product}=="9301",
SYMLINK+="input/dvb-remote"

--- linux-2.6.18/drivers/media/dvb/dvb-usb/dvb-usb-remote.c.old 2007-01-21 02:43:11.000000000
+0000
+++ linux-2.6.18/drivers/media/dvb/dvb-usb/dvb-usb-remote.c     2007-01-21 02:39:02.000000000
+0000
@@ -107,6 +107,9 @@
        d->rc_input_dev->keycodemax = KEY_MAX;
        d->rc_input_dev->name = "IR-receiver inside an USB DVB receiver";
        d->rc_input_dev->phys = d->rc_phys;
+       d->rc_input_dev->id.bustype = BUS_USB;
+       d->rc_input_dev->id.vendor = d->udev->descriptor.idVendor;
+       d->rc_input_dev->id.product = d->udev->descriptor.idProduct;

        /* set the bits for the keys */
        deb_rc("key map size: %d\n", d->props.rc_key_map_size);

Cheers,
Chris



		
___________________________________________________________ 
What kind of emailer are you? Find out today - get a free analysis of your email personality. Take the quiz at the Yahoo! Mail Championship. 
http://uk.rd.yahoo.com/evt=44106/*http://mail.yahoo.net/uk 
