Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129303AbQKBUDt>; Thu, 2 Nov 2000 15:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129377AbQKBUDk>; Thu, 2 Nov 2000 15:03:40 -0500
Received: from pop.gmx.net ([194.221.183.20]:62823 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129303AbQKBUDY>;
	Thu, 2 Nov 2000 15:03:24 -0500
Message-ID: <3A01C6FA.25A90016@gmx.de>
Date: Thu, 02 Nov 2000 20:56:42 +0100
From: Bernd Harries <bha@gmx.de>
Reply-To: bha@gmx.de
Organization: BHA Industries
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: are Generic ioctls a good thing?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

what do you think of ioctls, which are assembled not at compiletime but at
runtime in the form
ioctl(fd,  req(read, size, 'g', msgtype ), &arg);
ioctl(fd,  req(write, size, 'g', msgtype ), &arg);
ioctl(fd,  req(rw, size, 'g', msgtype ), &arg);

The ioctl manpage defines it so:
int ioctl(int d, int request, ...)

I would like some comments on a request I am faced with while writing a device
driver. Because the FW of a card is still in development and the folks in that
department seem to be looking at kernel programming as supernatural, they want
me to write a driver with generic ioctls: 

A set of ioctls shall put and get messages into/from a number of anonymous
buffers in the card which have descriptors/headers. Let's assume they have 32
buffers in each direction and use about 20 out of 100 different message types
over the time. A buffer will be 'bound' to 1 message type at boot time by the
cards firmware and there shall be ioctls that 

1. put a message of type X into the matching buffer or complain 
   if no buffer was bound to Type X
2. get a message of type Y from the matching buffer or complain 
   if no buffer was bound to Type Y

Are there any reasons why this should not work, or be dangerous? The concept
makes it impossible to define the ioctls completely at compile time as I see it.
But I can't see a reason why the concept should not at all work so far. Are
there limitations on the bits in the ioctl's request argument, which I must not
touch at runtime? As I see it, I could e.g. make the lower 7 or 8 bits of
'request' variable and transport the type into the kernel. The size of the arg
data is up to 256 bytes as far as I can see. So that part can also be variable.

In the driver I will have to do some masking and parsing, but nothing really
complicating as it seems.

Are there any reasons, which speek against this concept?

The effect that shall be accomplished with the concept is that the guys want to
be free to define new message types in the FW of the card and write an
application that puts and gets the type without modifying the driver. They are
too frightend to modify or even compile a driver theirselves and don't want to
have to ask (pay) me to do it...  Hmmm... 

There will additionally be some 'normal' ioctls which are defined at compile
time and 2 read and 2 write interfaces per card for mass data. 


 Please CC me in replys, because my subscription to this list is currently still
in (human) process:
> has been forwarded to the owner of the "linux-kernel" list for approval
(I want my MailList-alias mlbha@gmx.de to be subscribed)

Thanks,
-- 
Bernd Harries

bha@gmx.de           http://www.freeyellow.com/members/bharries
bha@nikocity.de       Tel. +49 421 809 7343 priv.  | MSB First!
harries@stn-atlas.de       +49 421 457 3966 offi.  | Linux-m68k
bernd@linux-m68k.org      8.48'21" E  52.48'52" N  | Medusa T40
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
