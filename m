Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264065AbTDWOlf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbTDWOlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:41:35 -0400
Received: from air-2.osdl.org ([65.172.181.6]:51100 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264065AbTDWOla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:41:30 -0400
Date: Wed, 23 Apr 2003 07:51:58 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: root@chaos.analogic.com
Cc: icedank@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: Stored data missed in setup.S
Message-Id: <20030423075158.510e25d2.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0304231028270.23276@chaos>
References: <200304231617.23243.icedank@gmx.net>
	<Pine.LNX.4.53.0304230925150.23037@chaos>
	<200304231639.57148.icedank@gmx.net>
	<Pine.LNX.4.53.0304231028270.23276@chaos>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003 10:36:55 -0400 (EDT) "Richard B. Johnson" <root@chaos.analogic.com> wrote:

| On Wed, 23 Apr 2003, Andrew Kirilenko wrote:
| 
| [SNIPPED...]
| 
| > OK. And now code looks like:
| > -->
| > start_of_setup: # line 160
| > 	# bla bla bla - some checking code
| >         movb    $1, %al
| >         movb    %al, (0x100)
| > ....
| > ....
| > 	cmpb    $1, (0x100)
| > 	je bail820 # and it DON'T jump here
| > <--
| >
| 
| > I'm sure, I'm doing something wrong. But what???
| 
| The only possibiity is that the code you just showed is not
| being executed. Absolute location 0x100 is not being overwritten
| by some timer-tick (normally) so whatever you write there should
| remain. You just put a byte of 1 in that location and then
| you compared against a byte of 1. If the CPU was broken, you
| wouldn't have even loaded your code.

Could possibly be that DS (seg register) is altered between
the store and the comparison...

| It is quite likely that the IP is being diverted around your code
| by some previous code.
| 
| FYI, you can check the progress of your code by 'printing' on
| the screen. Set up ES to point to the screen segment, and write
| letters there:
| 
| 	movw	$0xb800, %ax
| 	movb	%ax, %es
| 	movb	$'A', %es:(0)
| 
| This 'prints' an 'A' at the first location on the screen.


--
~Randy
