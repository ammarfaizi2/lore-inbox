Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269542AbVBESK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269542AbVBESK1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 13:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269646AbVBESK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 13:10:27 -0500
Received: from pop.gmx.de ([213.165.64.20]:58034 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270702AbVBESHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 13:07:37 -0500
X-Authenticated: #420190
Message-ID: <42050C49.9050300@gmx.net>
Date: Sat, 05 Feb 2005 19:11:21 +0100
From: Marko Macek <Marko.Macek@gmx.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Otto Wyss <otto.wyss@orpatec.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: Why is debugging under Linux such a pain
References: <4204EDB9.E80BB61C@orpatec.ch>
In-Reply-To: <4204EDB9.E80BB61C@orpatec.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otto Wyss wrote:
 > No
> mouse or keyboard input was possible. I was completely stuck, IMO
> something _never_ should happen. Who's to blame for this situation:
> wxWidgets, GDB, GCC/G++, X or the Linux kernel? Or any combination?

This is by design in X. XGrabKeyboard and XGrabPointer are usually to 
blame. Sometimes XGrabServer (not that a normal app should ever need to 
call it). Often things are made worse by a toolkit that doesn't flush
Ungrab operations immediately.

Some toolkits (Qt) have a --nograb option and sometimes activate it 
automatically when being debugged.

A workaround:

- check out X config setting AllowDeactivateGrabs, enable it (see also 
AllowClosedownGrabs)

- Ctrl+Alt+Numpad-Divide will then allow you to ungrab the keyboard and 
mouse.

Warning: this might break your screen saver display lock function due to 
an incorrect design of the lock mechanism (it uses the same "X display" 
as your login session).

It would be nice if display lock programs used a separate X display 
(some kind of "virtual" display support might be nice to have, mainly 
for performance).

This would also be good for running games. Currently it's a a major 
problem when a game freezes and there is no way to get back to the 
desktop without killing X.

It would of course need to interact with current console switching 
mechanism.


	Mark
