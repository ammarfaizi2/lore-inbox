Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263247AbTHVMnb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 08:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbTHVMlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 08:41:53 -0400
Received: from catv-50624ad9.szolcatv.broadband.hu ([80.98.74.217]:45974 "EHLO
	boszi-lnx.localdomain") by vger.kernel.org with ESMTP
	id S263185AbTHVMFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 08:05:48 -0400
Message-ID: <3F460719.4080903@freemail.hu>
Date: Fri, 22 Aug 2003 14:05:45 +0200
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, hu
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to use an USB<->serial adapter?
References: <3F44BEA2.8010108@freemail.hu> <20030821170822.GA3584@kroah.com>
In-Reply-To: <20030821170822.GA3584@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here's the test programs output and I also set the module option
debug=1 in pl2303.

The testprograms' sources are still in my first mail.

In one terminal I started the listener test, it shows that
it received bytes on ttyS0, tried to write the answer:

$ ./serialtest2 /dev/ttyS0
read: 0x00, written: 0x01
read: 0x01, written: 0x02
read: 0x02, written: 0x03
read: 0x03, written: 0x04
read: 0x04, written: 0x05
read: 0x05, written: 0x06
read: 0x06, written: 0x07
read: 0x07, written: 0x08
read: 0x08, written: 0x09
read: 0x09, written: 0x0a
read: 0x00, written: 0x01
read: 0x01, written: 0x02
read: 0x02, written: 0x03
read: 0x03, written: 0x04
read: 0x04, written: 0x05
read: 0x05, written: 0x06
read: 0x06, written: 0x07
read: 0x07, written: 0x08
read: 0x08, written: 0x09
read: 0x09, written: 0x0a

In another terminal, I started the initiator test twice:

$ ./serialtest1 /dev/usb/ttyUSB0
written: 0x00, read: 0x00           <- sometimes I get one zero byte
written: 0x01, couldn't read
written: 0x02, couldn't read
written: 0x03, couldn't read
written: 0x04, couldn't read
written: 0x05, couldn't read
written: 0x06, couldn't read
written: 0x07, couldn't read
written: 0x08, couldn't read
written: 0x09, couldn't read
$ ./serialtest1 /dev/usb/ttyUSB0
written: 0x00, couldn't read
written: 0x01, couldn't read
written: 0x02, couldn't read
written: 0x03, couldn't read
written: 0x04, couldn't read
written: 0x05, couldn't read
written: 0x06, couldn't read
written: 0x07, couldn't read
written: 0x08, couldn't read
written: 0x09, couldn't read

During the session, the kernel log contains this:

usb.c: USB disconnect on device 00:04.2-2 address 3
pl2303.c: pl2303_shutdown
usbserial.c: PL-2303 converter now disconnected from ttyUSB0
hub.c: new USB device 00:04.2-2, assigned address 4
usbserial.c: PL-2303 converter detected
usbserial.c: PL-2303 converter now attached to ttyUSB0 (or usb/tts/0 for 
devfs)
pl2303.c: pl2303_open -  port 0
pl2303.c: 0xc0:0x1:0x8484:0x0  1 - 0
pl2303.c: 0x40:0x1:0x404:0x0  0
pl2303.c: 0xc0:0x1:0x8484:0x0  1 - 0
pl2303.c: 0xc0:0x1:0x8383:0x0  1 - 0
pl2303.c: 0xc0:0x1:0x8484:0x0  1 - 0
pl2303.c: 0x40:0x1:0x404:0x1  0
pl2303.c: 0xc0:0x1:0x8484:0x0  1 - 0
pl2303.c: 0xc0:0x1:0x8383:0x0  1 - 0
pl2303.c: 0x40:0x1:0x0:0x1  0
pl2303.c: 0x40:0x1:0x1:0xc0  0
pl2303.c: 0x40:0x1:0x2:0x4  0
pl2303.c: pl2303_set_termios -  port 0, initialized = 0
pl2303.c: 0xa1:0x21:0:0  7 - 0 0 0 0 0 0 0
pl2303.c: 0x40:1:0:1  0
pl2303.c: pl2303_set_termios - data bits = 8
pl2303.c: pl2303_set_termios - baud = 9600
pl2303.c: pl2303_set_termios - stop bits = 1
pl2303.c: pl2303_set_termios - parity = none
pl2303.c: 0x21:0x20:0:0  7
pl2303.c: set_control_lines - value = 3, retval = 0
pl2303.c: 0xa1:0x21:0:0  7 - 80 25 0 0 0 0 8
pl2303.c: pl2303_open - submitting read urb
pl2303.c: pl2303_open - submitting interrupt urb
pl2303.c: pl2303_ioctl (0) cmd = 0x5401
pl2303.c: pl2303_ioctl not supported = 0x5401
pl2303.c: pl2303_ioctl (0) cmd = 0x540b
pl2303.c: pl2303_ioctl not supported = 0x540b
pl2303.c: pl2303_ioctl (0) cmd = 0x5402
pl2303.c: pl2303_ioctl not supported = 0x5402
pl2303.c: pl2303_set_termios -  port 0, initialized = 1
pl2303.c: pl2303_read_int_callback - length = 10, data = a1 20 00 00 00 
00 02 00 83 00
pl2303.c: 0xa1:0x21:0:0  7 - 80 25 0 0 0 0 8
pl2303.c: 0x40:1:0:1  0
pl2303.c: pl2303_set_termios - data bits = 8
pl2303.c: pl2303_set_termios - baud = 115200
pl2303.c: pl2303_set_termios - stop bits = 1
pl2303.c: pl2303_set_termios - parity = none
pl2303.c: 0x21:0x20:0:0  7
pl2303.c: set_control_lines - value = 3, retval = 0
pl2303.c: 0xa1:0x21:0:0  7 - 0 c2 1 0 0 0 8
pl2303.c: pl2303_ioctl (0) cmd = 0x5401
pl2303.c: pl2303_ioctl not supported = 0x5401
pl2303.c: pl2303_write - port 0, 1 bytes
pl2303.c: pl2303_write - length = 1, data = 00
pl2303.c: pl2303_write_bulk_callback - port 0
pl2303.c: pl2303_read_bulk_callback - port 0
pl2303.c: pl2303_read_bulk_callback - length = 1, data = 00
pl2303.c: pl2303_write - port 0, 1 bytes
pl2303.c: pl2303_write - length = 1, data = 01
pl2303.c: pl2303_write_bulk_callback - port 0
pl2303.c: pl2303_write - port 0, 1 bytes
pl2303.c: pl2303_write - length = 1, data = 02
pl2303.c: pl2303_write_bulk_callback - port 0
pl2303.c: pl2303_write - port 0, 1 bytes
pl2303.c: pl2303_write - length = 1, data = 03
pl2303.c: pl2303_write_bulk_callback - port 0
pl2303.c: pl2303_write - port 0, 1 bytes
pl2303.c: pl2303_write - length = 1, data = 04
pl2303.c: pl2303_write_bulk_callback - port 0
pl2303.c: pl2303_write - port 0, 1 bytes
pl2303.c: pl2303_write - length = 1, data = 05
pl2303.c: pl2303_write_bulk_callback - port 0
pl2303.c: pl2303_write - port 0, 1 bytes
pl2303.c: pl2303_write - length = 1, data = 06
pl2303.c: pl2303_write_bulk_callback - port 0
pl2303.c: pl2303_write - port 0, 1 bytes
pl2303.c: pl2303_write - length = 1, data = 07
pl2303.c: pl2303_write_bulk_callback - port 0
pl2303.c: pl2303_write - port 0, 1 bytes
pl2303.c: pl2303_write - length = 1, data = 08
pl2303.c: pl2303_write_bulk_callback - port 0
pl2303.c: pl2303_write - port 0, 1 bytes
pl2303.c: pl2303_write - length = 1, data = 09
pl2303.c: pl2303_write_bulk_callback - port 0
pl2303.c: pl2303_ioctl (0) cmd = 0x540b
pl2303.c: pl2303_ioctl not supported = 0x540b
pl2303.c: pl2303_ioctl (0) cmd = 0x5402
pl2303.c: pl2303_ioctl not supported = 0x5402
pl2303.c: pl2303_set_termios -  port 0, initialized = 1
pl2303.c: 0xa1:0x21:0:0  7 - 0 c2 1 0 0 0 8
pl2303.c: 0x40:1:0:1  0
pl2303.c: pl2303_set_termios - data bits = 8
pl2303.c: pl2303_set_termios - baud = 9600
pl2303.c: pl2303_set_termios - stop bits = 1
pl2303.c: pl2303_set_termios - parity = none
pl2303.c: 0x21:0x20:0:0  7
pl2303.c: set_control_lines - value = 3, retval = 0
pl2303.c: 0xa1:0x21:0:0  7 - 80 25 0 0 0 0 8
pl2303.c: pl2303_ioctl (0) cmd = 0x5401
pl2303.c: pl2303_ioctl not supported = 0x5401
pl2303.c: pl2303_close - port 0
pl2303.c: set_control_lines - value = 0, retval = 0
pl2303.c: pl2303_close - shutting down urbs
pl2303.c: pl2303_close - usb_unlink_urb (write_urb) failed with reason: -19
pl2303.c: pl2303_read_bulk_callback - port 0
pl2303.c: pl2303_read_bulk_callback - urb->status = -2
pl2303.c: pl2303_read_bulk_callback - port is closed, exiting.
pl2303.c: pl2303_open -  port 0
pl2303.c: 0xc0:0x1:0x8484:0x0  1 - 0
pl2303.c: 0x40:0x1:0x404:0x0  0
pl2303.c: 0xc0:0x1:0x8484:0x0  1 - 0
pl2303.c: 0xc0:0x1:0x8383:0x0  1 - 0
pl2303.c: 0xc0:0x1:0x8484:0x0  1 - 0
pl2303.c: 0x40:0x1:0x404:0x1  0
pl2303.c: 0xc0:0x1:0x8484:0x0  1 - 0
pl2303.c: 0xc0:0x1:0x8383:0x0  1 - 0
pl2303.c: 0x40:0x1:0x0:0x1  0
pl2303.c: 0x40:0x1:0x1:0xc0  0
pl2303.c: 0x40:0x1:0x2:0x4  0
pl2303.c: pl2303_set_termios -  port 0, initialized = 1
pl2303.c: 0xa1:0x21:0:0  7 - 80 25 0 0 0 0 8
pl2303.c: 0x40:1:0:1  0
pl2303.c: pl2303_set_termios - data bits = 8
pl2303.c: pl2303_set_termios - baud = 9600
pl2303.c: pl2303_set_termios - stop bits = 1
pl2303.c: pl2303_set_termios - parity = none
pl2303.c: 0x21:0x20:0:0  7
pl2303.c: set_control_lines - value = 3, retval = 0
pl2303.c: 0xa1:0x21:0:0  7 - 80 25 0 0 0 0 8
pl2303.c: pl2303_open - submitting read urb
pl2303.c: pl2303_open - submitting interrupt urb
pl2303.c: pl2303_ioctl (0) cmd = 0x5401
pl2303.c: pl2303_ioctl not supported = 0x5401
pl2303.c: pl2303_ioctl (0) cmd = 0x540b
pl2303.c: pl2303_ioctl not supported = 0x540b
pl2303.c: pl2303_ioctl (0) cmd = 0x5402
pl2303.c: pl2303_ioctl not supported = 0x5402
pl2303.c: pl2303_set_termios -  port 0, initialized = 1
pl2303.c: 0xa1:0x21:0:0  7 - 80 25 0 0 0 0 8
pl2303.c: 0x40:1:0:1  0
pl2303.c: pl2303_set_termios - data bits = 8
pl2303.c: pl2303_set_termios - baud = 115200
pl2303.c: pl2303_set_termios - stop bits = 1
pl2303.c: pl2303_set_termios - parity = none
pl2303.c: 0x21:0x20:0:0  7
pl2303.c: set_control_lines - value = 3, retval = 0
pl2303.c: 0xa1:0x21:0:0  7 - 0 c2 1 0 0 0 8
pl2303.c: pl2303_ioctl (0) cmd = 0x5401
pl2303.c: pl2303_ioctl not supported = 0x5401
pl2303.c: pl2303_write - port 0, 1 bytes
pl2303.c: pl2303_write - length = 1, data = 00
pl2303.c: pl2303_write_bulk_callback - port 0
pl2303.c: pl2303_write - port 0, 1 bytes
pl2303.c: pl2303_write - length = 1, data = 01
pl2303.c: pl2303_write_bulk_callback - port 0
pl2303.c: pl2303_write - port 0, 1 bytes
pl2303.c: pl2303_write - length = 1, data = 02
pl2303.c: pl2303_write_bulk_callback - port 0
pl2303.c: pl2303_write - port 0, 1 bytes
pl2303.c: pl2303_write - length = 1, data = 03
pl2303.c: pl2303_write_bulk_callback - port 0
pl2303.c: pl2303_write - port 0, 1 bytes
pl2303.c: pl2303_write - length = 1, data = 04
pl2303.c: pl2303_write_bulk_callback - port 0
pl2303.c: pl2303_write - port 0, 1 bytes
pl2303.c: pl2303_write - length = 1, data = 05
pl2303.c: pl2303_write_bulk_callback - port 0
pl2303.c: pl2303_write - port 0, 1 bytes
pl2303.c: pl2303_write - length = 1, data = 06
pl2303.c: pl2303_write_bulk_callback - port 0
pl2303.c: pl2303_write - port 0, 1 bytes
pl2303.c: pl2303_write - length = 1, data = 07
pl2303.c: pl2303_write_bulk_callback - port 0
pl2303.c: pl2303_write - port 0, 1 bytes
pl2303.c: pl2303_write - length = 1, data = 08
pl2303.c: pl2303_write_bulk_callback - port 0
pl2303.c: pl2303_write - port 0, 1 bytes
pl2303.c: pl2303_write - length = 1, data = 09
pl2303.c: pl2303_write_bulk_callback - port 0
pl2303.c: pl2303_ioctl (0) cmd = 0x540b
pl2303.c: pl2303_ioctl not supported = 0x540b
pl2303.c: pl2303_ioctl (0) cmd = 0x5402
pl2303.c: pl2303_ioctl not supported = 0x5402
pl2303.c: pl2303_set_termios -  port 0, initialized = 1
pl2303.c: 0xa1:0x21:0:0  7 - 0 c2 1 0 0 0 8
pl2303.c: 0x40:1:0:1  0
pl2303.c: pl2303_set_termios - data bits = 8
pl2303.c: pl2303_set_termios - baud = 9600
pl2303.c: pl2303_set_termios - stop bits = 1
pl2303.c: pl2303_set_termios - parity = none
pl2303.c: 0x21:0x20:0:0  7
pl2303.c: set_control_lines - value = 3, retval = 0
pl2303.c: 0xa1:0x21:0:0  7 - 80 25 0 0 0 0 8
pl2303.c: pl2303_ioctl (0) cmd = 0x5401
pl2303.c: pl2303_ioctl not supported = 0x5401
pl2303.c: pl2303_close - port 0
pl2303.c: set_control_lines - value = 0, retval = 0
pl2303.c: pl2303_close - shutting down urbs
pl2303.c: pl2303_close - usb_unlink_urb (write_urb) failed with reason: -19
pl2303.c: pl2303_read_bulk_callback - port 0
pl2303.c: pl2303_read_bulk_callback - urb->status = -2
pl2303.c: pl2303_read_bulk_callback - port is closed, exiting.

I also tried some different baud rates (2400, 19200) besides
the fastest 115200 that was default in the testprograms.

Now what?

Oh, did I mention that the pinout of the cable (that I use to loopback
the USB<->serial cable into the same PC) is

DB9 <-> DB9
1,6 <-> 4
2   <-> 3
3   <-> 2
4   <-> 1,6
5   <-> 5
7   <-> 8
8   <-> 7

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.

