Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWISSxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWISSxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 14:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWISSxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 14:53:07 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:4329 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750987AbWISSxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 14:53:05 -0400
Subject: Re: [2.6.18-rc7] printk output delay in syslog wrt dmesg still
	unfixed
From: john stultz <johnstul@us.ibm.com>
To: Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <450BF1CC.2070309@imap.cc>
References: <450BF1CC.2070309@imap.cc>
Content-Type: text/plain
Date: Tue, 19 Sep 2006 11:52:12 -0700
Message-Id: <1158691933.18546.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-16 at 14:45 +0200, Tilman Schmidt wrote:
> The following problem, which I reported for kernel 2.6.18-rc1 on my
> development machine
>   Dell OptiPlex GX110
>   uname -a = Linux gx110 2.6.18-rc7-noinitrd #1 PREEMPT Thu Sep 14
> 15:13:38 CEST 2006 i686 i686 i386 GNU/Linux
>   933 MHz Pentium III processor, i810 chipset, 512 MB RAM
>   distribution SuSE 10.0, syslog-ng 1.6.8, klogd 1.4.1, Xorg X11 6.8.2
> still exists with 2.6.18-rc7:
> 
> While X is running, output from printk() appears in syslog (eg.
> /var/log/messages) only after a key is pressed on the system keyboard,
> even though it is visible with dmesg immediately.
> 
> Additional observations:
> - The problem is *not* present with 2.6.17.* or earlier kernels.
> - The problem *is* present with 2.6.18-rc*-mm* kernels.
> - The problem disappears if the X server is terminated (telinit 3) and
>   reappears if the X server is started again (telinit 5).
> - Syslog messages from userspace programs are not affected by the delay.
> - No messages are lost, all appear eventually, though possibly hours
>   or days later, depending on how long nobody touches the keyboard.
> - It doesn't matter which key is pressed; even pressing a shift key all
>   by its own is sufficient to make the missing messages appear.
> - I couldn't find any other action that would release the messages;
>   neither mouse movements or clicks, nor waiting up to 24 hours, not
>   even logging in via ssh from another machine and compiling a Linux
>   kernel. ;-)
> - The effect can be clearly observed by the difference between the
>   kernel's own timestamps and those by syslogd; an extreme example:
> 
> Sep 16 14:11:16 gx110 kernel: [18729.057746] gigaset: unblocking all
> channels
> Sep 16 14:11:16 gx110 kernel: [18729.057765] gigaset: searching
> scheduled commands
> Sep 16 14:11:16 gx110 kernel: [86033.298803] gigaset: received response
> (8 bytes): ^M^JZLOG^M^J
> Sep 16 14:11:16 gx110 kernel: [86033.298898] bas_gigaset: cmd_loop: End
> of Command (0 Bytes)
> 
> Please let me know if I can help in any way with locating the cause of
> this annoying phenomenon.

Unfortunately I don't know what would be the cause. 

You might try git-bisect to find the offending patch.
http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with-bisect.txt


thanks
-john

