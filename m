Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVEIO20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVEIO20 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 10:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVEIO0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 10:26:04 -0400
Received: from colino.net ([213.41.131.56]:19447 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261395AbVEIOZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 10:25:10 -0400
Date: Mon, 9 May 2005 16:24:54 +0200
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Cc: linux-usb-devel@lists.sf.net
Subject: [2.6.12-rc4] network wlan connection goes down
Message-ID: <20050509162454.1c1c09a9@colin.toulouse>
X-Mailer: Sylpheed-Claws 1.9.9 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I upgraded to 2.6.12-rc4, and noticed something strange after that.
After a few hours, the network connection goes down. The network
connectivity is done via a USB wifi stick driven by zd1201.

After that, nothing gets through, not even a ping. ifconfig wlan0 shows
the interface UP and configured; iwconfig shows the Wifi is correctly
associated with the access point (and the access point's client list
shows the zd1201's MAC as associated). The LED on the stick is lit as
usual (when associated). The kernel log doesn't show anything useful.

The connection comes back when running my network configuration script
again. The script issues four commands:
iwconfig wlan0 essid foo channel 11 key xx:xx...:xx 
ifconfig wlan0 192.168.0.11
route del default
route add default gw 192.168.0.100
(I have to find out which of the four commands reenables the
connection, didn't try yet)

Everything was fine using 2.6.12-rc3; the only zd1201 patch that went
in 2.6.12-rc4 is "USB: drivers/usb/net/zd1201.c: make some code static"
by Adrian Bunk, which I think can't be harmful at all.

Would anyone have any hint about what could have changed in the usb
subsystem (ohci driver) or in the network subsystem, that might cause
that?

Thanks,
-- 
Colin
