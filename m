Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWGZXPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWGZXPg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 19:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWGZXPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 19:15:36 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:47110 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750853AbWGZXPf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 19:15:35 -0400
Message-ID: <44C7F794.3080304@frankengul.org>
Date: Thu, 27 Jul 2006 01:15:32 +0200
From: =?ISO-8859-1?Q?S=E9bastien_Bernard?= <seb@frankengul.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: debian-sparc@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: Weird kernel 2.6.17.[67] behaviour
References: <20060726135526.GA11310@frankengul.org>
In-Reply-To: <20060726135526.GA11310@frankengul.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

seb@frankengul.org a écrit :
> I got a perfectly workable kernel 2.6.17.1 using mkinitramfs on my U60.
> 
> I applied 2 days ago the patches to update the kernel to the 2.6.17.7.
> And to my surprise when rebooting, the boot process hanged for now
> reason.
> 
> More surprising is that when boot continues if I press one key on the
> keyboard or one button on the mouse.
> 
> The hangs happens several times in the start process and each time the
> boot resume when I press a key or a button.
> 
> I never saw such a behaviour and was looking forward the change that
> caused this.
> 
> It is not the compiler since it is the same version used for building
> the 2.6.17.1 and this one is working.
> 
> It is not the mkinitramfs tools since I tried the yaird to regenerate a
> new initrd and it hangs in the same way.
> 
> Can you shed some lights on this dark corner of linux ?
> 
> 	Seb
> 
> 

I have searched which patch is the culprit.
I appears that the 2.6.17.3 kernel is OK and the 2.6.17.4 is showing the
problem..


diff --git a/kernel/sys.c b/kernel/sys.c
index 0b6ec0e..59273f7 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1991,7 +1991,7 @@ asmlinkage long sys_prctl(int option, un
                        error = current->mm->dumpable;
                        break;
                case PR_SET_DUMPABLE:
-                       if (arg2 < 0 || arg2 > 2) {
+                       if (arg2 < 0 || arg2 > 1) {
                                error = -EINVAL;
                                break;
                        }

I've checked and this is really the culprit.
Recompiling the 2.6.17.7 whith the patch reversed got the kernel on
track again.

I can't figure why this cause the problem.
Can you have an explanation for this ?
