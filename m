Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbTEBL3d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 07:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbTEBL3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 07:29:33 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:12261 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262017AbTEBL3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 07:29:31 -0400
Message-ID: <3EB25A03.5010608@onlinehome.de>
Date: Fri, 02 May 2003 13:44:03 +0200
From: Hans-Georg Thien <1682-600@onlinehome.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ak@suse.de
Subject: Re: [RFC][PATCH] "Disable Trackpad while typing" on Notebooks withh
 a  PS/2 Trackpad
References: <fa.pum5p2l.umu1r1@ifi.uio.no> <fa.ianmvqa.8le6bo@ifi.uio.no>
In-Reply-To: <fa.ianmvqa.8le6bo@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Hans-Georg Thien <1682-600@onlinehome.de> writes:
> 
> 
>>The short story
>>---------------
>>The trackpad on the MacIntosh iBook Notebooks have a feature that
>>prevents unintended trackpad input while typing on the keyboard. There
>>are no mouse-moves or mouse-taps for a short period of time after each
>>keystroke.
> 
> 
> Very nice. In fact I wanted something like this for my ibook for a
> long time.
> 
> But it won't work on an ibook of course because it doesn't use the
> pc_keyb driver. Instead it uses the Input layer for the adb device.
> In fact in 2.5 there is only the input layer for everything including
> PC keyboards. It should be probably moved there too.
> 
Sounds good! I will look into 2.5 soon. But I fear that a lot of time 
will pass until 2.6 is available and I think it is a good interim 
solution for the 2.4 users.

> One suggestion: don't make it a CONFIG_*. Recompiling a kernel
> to change things like that is not good. Make it an ioctl that
> can be configured at runtime.
> 
that's why I would prefer a LKM instead of a kernel patch. If you know a 
clean way to save/restore irq-handlers please let me know. That would 
also allow to make it portable to other platforms like Apple iBook or 
notebooks with other than PS/2 trackpads.

Implementing an ioctl() is a nice idea too. But why not have it 
configurable via the /proc interface? If you use ioctl() you still need 
to write a userspace program. Ok, that's not difficult, but I think it's 
more comfortable if you can simply use

   #/etc/rc.d/trackpad, set trackpad delay time
   echo "trackpad delay=2000" > /proc/something

   #/etc/hotplug???  external mouse is just plugged in, disable trackpad
   echo "trackpad disable=1" > /proc/something

   #/etc/hotplug???  external mouse is just revmoved, re-enable trackpad
   echo "trackpad disable=0" > /proc/something

> Another one: the disable_trackpad_timer_while_typing variable is not 
> really needed. You can manage all state by checking the timer with
> timer_pending()
> 
yes ok, so I can save one variable. But I would than have to make the 
enable_trackpad_timer a static global var. That's not really bad, but I 
feel that "complex datastructures" better hidden in a function, - but 
it's only a "feeling"

-Hans

