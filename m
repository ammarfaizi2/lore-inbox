Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWJAHy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWJAHy3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 03:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWJAHy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 03:54:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27878 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751428AbWJAHy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 03:54:28 -0400
Date: Sun, 1 Oct 2006 00:53:05 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       zaitcev@redhat.com
Subject: Re: appletouch vs. usbhid
Message-Id: <20061001005305.d94a7bb5.zaitcev@redhat.com>
In-Reply-To: <200609302217.40895.dtor@insightbb.com>
References: <20060930142003.8ba909b1.zaitcev@redhat.com>
	<200609302217.40895.dtor@insightbb.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.3; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2006 22:17:39 -0400, Dmitry Torokhov <dtor@insightbb.com> wrote:
> On Saturday 30 September 2006 17:20, Pete Zaitcev wrote:

> > A user filed a bug here which seems to indicate that hid lacks needed
> > exclusions for Apple pointers:
> >  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=208721
> > Do you think we should be adding QUIRK_IGNORE for these?
> 
> Yes, I think we should.
> 
> > Perhaps conditional on CONFIG_USB_APPLETOUCH?
> 
> No, I think we should just do that unconditionally and have users select
> appletouch driver.

The reporter sent /proc/bus/usb/devices, and the situation seems
clearer now. Perhaps this explains why authors of appletouch didn't
add exclusions themselves.

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=05ac ProdID=0218 Rev= 0.64
S:  Manufacturer=Apple Computer
S:  Product=Apple Internal Keyboard / Trackpad
C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr= 40mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl=8ms
I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=appletouch
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=8ms
I:  If#= 2 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
E:  Ad=84(I) Atr=03(Int.) MxPS=   1 Ivl=8ms

Since it's a multi-interface device, it can't be blacklisted by the
existing quirk bits, can it?

-- Pete
