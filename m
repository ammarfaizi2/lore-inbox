Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289768AbSBET0x>; Tue, 5 Feb 2002 14:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289769AbSBET0n>; Tue, 5 Feb 2002 14:26:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2321 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289768AbSBET0b>;
	Tue, 5 Feb 2002 14:26:31 -0500
Message-ID: <3C6031C6.C0CBB4C8@zip.com.au>
Date: Tue, 05 Feb 2002 11:25:58 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: llx@swissonline.ch
CC: linux-kernel@vger.kernel.org
Subject: Re: confused about block device behaviour
In-Reply-To: <200202051620.g15GKdH17123@mail.swissonline.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lord latex wrote:
> 
> hi
> 
> i've got written a block device driver for the 2.4.x
> kernel and it seems to work. but something looks
> strange to me. i've go a very simple application that
> does nothing more then open the block device, read
> 1024 byte and close the device. when i run this app.
> serveral times my do_request function gets called
> every time. why? i expect this block beeing buffered
> in the buffer cache. what do i don't see, or what is
> possibly wrong with my block device?
> 

The kernel invalidates the device's cache on the final close.
If you hold the device open in a different process:

	sleep 1000 < /dev/foo

while you run the test, you'll see that the underlying device's
contents are indeed cached.

-
