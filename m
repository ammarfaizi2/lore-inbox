Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261728AbSJZATv>; Fri, 25 Oct 2002 20:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261729AbSJZATu>; Fri, 25 Oct 2002 20:19:50 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:3789 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261728AbSJZATt>; Fri, 25 Oct 2002 20:19:49 -0400
Message-ID: <3DB9DA64.E48C8C5B@us.ibm.com>
Date: Fri, 25 Oct 2002 18:57:24 -0500
From: Jon Grimm <jgrimm2@us.ibm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.44 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: 2.5.44: Still has KVM + Mouse issues
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	I see that Thomas Molina 2.5 problem list no longer carries a KVM and
mouse 
issue where it previously had.  

	If a fix is available I'd love to test it out as I still see strange
behavior 
with an Intellimouse and my MasterView CS-104 KVM switch (yep its
old).   

	With a few trusty printks, it looks like after I switch away & back 
into 2.5.44, the mouse is now sending 3 byte packets instead of the 4 it 
previously was.  

	As you can imagine this causes all sorts of havok as the packets are 
interpretted completely wrong from there on out.  If there is enough
delay between 
events, the synchonization logic kicks in and throws the packet out,
since 
it thinks the 4th byte is old (where it is really the first byte of the
next 
3-byte packet).   This generates those pesky "psmouse.c: Lost
synchronization "..  
However, much of the time an incorrect 4-byte frame gets interpretted
and 
the X going totally haywire.    

BTW, serio_rescan() gets the mouse back into a happy 4-byte generating 
state.     

Best Regards,
Jon Grimm
