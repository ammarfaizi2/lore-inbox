Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbTLJNXu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 08:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbTLJNWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 08:22:46 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:54415
	"EHLO perso.free.fr") by vger.kernel.org with ESMTP id S263523AbTLJNWl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 08:22:41 -0500
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Wed, 10 Dec 2003 14:22:40 +0100
User-Agent: KMail/1.5.4
Cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312101422.40088.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That leads to the question of how to assure that the device doesn't go
> away before usb_set_configuration is called.  Perhaps
> usb_set_configuration and usb_unbind_interface should be changed to
> require the caller to hold the serialize lock.

How about

__usb_set_configuration - lockless version
usb_set_configuration - locked version

?

By the way, here is the list of routines that cause trouble for usbfs:

usb_probe_interface
usb_reset_device
usb_set_configuration
usb_unbind_interface

Both usb_set_configuration and usb_unbind_interface can be trivially
modified to have a __ form.  usb_probe_interface and usb_reset_device
require thought.

All the best,

Duncan.
