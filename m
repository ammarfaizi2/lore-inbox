Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVK0TGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVK0TGR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 14:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVK0TGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 14:06:17 -0500
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:30341 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750785AbVK0TGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 14:06:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:From:Organization:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=pDYfvD6PHM/3k8J1KOBYqEz8Wvpo4A9iQGrW+l2CvZIAZFcKo31CDZAMsGJZlc2FhspPIznbHRkfwc3ZRGn1fFYlEMFquemftXX3JZd78MXYcg+6yhUHHM0L3gyBK0/+2gcLMb8ap0ewlkxg3BZAYtkktPUIh+STEh8WNuqhJsM=  ;
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: [2.5.15-rc2] khubd eating all CPU upon trying to remove pwc driver
Date: Sun, 27 Nov 2005 14:06:10 -0500
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511271406.11266.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg, 

It appears while debugging camserv to add some features, if I kill camserv 
prematurely, and try to unload the pwc driver I am unable to. 

I get the following:

PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
1068 root      20  -5     0    0    0 R 95.8  0.0   3:26.84 khubd

The kernel USB hub daemon goes nuts. 

If I disconnect the cam from the USB

[4294920.159000] pwc pwc_isoc_handler() called with status -84 [CRC/Timeout 
(could be anything)].
[4294920.166000] hub 2-0:1.0: state 5 ports 2 chg 0000 evt 0004
[4294920.166000] uhci_hcd 0000:00:1d.1: port 2 portsc 008a,00
[4294920.166000] hub 2-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
[4294920.166000] usb 2-2: USB disconnect, address 4
[4294920.166000] usb 2-2: usb_disable_device nuking all URBs
[4294920.166000] uhci_hcd 0000:00:1d.1: shutdown urb f56a10fc pipe 00028480 
ep5in-iso
[4294920.166000] uhci_hcd 0000:00:1d.1: shutdown urb f5680d04 pipe 00028480 
ep5in-iso
[4294920.167000] pwc pwc_isoc_handler() called with status -108 [Unknown].
[4294920.167000] pwc Error (-19) re-submitting urb in pwc_isoc_handler.
[4294920.167000] pwc pwc_isoc_handler() called with status -108 [Unknown].
[4294920.167000] pwc Error (-19) re-submitting urb in pwc_isoc_handler.
[4294920.167000] usb 2-2: unregistering interface 2-2:1.0
[4294920.167000] pwc Disconnected while webcam is in use!
[4294921.416000] uhci_hcd 0000:00:1d.1: suspend_rh (auto-stop)

What information do you need? Yes I know it's bad to yank out USB devices that 
aren't properly shut down.

Thanks, 

Shawn.
