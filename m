Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271737AbTG2OR6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271817AbTG2OR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:17:56 -0400
Received: from iv.ro ([194.105.28.94]:60709 "HELO iv.ro") by vger.kernel.org
	with SMTP id S271737AbTG2ORx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:17:53 -0400
Date: Tue, 29 Jul 2003 17:31:51 +0300
From: Jani Monoses <jani@iv.ro>
To: linux-kernel@vger.kernel.org
Subject: timeout (110) with bluez usb uhci  2.4.21
Message-Id: <20030729173151.048c2bb8.jani@iv.ro>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The same problem here as the one raported about a week ago by Florian
Lohoff. I have two USB bluetooth dongles. One of them (ambicom
bt2000) does not like being hotplugged in it gives that timeout message
after saying it was an error in interrupt.The other (blue-gene bt320)
can be connected/disconncted and it works fine.
The same problem shows with 2.4.22-pre7
If the usb-uhci module is reloaded while the dongle is in it finds it.
The problem as shown by debug messages in uhci seems to be error in the
interrupt handler for uhci. The status register is 2 which is io/error I
think and it says the frame was corrupted.
So I changed the handler to return when that's the status and only go on
if status is 1 which I think is normal usb interrupt transfer not an
error condition. This way probably the usb stack retries again and the
dongle is found after a few seconds and can be plugged in and out.
I have seen in other threads that somebody made usb_get_address retry on
error to achieve the same effect...
can some workaround by somebody who knows what's happening be put in the
kernel because google shows that quite a few people are bitten by this
110 error message with uhci/ohci and various usb devices not only BT.

thanks
Jani
