Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265624AbTFRXwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 19:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265625AbTFRXwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 19:52:22 -0400
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:1680 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S265624AbTFRXwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 19:52:18 -0400
Message-ID: <20030619000604.19693.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 18 Jun 2003 19:06:04 -0500
Subject: Re: Flaw in the driver-model implementation of attributes
X-Originating-Ip: 172.141.41.132
X-Originating-Server: ws3-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Doubting that there is a sysfs faq anywhere
yet, ...)

What is a sysfs "class", as in /sys/class/...?

What do sysfs classes have in common? How is
a /sys/class/ different from a /sys/devices,
/sys/bus, etc?

In re: the current discussion, are the "usb-storage" attributes under discussion
something that the vfs would need to know
about(/sys/block/)? Something that a pci
bus would need to know about? Something that
a usb controller would need to know about?

Vfs models are virtual, so vfs having its
own sysfs tree for block devices does not
create any confusion relative to an
organization based on the the hardware
connection tree in the machine.

But when you are considering where to place
attributes meant to be evaluated by low-level
hardware drivers, it is easier to follow if the
organization follows a

  bus (ie pci, for example)
    host-controller/mux
      bus
        device
          [bus
            device...]

organization. (The bracketed branch is for a
cascade or bridge device.)

So how does "class" fit into that model?
Does it signify a domain of buses, a set
of bus attributes (should be under the
"/sysfs/bustype/busnum/" in that case),
a set of controller attributes, a set
of device attributes, or some software
abstraction like block or char device
attributes?

Regards,

Clayton Weaver
<mailto: cgweav@email.com>


-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

CareerBuilder.com has over 400,000 jobs. Be smarter about your job search
http://corp.mail.com/careers


