Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154365-2781>; Fri, 8 Jan 1999 08:05:24 -0500
Received: from email.gcom.com ([199.97.226.1]:22783 "EHLO gcom.com" ident: "root") by vger.rutgers.edu with ESMTP id <155945-13684>; Thu, 7 Jan 1999 15:30:03 -0500
Message-ID: <36953BDB.D4CAF25D@gcom.com>
Date: Thu, 07 Jan 1999 16:57:31 -0600
From: David Grothe <dave@gcom.com>
Reply-To: dave@gcom.com
Organization: Gcom, Inc
X-Mailer: Mozilla 4.06 [en] (Win98; U)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.rutgers.edu>
Subject: poll.h
References: <35CF47D2.8F0CBAA5@gcom.com> <19980811025733.E639@uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Hello:

I am surveying all the poll.h files that I can find to see if there is a
set
of values for the poll bits that will be mutually compatible.  I am
focusing on the I386 values for Linux.

Linux STREAMS (LiS) has its own poll.h that was created before Linux had
a poll.h, so I have included its values as well.  At the present moment
the LiS poll.h includes linux/poll.h for kernel versions 2.1 and 2.2,
thus deferring to whatever is defined for the kernel.  I have no problem
with changing the LiS values.

However, the kernel file asm-i386/poll.h contains the following comment
and definitions for some of the bits:

/* The rest seem to be more-or-less nonstandard. Check them! */
#define POLLRDNORM      0x0040
#define POLLRDBAND      0x0080
#define POLLWRNORM      0x0100
#define POLLWRBAND      0x0200
#define POLLMSG         0x0400

Well, I just checked them.  The results are summarized in the following
table.

In the table, "N/S" means "Not Specified" by that system.

Conflicts are noted with a "*".  Where conflicts occur with other
Unix systems, such as Solaris or UnixWare 7, I marked only the Linux/LiS
files, accepting the Unix values as authoritative.

                        UnxWre7                 Linux
                          I86    Sparc          2.2.0pre4
Variable        LiS     Solaris Solaris SCO     I386
POLLIN          0x0001  0x0001  0x0001  0x0001  0x0001 
POLLPRI         0x0002  0x0002  0x0002  0x0002  0x0002 
POLLOUT         0x0004  0x0004  0x0004  0x0004  0x0004 
POLLERR         0x0008  0x0008  0x0008  0x0008  0x0008 
POLLWRNORM      0x0004  0x0004  0x0004  0x0004  0x0100*
POLLHUP         0x0010  0x0010  0x0010  0x0010  0x0010 
POLLNVAL        0x0020  0x0020  0x0020  0x0020  0x0020 
POLLRDNORM      0x0040  0x0040  0x0040  0x0040  0x0040 
POLLNORM        0x0040  0x0040  0x0040  N/S     N/S    
POLLRDBAND      0x0080  0x0080  0x0080  0x0080  0x0080 
POLLWRBAND      0x0100  0x0100  0x0100  0x0100  0x0200*
POLLMSG         0x0200* N/S     N/S     N/S     0x0400* 
POLLRDDATA      N/S     N/S     0x0200  N/S     N/S    
POLLNOERR       N/S     N/S     0x0400  N/S     N/S    

Note that the values that the comment wants to be checked are in
conflict with all the Unix versions surveyed.  It would make sense to
change POLLWRNORM to 0x0004 and POLLWRBAND to 0x0100.  The value for
POLLMSG could be left at 0x0400 or changed to 0x0200 to use the "next
available value".

Notice also that the Unix definitions explicitly set POLLWRNORM to the
same value as POLLOUT.  This appears to be intentional as they define
these values in the following way:

#define POLLWRNORM      POLLOUT

I notice that quite a few drivers use POLLWRNORM.  This could pose a
problem.

What do you all think of the idea of changing these values at this point
in time before 2.2 gets set in concrete?

Thanks for your time,
Dave

-- Dave

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
