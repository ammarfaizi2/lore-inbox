Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262315AbRE1V4f>; Mon, 28 May 2001 17:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263171AbRE1V4Z>; Mon, 28 May 2001 17:56:25 -0400
Received: from ppp21-net1-idf2-bas1.isdnet.net ([195.154.50.21]:28691 "EHLO
	LAP") by vger.kernel.org with ESMTP id <S262315AbRE1V4L>;
	Mon, 28 May 2001 17:56:11 -0400
Message-ID: <003601c0e7bf$41953080$0101a8c0@LAP>
From: "Vadim Lebedev" <vlebedev@aplio.fr>
To: <linux-kernel@vger.kernel.org>
Subject: Potenitial security hole in the kernel
Date: Mon, 28 May 2001 23:43:38 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-OriginalArrivalTime: 28 May 2001 21:43:39.0144 (UTC) FILETIME=[41953080:01C0E7BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Please correct me if i'm wrong but it seems to me that i've stumbled on
really BIG security hole in the signal handling code.
The problem IMO is that the signal handling code stores a processor context
on the user-mode stack frame which is active while
the signal handler is running. Then sys_sigreturn restores back the context
from user mode stack...
Suppose the signal handler modifies this context frame for example by
storing into the PC slot address of the panic routine
then when handler will exit  panic will be called with obvious results.


Please CC your comments to me directly as i'm not subscibed to this list

Vadim Lebedev

