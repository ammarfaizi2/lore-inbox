Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317908AbSFSPPn>; Wed, 19 Jun 2002 11:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317907AbSFSPPm>; Wed, 19 Jun 2002 11:15:42 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:1435 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S317908AbSFSPPl>; Wed, 19 Jun 2002 11:15:41 -0400
Message-ID: <3D10A017.C22CDD0D@nortelnetworks.com>
Date: Wed, 19 Jun 2002 11:15:35 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: recommended method for hardware to report events to userspace?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm doing some work on a SONET PHY and I was wondering what the recommended
method is for asynchronously reporting events to userspace.

I have some non-critical events (correctable ecc errors, etc) that I poll every
once in a while, but there are some critical events (loss of signal, for
instance) that I want to report immediately.

What is the usual way of doing this?  I see three possibilities: 1) the
userspace app could register its pid with the driver using ioctl() and on a
fault the interrupt handler in the driver could fire off a signal to the
registered pids to alert them that something happened, at which point they do
another ioctl() to find out exactly what it was,  2) use netlink to provide a
socket-based notification of what happened,  3) provide a file descriptor that
becomes readable when an event happens.

What's the Right Thing to do here?


Thanks,
Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
