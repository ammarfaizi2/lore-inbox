Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRAFAjL>; Fri, 5 Jan 2001 19:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132074AbRAFAjC>; Fri, 5 Jan 2001 19:39:02 -0500
Received: from smtp2.libero.it ([193.70.192.52]:58763 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S129561AbRAFAiq>;
	Fri, 5 Jan 2001 19:38:46 -0500
Date: Sat, 6 Jan 2001 03:39:36 +0100
From: antirez <antirez@invece.org>
To: antirez <antirez@invece.org>
Cc: Greg KH <greg@wirex.com>, Heitzso <xxh1@cdc.gov>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Johannes Erdfelt'" <johannes@erdfelt.com>
Subject: Re: USB broken in 2.4.0
Message-ID: <20010106033936.A1748@prosa.it>
Reply-To: antirez@invece.org
In-Reply-To: <B7F9A3E3FDDDD11185510000F8BDBBF2049E7F99@mcdc-atl-5.cdc.gov> <20010105100040.A25217@wirex.com> <20010106000429.K7784@prosa.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010106000429.K7784@prosa.it>; from antirez@invece.org on Sat, Jan 06, 2001 at 12:04:29AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2001 at 12:04:29AM +0100, antirez wrote:
> I'll do some test with the new 2.4 kernel to find if there is a problem
> in s10sh itself. A good test can be to try if the equivalent driver
> of gphoto works without problems using the 2.4 kernel (however it also
> uses the libusb). The s10sh bug may be not necessarly related to the USB
> subsystem.

Ok, the problem is the same that I ecountered developing the file
upload for the powershot USB driver performing a bulk write with
a big data size, but this time it is present even reading.

s10sh reads 0x1400 bytes at once downloading jpges from the
digicam, but the ioctl() that performs the bulk read fails with 2.4
using this size. If I resize it (for example to 0x300) it works without
problems (with high performace penality, of course, 60% of slow-down).
I don't know why. I checked at the time of the file upload the kernel
code finding nothing.

Anyway with the old releases of the USB subsystem libusb failed to
initialize the camera some time, now it seems fixed.

For the users: just edit usb.c and check the function USB_get_data(),
substituting all the occurrence of 0x1400 to 0x300 as a work-around.

Please CC: me since I'm not subscribed to the list.

regards,
antirez

-- 
Salvatore Sanfilippo              |                      <antirez@invece.org>
http://www.kyuzz.org/antirez      |      PGP: finger antirez@tella.alicom.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
