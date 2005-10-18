Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVJRPgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVJRPgt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 11:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVJRPgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 11:36:49 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:53930 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1750734AbVJRPgt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 11:36:49 -0400
Message-ID: <4355168A.8010507@rtr.ca>
Date: Tue, 18 Oct 2005 11:36:42 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Debian/1.7.12-0ubuntu05.04
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.14-RC2 Bug?  HiSpeed USB devices demoted to low-speed after resume
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For both suspend-to-disk ("software suspend") and suspend-to-ram,
the 2.6.14-RC2 kernel appears to disable ehci_hcd on resume.

That is, plugging in a hi-speed Mass Storage device *after* resume
results in these syslog messages:

 >kernel: usb 3-1: new full speed USB device using uhci_hcd and address 2
 >kernel: usb 3-1: not running at top speed; connect to a high speed hub

Very odd.  The 2.6.13 kernel behaves much better, as does 2.6.14-RC2
*before* suspending:

 >kernel: usb 5-5: new high speed USB device using ehci_hcd and address 3

Unloading and reloading ehci_hcd restores high-speed USB operation,
until the next suspend/resume.

WTF?
