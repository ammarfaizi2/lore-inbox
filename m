Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268624AbUHLRXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268624AbUHLRXi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 13:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268625AbUHLRXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 13:23:38 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:61604 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S268624AbUHLRXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 13:23:35 -0400
Message-ID: <411BA797.2030705@eidetix.com>
Date: Thu, 12 Aug 2004 19:23:35 +0200
From: "David N. Welton" <davidw@eidetix.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Sascha Wilde <wilde@sha-bang.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
References: <20040811141408.17933.qmail@web81304.mail.yahoo.com> <20040811175613.GA829@kenny.sha-bang.local> <411BA214.2060306@eidetix.com>
In-Reply-To: <411BA214.2060306@eidetix.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David N. Welton wrote:

> Sascha, if you want to test it out, try this in i8042_controller_init,
> at about line 724 (near this: i8042_initial_ctr = i8042_ctr;)
> 
>     {
>         unsigned char pram;
>         pram = (~i8042_ctr) & 0xff ;
>         i8042_command(&pram, I8042_CMD_CTL_WCTR);
>     }

In fact, it's enough to fix the problem on my machine!  I can even plug 
the keyboard back in and it works.

--- /home/davidw/linux-2.6.7/drivers/input/serio/i8042.c 
2004-06-16 07:18
:57.000000000 +0200
+++ drivers/input/serio/i8042.c 2004-08-12 19:05:17.000000000 +0200
@@ -710,6 +710,9 @@
                 return -1;
         }

+
+       i8042_ctr = (~i8042_ctr) & 0xff;
+
         i8042_initial_ctr = i8042_ctr;

Try that and see how it works for you (sorry 'bout the formatting... at 
work I have Mozilla Thunderbird).

Now... I guess the problem is: 1) why the heck does that work? 2) How to 
integrate it into the kernel?   I don't suppose everyone else wants 
their register values inverted.

-- 
David N. Welton
davidw@eidetix.com
