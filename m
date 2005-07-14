Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262969AbVGNKI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbVGNKI0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 06:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262995AbVGNKI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 06:08:26 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:64730 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S262969AbVGNKGd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 06:06:33 -0400
Message-ID: <42D63AD0.6060609@aitel.hist.no>
Date: Thu, 14 Jul 2005 12:13:36 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vinay Venkataraghavan <raghavanvinay@yahoo.com>
CC: linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Open source firewalls
References: <20050713163424.35416.qmail@web32110.mail.mud.yahoo.com>
In-Reply-To: <20050713163424.35416.qmail@web32110.mail.mud.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vinay Venkataraghavan wrote:

>I know how to implement buffer overflow attacks. But
>how would an intrusion detection system detect a
>buffer overflow attack. 
>
Buffer overflow attacks vary, but have one thing in common.  The 
overflow string is much longer than what's usual for the app/protocol in 
question.  It may also contain illegal characters, but be careful - 
non-english users use plenty of valid non-ascii characters in filenames,
passwords and so on.

The way to do this is to implement a transparent proxy module for every 
protocol you want to do overflow prevention for.  Collect the strings
transmitted, pass them on after validating them.  Or reset the 
connection when one gets "too long".  For example, you may want to
limit POP usernames to whatever the maximum username length is
on your system.  But make such things configurable, others may
want longer usernames than you.

>My question is at the layer
>that the intrusion detection system operates, how will
>it know that a particular string for exmaple is liable
>to overflow a vulnerable buffer. 
>
>  
>
It can't know of course, but it can suspect that 1000-character
usernames, passwords or filenames is foul play and reset the
connection.  Or 10k URL's . . .

Helge Hafting

