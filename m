Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262880AbVAFPt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbVAFPt5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbVAFPt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:49:57 -0500
Received: from inetc.connecttech.com ([64.7.140.42]:62218 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id S262880AbVAFPtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:49:43 -0500
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: <Tim_T_Murphy@Dell.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [2.6.10-bk8] [SERIAL] dropping chars when > 512
Date: Thu, 6 Jan 2005 10:49:43 -0500
Organization: Connect Tech Inc.
Message-ID: <00e301c4f407$56e1bf00$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <4B0A1C17AA88F94289B0704CFABEF1AB0B4D2B@ausx2kmps304.aus.amer.dell.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim_T_Murphy@Dell.com
> examining the corrupt message contents, a group of bytes is 
> missing exactly at offset 512 in the message buffer.  
> Additional message bytes follow the gap, but the receiver's 
> checksum doesn't match the sender's, so the whole message is 
> dropped by the app.
> 
> I enabled debugging in 8250.c and serial_core.c.  Booting the 
> 2.6 kernel, the log shows:
> 
[snip]
> Jan  5 12:08:16 racrhel4 last message repeated 6 times
> Jan  5 12:08:16 racrhel4 kernel: 
> serial8250_interrupt(169)...status = 61...end.
> Jan  5 12:08:16 racrhel4 kernel: 
> serial8250_interrupt(169)...status = 60...THRE...end.
> Jan  5 12:08:16 racrhel4 last message repeated 3 times
> Jan  5 12:08:17 racrhel4 kernel: 
> serial8250_interrupt(169)...status = 61...end.
> Jan  5 12:08:17 racrhel4 kernel: 
> serial8250_interrupt(169)...status = 61...end.
> Jan  5 12:08:17 racrhel4 kernel: 
> serial8250_interrupt(169)...status = 61...THRE...end.
> Jan  5 12:08:17 racrhel4 kernel: 
> serial8250_interrupt(169)...status = 1...THRE...end.
> Jan  5 12:08:17 racrhel4 kernel: 

Unless this is a typo, I think you'll find that status = 1 means the
FIFOs have been turned off. Which would flush any data in the FIFOs.
Which would explain the missing data.

..Stu

