Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263749AbTDGXK4 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263750AbTDGXK4 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:10:56 -0400
Received: from riptidesoftware.com ([66.147.50.178]:58016 "EHLO
	ns1.riptidesoftware.com") by vger.kernel.org with ESMTP
	id S263749AbTDGW6X (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:58:23 -0400
Message-ID: <3E92053C.2040106@riptidesoftware.com>
Date: Mon, 07 Apr 2003 19:09:48 -0400
From: Christopher Curtis <chris.curtis@riptidesoftware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.3) Gecko/20030319 Debian/1.3-3
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Giger <gigerstyle@gmx.ch>
CC: Javier Achirica <achirica@telefonica.net>, linux-kernel@vger.kernel.org
Subject: OOPS in airo.c [kernel BUG at skbuff.c:315!] 2.4 series
References: <3E8E0B9B.5010805@riptidesoftware.com>	<20030405115718.3db2d65f.gigerstyle@gmx.ch>	<3E91CBE4.4010406@riptidesoftware.com> <20030407214826.43b1e7da.gigerstyle@gmx.ch>
In-Reply-To: <20030407214826.43b1e7da.gigerstyle@gmx.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

>>>Yep, look @ http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/airo-linux/airo-linux/kernel/

I've now installed this driver and it has had no effect.  VNC still 
causes this lockup readily.  The symptoms are the same: alt-sysrq works, 
but the keyboard is frozen.  I can sync disks, but I can't reboot.

Hopefully this report will be better than the last; I'm running vanilla 
kernel 2.4.21-pre5 with the 'badram', 'debianlogo', 'lowlatency', and 
'preempt' patches.  My previous report of apparent success with the 
aux_bap=1 setting was flawed.  It failed as well.

The OOPS generally looks like this:
airo: BAP error 4000 2
Warning: kfree_skb passed an skb still on a list (from d0acb466)
kernel BUG at skbuff.c:315!
invalid operand: 0000
[...]
Call Trace:    [<d0acb466>] [<d0acb466>] [<c011d117>] [<c0105550>]

rebooting and running 'ksyms' for each of these gives:

d0ac8060: __insmod_airo_S.text_L43104
d0acb466
d0acba20: stop_airo_card

but nothing for the c0* addresses.  Further info is that I am using a 
Cisco 350 PCMCIA (PC-104/ISA) wireless card with the TxPower set to 20mW 
(14dB) and no encryption; running in managed mode.

I am also now subscribed to the LKML so I can see replies.  I've been 
told that the 2.4.19 driver works with 2.4.20 so I may try that next. 
That or the Cisco driver ...

Thanks for any help, and please Cc: me directly.
Christopher

