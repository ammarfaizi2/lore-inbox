Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281276AbRKESol>; Mon, 5 Nov 2001 13:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281278AbRKESob>; Mon, 5 Nov 2001 13:44:31 -0500
Received: from air-1.osdl.org ([65.201.151.5]:6 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S281276AbRKESo1>;
	Mon, 5 Nov 2001 13:44:27 -0500
Message-ID: <3BE6DC56.5A0984A4@osdl.org>
Date: Mon, 05 Nov 2001 10:37:10 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederman@lnxi.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.14-pre8 Alt-SysRq-[TM] failure during lockup...
In-Reply-To: <m3wv15n5c9.fsf@DLT.linuxnetworx.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> Summary:  I triggered a condition in 2.4.14-pre8 where SysRq triggered
> but would not print reports.  I managed to unstick the condition but
> had played to much to determine the root cause.  My guess is that
> somehow my default loglevel was messed up.  Full information is
> provided just case I did not muddy the waters too much.

Do you know what the console loglevel was when you tried
to use Alt-SysRq-M (show_mem) or Alt-SysRq-T (show tasks ==
show_state)?  (first value listed in /proc/sys/kernel/printk file)

show_mem() and show_state() don't modify the current value of
console_loglevel; they depend on the sysrq handler to do that.
That value could be too low/small.

E.g., if console_loglevel is 4, show_mem and show_state don't
show me anything on the console either, but they are added
to the log file.

[rubout]

> I then tried playing with sysrq and this is where I got worried.
> Alt-SysRq-Space gave the menu as normal.
> Alt-SysRq-M (showMem) printed just: "SysRq: Show Memory"
> Alt-SysRq-T (showTasks) printed just: "Sysrq: Show State"
> 
> Which is extremely strange the reports which should be at a higher
> loglevel were not displayed.
> 
> Then I typoed and pressed. Alt-SysRq-E (tErm) and I started getting the
> reports back.

Aye, sysrq_handle_term sets console_loglevel to 8 and leaves it there.

[rubout]

~Randy
