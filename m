Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129479AbRBGQe4>; Wed, 7 Feb 2001 11:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129538AbRBGQeh>; Wed, 7 Feb 2001 11:34:37 -0500
Received: from web114.mail.yahoo.com ([205.180.60.86]:1810 "HELO
	web114.yahoomail.com") by vger.kernel.org with SMTP
	id <S129479AbRBGQee>; Wed, 7 Feb 2001 11:34:34 -0500
Message-ID: <20010207163432.25823.qmail@web114.yahoomail.com>
Date: Wed, 7 Feb 2001 08:34:32 -0800 (PST)
From: Paul Powell <moloch16@yahoo.com>
Subject: Ioctl CDROMRESET has no effect
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm attempting to reset a CDROM using the CDROMRESET
ioctl.  The reset command only seems to reset the
device if the device is not mounted.  If the device is
mounted, the reset command seems to have no effect.

With the device unmounted, sending the reset command
causes the drive to become active and I see the
activity light light up.  With the device mounted, the
activity light does nothing.  I also can't open the
CD-ROM drive using the eject button after resetting a
mounted CD.

It seems the reset command should work even if the OS
thinks the device is mounted for error recovery.

Here is my test program:

#include <stdio.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <linux/cdrom.h>

int main(int argc, char* argv[])
{
   int fd, result;

   fd = open("/dev/hda", O_RDONLY|O_NONBLOCK);
   if (fd < 0)
   {
      perror("open");
      return fd;
   }   
   
   result = ioctl(fd, CDROMRESET, 1);
   if (result < 0)
      perror("ioctl");
  
   close(fd);
   return 0;
}

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - Buy the things you want at great prices.
http://auctions.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
