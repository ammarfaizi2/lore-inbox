Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315993AbSFETHS>; Wed, 5 Jun 2002 15:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316047AbSFETHR>; Wed, 5 Jun 2002 15:07:17 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:14330 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S315993AbSFETHQ>; Wed, 5 Jun 2002 15:07:16 -0400
Message-ID: <3CFE615D.ECBCCF91@nortelnetworks.com>
Date: Wed, 05 Jun 2002 15:07:09 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: want to add per-socket stats, what is best way to extract data?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm considering adding per-socket statistics, starting with number of skbuffs
received and number of skbuffs dropped due to no memory.

The actual accounting is fairly straightforward (just add entries to struct sock
and increment as appropriate in sock_queue_rcv_skb() and sock_queue_err_skb()),
but I'm trying to figure out the best way to make the stats available.

I had considered two possibilities, and it may make sense to use both.

The first would be to expand sock_ioctl() to first check for generic socket
commands before calling the protocol specific ioctl() routines.  This allows for
easy usage from within userspace binaries.  The second would be to have socket
statistics shown under /proc/<pid>/fd/<fd number>.  This would allow for easy
script/human access.

Does anyone have any comments about either of these, or about the desirability
of this in general?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
