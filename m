Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264875AbUFMHjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264875AbUFMHjx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 03:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265015AbUFMHjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 03:39:53 -0400
Received: from web90101.mail.scd.yahoo.com ([66.218.94.72]:65379 "HELO
	web90101.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S264875AbUFMHjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 03:39:51 -0400
Message-ID: <20040613073950.21346.qmail@web90101.mail.scd.yahoo.com>
Date: Sun, 13 Jun 2004 00:39:50 -0700 (PDT)
From: Tisheng Chen <tishengchen@yahoo.com>
Subject: Solution to the "1802: Unauthorized network card" problem in recent thinkpad systems
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In recent IBM thinkpad systems, there is a limit to
allowed MiniPCI wireless cards. When an unauthorized
card is plugged in, the system doesn't boot and
halt with an error message like:

ERROR
1802: Unauthorized network card is plugged in
Power off and remove the miniPCI network card.

I met this 1802 error problem several months ago, and
since then my wifi card was used in a very clumsy and
inconvenient way. I used to boot to LILO menu or
Windows system first, then suspend and plug
in the card. After that, when the system is awake, the
card is working.

Recently, I learned two solutions to attack this
problem. One is to crack the BIOS by modifying the
PCI_ID list of allowed cards in the BIOS, as
suggested by Paul Sladen and Matthew Garrett.
(Reference:
http://www.paul.sladen.org/thinkpad-r31/wifi-card-pci-ids.html)

The other way is unbelievably simple. There is a byte
in CMOS which controls whether an "unauthorized" card
is allowed or not. That's 0x6a, actually only
the bit 0x80. The program to unlock the authorization
mechanism is like (asm):

MOV     DX,0070
MOV     AL,6A
OUT     DX,AL
MOV     DX,0071
IN      AL,DX
OR      AL,80
OUT     DX,AL
MOV     AX,4C00
INT     21

The program can be downloaded from:
  http://jcnp.pku.edu.cn/~shadow/1802/no-1802.com
To use this program, you need to boot to DOS.

The CMOS solution is safe, but I'm not sure that it
works for all recent thinkpads and all cards. The BIOS
crack sure does, however it is difficult
and dangerous.

Sincerely,
Tisheng



	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
