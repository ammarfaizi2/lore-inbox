Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264062AbTDWOiv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264063AbTDWOiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:38:51 -0400
Received: from imap.gmx.net ([213.165.65.60]:1670 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264062AbTDWOiu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:38:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Kirilenko <icedank@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Stored data missed in setup.S
Date: Wed, 23 Apr 2003 17:50:50 +0300
User-Agent: KMail/1.4.3
References: <200304231617.23243.icedank@gmx.net> <200304231639.57148.icedank@gmx.net> <Pine.LNX.4.53.0304231028270.23276@chaos>
In-Reply-To: <Pine.LNX.4.53.0304231028270.23276@chaos>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304231750.50553.icedank@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
>
> [SNIPPED...]
>
> > OK. And now code looks like:
> > -->
> > start_of_setup: # line 160
> > 	# bla bla bla - some checking code
> >         movb    $1, %al
> >         movb    %al, (0x100)
> > ....
> > ....
> > 	cmpb    $1, (0x100)
> > 	je bail820 # and it DON'T jump here
> > <--
> >
> >
> > I'm sure, I'm doing something wrong. But what???
>
> The only possibiity is that the code you just showed is not
> being executed. Absolute location 0x100 is not being overwritten
> by some timer-tick (normally) so whatever you write there should
> remain. You just put a byte of 1 in that location and then
> you compared against a byte of 1. If the CPU was broken, you
> wouldn't have even loaded your code.
>
> It is quite likely that the IP is being diverted around your code
> by some previous code.
>
> FYI, you can check the progress of your code by 'printing' on
> the screen. Set up ES to point to the screen segment, and write
> letters there:
>
> 	movw	$0xb800, %ax
> 	movb	%ax, %es
> 	movb	$'A', %es:(0)
>
> This 'prints' an 'A' at the first location on the screen.

Ha! I don't have video adapter not keyboard on that PC :)
And, when I change je to jmp it works perfectly.


Best regards,
Andrew.
