Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287111AbSBMPma>; Wed, 13 Feb 2002 10:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286893AbSBMPmV>; Wed, 13 Feb 2002 10:42:21 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:51354 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S287003AbSBMPmD>; Wed, 13 Feb 2002 10:42:03 -0500
Message-ID: <3C6A8B04.D7141173@nortelnetworks.com>
Date: Wed, 13 Feb 2002 10:49:24 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sean Hunter <sean@dev.sportingbet.com>
Cc: Ken Brownfield <brownfld@irridia.com>,
        Tim Schmielau <tim@physik3.uni-rostock.de>,
        "Proescholdt, timo" <Timo.Proescholdt@brk-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: randomness - compaq smart array driver
In-Reply-To: <410B51F29EA8D3118EE400508B44AE2B3C6FB3@RZ_NT_MAIL> <Pine.LNX.4.33.0202111754560.5685-100000@gans.physik3.uni-rostock.de> <20020213071445.A20717@asooo.flowerfire.com> <20020213150850.H26054@dev.sportingbet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Hunter wrote:

> Randomness from network packet timings can be gathered entirely in userspace by
> using a packet socket.  I am busy writing an "additional entropy daemon" to
> gather entropy from this and other sources[1], clean it up, test its fitness,
> estimate its information content, and feed it into the random pool.  This job
> is (IMO) better done in userspace because there we can run fitness tests on the
> stream more easily because we have floating point etc.

However, if you're doing that, then you incur the cost of copying every incoming
packet and sending it up to userspace.  For a busy server, this could be
unacceptable.

Also, how are you timing the incoming packets?  In kernel space we can get
accuracy of a few tens of nanoseconds for timing the interrupts--how do you
approach this in userspace when your userspace process can be scheduled out?  

Even if we timestamp the packets with microsecond accuracy, we are still a few
orders of magnitude short of the accuracy attainable in the kernel, with
correspondingly less entropy that can be extracted.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
