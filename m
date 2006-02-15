Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946061AbWBORnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946061AbWBORnT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946062AbWBORnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:43:19 -0500
Received: from [195.23.16.24] ([195.23.16.24]:32141 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1946061AbWBORnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:43:18 -0500
Message-ID: <43F36833.9060100@grupopie.com>
Date: Wed, 15 Feb 2006 17:43:15 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Trap flag handling change in 2.6.10-bk5 broke Kylix debugger
References: <43F23BB4.8070703@grupopie.com> <Pine.LNX.4.64.0602141243020.3691@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602141243020.3691@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> [...]
> Hmm. You could try variations on the appended patch. Try changing the 
> "#if 0" to "#if 1" in various combinations, to see which one Kylix seems 
> to care about.

Sorry about the delay, but being Valentine's day and all changes our 
priorities a bit ;)

Anyway, a friend of mine tested the patch and reported that the 
combinations 000 (all comented out), 001 (the first 2 commented out, but 
the last one not) and 110 (...) still hung the debugger. I suppose these 
were all the combinations he tested.

Tonight I'll have more time to test this again and we can probably have 
a more interactive debug session.

In the mean time, just a few more data points. The debugger seems to use 
LinuxThreads and only works with LD_ASSUME_KERNEL=2.4.1, even on a 
2.6.10 kernel.

If we don't set this, the debugger hangs in a different way. Apparently 
it is waiting on a signal, it has a signal pending that is one of the 
first real-time signals (the ones used by LinuxThreads), but its signal 
mask is blocking it.

Anyway, I thought of trying to attach a strace to the debugger tonight 
to try to see exactly what the debugger is doing. Is this supposed to 
work? Or trying to trace a process that is itself tracing another 
process a no-no and can give unreliable results?

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?
