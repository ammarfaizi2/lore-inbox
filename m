Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVC1EVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVC1EVz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 23:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVC1EVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 23:21:55 -0500
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:41118 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261690AbVC1EVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 23:21:53 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Mauro Mozzarelli <mauro@ezplanet.net>
Subject: Re: imps2 mouse driver and bug 2082
Date: Sun, 27 Mar 2005 23:21:49 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <1111966642.5789.7.camel@helios.ezplanet.org>
In-Reply-To: <1111966642.5789.7.camel@helios.ezplanet.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503272321.49899.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday 27 March 2005 18:37, Mauro Mozzarelli wrote:
> The mouse driver, re-developed for kernel 2.6, ever since the earliest
> 2.6 release lost the ability to reset a broken link with an IMPS2 mouse
> (this happens when disconnecting the mouse plug either physically or
> through a "non imps2" KVM switch). The result is that the mouse can no
> longer be controlled, with the only solution being a RE-BOOT!
>

You can re-initialize mouse with the following command (while mouse is
connected):

        echo -n "reconnect" > /sys/bus/serio/devices/serioX/drvctl

where serioX is serio port your mouse is connected to. You can find out
which one by examining the driver link:

for i in /sys/bus/serio/devices/*; do echo $i: `cat $i/driver/description`; done

You could map this command to a key - given the fact that in pre-2.6 era
one had to switch from X to text console and back to restore the mouse
having a command mapped to a hot-key should be an acceptable workaround
while we searching for a better solution. 

> This issue has been filed as bug 2082
> (http://bugme.osdl.org/show_bug.cgi?id=2082) . A fix was posted for
> 2.6.8, but this patch never made its way into the kernel main stream.
> "Vojtech", author of the 2.6 mouse driver, keeps modifying his code
> version after version, therefore breaking compatibility with the posted
> patch. I adapted the patch for 2.6.9 and 2.6.10 (there are now three
> versions for 2.6.8, 2.6.9 and 2.6.10). Kernel 2.6.11(.6) was released
> recently, still with the same bug, and would require further adaptation
> of the posted patch.
>

When I wrote the patch I thought it would be ok but now I do not think
that the patch is acceptable - it still allows "junk" data into the
kernel and we should find a way to avoid it.
 
-- 
Dmitry 
