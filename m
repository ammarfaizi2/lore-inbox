Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVBJUN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVBJUN1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 15:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVBJUMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 15:12:05 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:47787 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S261660AbVBJULR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 15:11:17 -0500
X-OB-Received: from unknown (205.158.62.49)
  by wfilter.us4.outblaze.com; 10 Feb 2005 20:05:38 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
From: "Simon White" <s_a_white@email.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 10 Feb 2005 15:05:37 -0500
Subject: Detecting kernel shutdown in a kernel driver
X-Originating-Ip: 81.102.24.86
X-Originating-Server: ws1-1.us4.outblaze.com
Message-Id: <20050210200537.AD4754BE65@ws1-1.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been writing a device driver for a piece of hardware that we recently found the pci bridge has an issue on software reset (kernel 2.6.8.1, hardware reset is fine).  The bridge appears to corrupt the subvendor/device ids on next boot.  We have found a software work around in that I can write to the bridge on module exit and it will always detect correctly next boot (through module_exit when rmmod'd).

However on shutting down a machine with the module loaded it never works next time, so is module_exit actually called?

Secondly I searched through some code and on google to determine if I could detect a shutdown notification in the kernel.  I thougt I'd found something using:

static struct pci_driver hsid_driver =
{
    .name     = HSID_NAME,
    .id_table = id_table,
    .probe    = hsid_probe,
    .driver   =
    {
        .shutdown = hsid_shutdown,
    },
};

However that also appears not to work.  I wondered what the correct solution was for detecting system shutdown in the kernel even if the application using the device has locked up on un-interruptible sleep, so I may try to clean the hardware up a little.

Thankyou for any assistance,
Simon

Please CC me.

-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

