Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265221AbUAPCwu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 21:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUAPCwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 21:52:50 -0500
Received: from mta10.srv.hcvlny.cv.net ([167.206.5.85]:37830 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S265221AbUAPCwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 21:52:44 -0500
Date: Thu, 15 Jan 2004 21:52:43 -0500
From: Brett Gmoser <aftli@optonline.net>
Subject: Raw I/O Problems with inb()
To: linux-kernel@vger.kernel.org
Message-id: <20040115215243.39fcb0fd.aftli@optonline.net>
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody.

I apologize if this is off topic, but I have seen relevant information posted to this list, even though this isn't actually a kernel programming problem.  And believe me, I have searched everywhere else for a solution to this problem.

To give some short background information, I am programming the Linux client for a project that basically counts a users keystrokes, and sends the amount to a server which displays the count for all the world to see.  Teams and individuals compete from around the world, and we are approaching 5000 members.

At any rate, the application is written in C/C++.  I am using iopl() for permissions management, and inb() for reading raw data directly from the PS/2 keyboard to test if a key has been pressed.  All of this works great, and the program is complete, except for one problem.

It seems that on Athlon XP systems using PS/2 mice, inb(0x64) always says there is data waiting from the keyboard, when it is in fact mouse data.  I assume that different architecture on AMD systems is the cause of the problem, but is there a solution?  There must be.  Here is a snippet of the code I am using currently.  I apologize for the sloppiness of it - it's been modified about 30 times with 30 different solutions to the problem, all of which did not seem to fix it.  Commented out are solutions that I have tried and have not worked.

#define KEYBOARD_PORT 0x60
#define KEYBOARD_STATUS_PORT 0x64

bool keycounter::count(/*wplog* l*/) { // some very simple code to see if a key is being pressed or not.
  const unsigned char kbd_read_mask = 0x01;
  unsigned char status = inb_p(KEYBOARD_STATUS_PORT);
  /* unsigned char status = inb(KEYBOARD_STATUS_PORT);

  /* mouse data? */
//  if (status == 20 && ((status & kbd_read_mask) != 0x01) || (status & 0x21)) { fflush(0); return false; }
//  if(status & kbd_read_mask & 0x20) { fflush(0); return false; }
//  if(!(status & kbd_read_mask & 0x01)) { fflush(0); return false; }
//  if(!((inb(0x379) & 0x20) == 0x20)) { fflush(0); return false; }

  if(status!=20) { fflush(0); return false; }
  unsigned char c = inb(KEYBOARD_PORT);
  if(status==20 && c < TABLE_SIZE) {
    if(c==lastc) {
      fflush(0);
      return false;
    }
    lastc=c;
    fflush(0);
    return true;
  }
  else {   // key has been lifted
    lastc=0;
    fflush(0);
    return false;
  }
}

Thanks in advance for any insight you all may be able to give me


-- 
Brett Gmoser
aftli@optonline.net
