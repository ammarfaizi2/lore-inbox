Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292391AbSCDOsk>; Mon, 4 Mar 2002 09:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292393AbSCDOsb>; Mon, 4 Mar 2002 09:48:31 -0500
Received: from host194.steeleye.com ([216.33.1.194]:11787 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S292391AbSCDOsS>; Mon, 4 Mar 2002 09:48:18 -0500
Message-Id: <200203041448.g24EmGr01578@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Daniel Phillips <phillips@bonn-fries.net>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3) 
In-Reply-To: Message from Daniel Phillips <phillips@bonn-fries.net> 
   of "Sun, 03 Mar 2002 23:11:44 +0100." <E16heCm-0000Q5-00@starship.berlin> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Mar 2002 08:48:16 -0600
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

phillips@bonn-fries.net said:
> I've been following the thread, I hope I haven't missed anything
> fundamental. A better long term solution is to have ordered tags work
> as designed.  It's  not broken by design is it, just implementation? 

There is actually one hole in the design:  A scsi device may accept a command 
with an ordered tag, disconnect and at a later time reconnect and return a 
QUEUE FULL status indicating that the tag must be retried.  In the time 
between the disconnect and reconnect, the standard doesn't require that no 
other tags be accepted, so if the local flow control conditions abate, the 
device is allowed to accept and execute a tag sent down in between the 
disconnect and reconnect.

I think this would introduce a very minor deviation where one tag could 
overtake another, but we may still get a useable implementation even with this.

James


