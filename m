Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266381AbUBGGEU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 01:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266469AbUBGGET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 01:04:19 -0500
Received: from data.idl.com.au ([203.32.82.9]:9924 "EHLO smtp.idl.net.au")
	by vger.kernel.org with ESMTP id S266381AbUBGGER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 01:04:17 -0500
From: Athol Mullen <athol_SPIT_SPAM@idl.net.au>
Organization: Mullen Automotive Engineering
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [RFC] IDE 80-core cable detect - chipset-specific code to over-ride eighty_ninty_three()
Date: Sat, 7 Feb 2004 17:00:18 +1100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402071658.43992.athol_SPIT_SPAM@OUTidl.net.au>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Don't CC.  I read lkml via linux.kernel newsgroup.)

Specific to parallel IDE with UDMA.  Relates to code that is the same from 
2.4.22 to 2.6.1.

After looking through the Intel specs for the ICH5, I discovered that they 
specify that the BIOS is supposed to initialise bit flags for the presence of 
80-core ribbon for each drive.  According to Intel, the OS is supposed to 
rely upon those flags in preference to the word-93 bit.  This appears to 
cover all ICH chipsets capable of UDMA modes that require 80-core cabling, 
and works on both the ICH4 and ICH5 I have here.

I have a drive that fails the word93 bit test with a known 80-core cable. The 
piix driver sets the drive up to UDMA5, but dmesg reports UDMA(33) because 
eighty_ninty_three() returns 0.  If this had really been a 40-core cable, I'm 
not sure what would happen.

Proposal:

I'm not certain exactly how this would be implemented, but I'd like to see 
eighty_ninty_three() check for chipset-specific detection code, and use the 
existing word93 validation otherwise.

I have written and tested code for the intel ICH chipsets, but can't post a 
patch until I know where to stick it.  :-)

Related:

eighty_ninty_three() should only be called if there is a possibility of using 
a mode where it matters.  I intend to submit some patches that rearrange the 
logic to avoid calling it if the best mode doesn't need it.

-- 
Athol
<http://cust.idl.com.au/athol>
Linux Registered User # 254000
I'm a Libran Engineer. I don't argue, I discuss.

-- 
Regards,

Athol
-- 
Athol Mullen
Mullen Automotive Engineering
athol@idl.net.au
24 Newcastle St CARDIFF  NSW 2285
Ph/Fax (02) 4956 8030, Mob. 0414 685537
---
Confidentiality Statement:
Information in this message is provided to the intended recipient in 
confidence and is provided conditional upon its not being made available to 
any other party without the express permission of the author.  Release of any 
part of this message under freedom of information or similar legislation is 
specifically not permitted and if such release is a condition of acceptance, 
the recipient must not accept this message.

