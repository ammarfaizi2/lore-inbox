Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271845AbTG2SLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 14:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272008AbTG2SLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 14:11:53 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:46778 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id S271845AbTG2SLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 14:11:49 -0400
Message-Id: <5.1.0.14.2.20030729110847.15049408@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 29 Jul 2003 11:11:39 -0700
To: Jani Monoses <jani@iv.ro>, linux-kernel@vger.kernel.org
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: timeout (110) with bluez usb uhci  2.4.21
In-Reply-To: <20030729173151.048c2bb8.jani@iv.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:31 AM 7/29/2003, Jani Monoses wrote:
>The same problem here as the one raported about a week ago by Florian
>Lohoff. I have two USB bluetooth dongles. One of them (ambicom
>bt2000) does not like being hotplugged in it gives that timeout message
>after saying it was an error in interrupt.The other (blue-gene bt320)
>can be connected/disconncted and it works fine.
>The same problem shows with 2.4.22-pre7
>If the usb-uhci module is reloaded while the dongle is in it finds it.
>The problem as shown by debug messages in uhci seems to be error in the
>interrupt handler for uhci. The status register is 2 which is io/error I
>think and it says the frame was corrupted.
>So I changed the handler to return when that's the status and only go on
>if status is 1 which I think is normal usb interrupt transfer not an
>error condition. This way probably the usb stack retries again and the
>dongle is found after a few seconds and can be plugged in and out.
>I have seen in other threads that somebody made usb_get_address retry on
>error to achieve the same effect...
>can some workaround by somebody who knows what's happening be put in the
>kernel because google shows that quite a few people are bitten by this
>110 error message with uhci/ohci and various usb devices not only BT.

Did you try the trick that I suggested to Florian ? i.e. changing HCI_MAX_BULK_TX from 4 to 1.
It did help some people. Also you might want to try usb-uhci driver instead of uhci.

Max

