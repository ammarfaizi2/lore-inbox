Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268591AbUJKBY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268591AbUJKBY4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 21:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268594AbUJKBY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 21:24:56 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:22965 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S268591AbUJKBYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 21:24:54 -0400
Subject: Producing nice text output while suspending without messing the
	logs.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain
Message-Id: <1097457890.3519.30.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 11 Oct 2004 11:24:51 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

First, apologies to those CC'd if they don't think this is relevant to
them - I'm guessing who to CC).

Suspend2 can produce potentially produce quite a lot of output, not all
of which you want to see in your logs. (Compare Pavel's ^Hs from the
spinning bar). To get around this, I used to use vt_console_print to
output the stuff that shouldn't be logged. Some people, however (don't
remember who now), said I should be opening /dev/console and using that
instead. I made the switch and it didn't caused any problems until the
other day, when one user had /dev/console open while trying to suspend.
When suspend tried to open /dev/console as well, it hung, of course.
This makes me want to raise the issue again.

I guess the problem is really that suspend is a bit of a combination of
kernel and user space: all of the main work that it does can't be done
in userspace, but we (well some people at least!) want Linux to look
good while it does it's suspend to disk and resuming. (And we don't want
the logs filled with lots of junk in the process). I realise that some
people don't care what their screen and logs look like, so long as the
suspend & resume work. That's fine, but I want to cater for those who do
care as well, and think that since this will be a very visible part of
the kernel, it ought to look good (think ignorant desktop user). To that
end, I'm going to ignore anyone who simply wants to argue that this
stuff doesn't belong in the kernel.

Having said all of that, I want to raise the issue again: Is it really
necessary for suspend to use /dev/console to display output that
shouldn't be logged? Could the code use the vt_console_print, gotoxy and
blank/unblank_console functions - or some abstraction of them to do it's
drawing?

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

