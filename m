Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292415AbSCDPEA>; Mon, 4 Mar 2002 10:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292410AbSCDPDv>; Mon, 4 Mar 2002 10:03:51 -0500
Received: from host194.steeleye.com ([216.33.1.194]:23307 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S292409AbSCDPDi>; Mon, 4 Mar 2002 10:03:38 -0500
Message-Id: <200203041503.g24F3WU01722@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Chris Mason <mason@suse.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3) 
In-Reply-To: Message from Daniel Phillips <phillips@bonn-fries.net> 
   of "Mon, 04 Mar 2002 06:05:29 +0100." <E16hkfB-0000Zp-00@starship.berlin> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Mar 2002 09:03:31 -0600
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

phillips@bonn-fries.net said:
> But chances are, almost all the IOs ahead of the journal commit belong
> to your same filesystem anyway, so you may be worrying too much about
> possibly waiting for something on another partition. 

My impression is that most modern JFS can work on multiple transactions 
simultaneously.  All you really care about, I believe, is I/O ordering within 
the transaction.  However, separate transactions have no I/O ordering 
requirements with respect to each other (unless they actually overlap).  Using 
ordered tags imposes a global ordering, not just a local transaction ordering, 
so they may not be the most appropriate way to ensure the ordering of writes 
within a single transaction.

I'm not really a JFS expert, so perhaps those who actually develop these 
filesystems could comment?

James


