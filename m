Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbVHVV4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbVHVV4A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVHVV4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:56:00 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:9348 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751289AbVHVVzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:55:15 -0400
Message-ID: <01d301c5a717$33ec55a0$03c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Stefan Nickl" <Stefan.Nickl@kontron.com>, <vojtech@suse.cz>
Cc: <linux-kernel@vger.kernel.org>, <trivial@rustcorp.com.au>,
       <linux-usb-devel@lists.sourceforge.net>
References: <1124702731.19750.6.camel@lucy.pep-kaufbeuren.de>
Subject: Re: [linux-usb-devel] [PATCH] hiddev: output reports are dropped when HIDIOCSREPORT is called in short succession
Date: Mon, 22 Aug 2005 08:44:14 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-15";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Nickl wrote:
> Hi,
>
> when trying to make the hiddev driver issue several Set_Report control
> transfers to a custom device with 2.6.13-rc6, only the first transfer
> in a row is carried out, while others immediately following it are
> silently dropped.
>
> This happens where hid_submit_report() (in hid-core.c) tests for
> HID_CTRL_RUNNING, which seems to be still set because the first
> transfer is not finished yet.
>
> As a workaround, inserting a delay between the two calls to
> ioctl(HIDIOCSREPORT) in userspace "solves" the problem.
> The straightforward fix is to add a call to hid_wait_io() to the
> implementation of HIDIOCSREPORT (in hiddev.c), just like for
> HIDIOCGREPORT. Works fine for me.

Yup, I've seen the same issue on the apcupsd project. I added the 
hid_wait_io() call to HIDIOCGREPORT a while back since it used to suffer 
from the same problem. I'd have no objection to making HIDIOCSREPORT 
synchronous as well.

--Adam

