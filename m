Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWATQP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWATQP0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWATQPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:15:25 -0500
Received: from smartmx-03.inode.at ([213.229.60.35]:38543 "EHLO
	smartmx-03.inode.at") by vger.kernel.org with ESMTP
	id S1750762AbWATQPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:15:25 -0500
Message-ID: <43D10CA9.4030307@inode.at>
Date: Fri, 20 Jan 2006 17:15:37 +0100
From: "Ernst Rohlicek jun." <ernst.rohlicek@inode.at>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.16_rc1 psmouse hangs without KVM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello list,


My first post to the linux-kernel mailing list - a little report on 
mouse hang experiences on a PS/2 mouse :-)


Since the change from 2.6.14 to 2.6.16_rc1, I got mouse hangs using a 
first-generation MS IntelliEye Explorer with USB->PS2 converter, no KVM, 
which ran smoothly on the official 2.6.14.


The syslog message is ...

   psmouse.c: resync failed, issuing reconnect request

and I have the exact symptoms - hang after about 10 sec mouse 
inactivity, then after 2 secs it's back to normal - as described in the 
thread ...

   Date     Mon, 9 Jan 2006 21:37:49 +0100
   Subject  Mouse stalls (again) with 2.6.15-mm2
   between Jesper Juhl and Dmitry Torokhov.
   (http://lkml.org/lkml/2006/1/9/313)

and a statement by Dmitry was to do resync retries every few seconds for 
KVM users.

This certainly is a good idea for KVM users, but since Jesper and me are 
counter-examples to this frequent resyncing, I suggest that this is made 
an option in the kernel, like "KVM fixes - resync mouse in background".


I personally had to turn off resyncing using the suggested

   echo -n 0 > /sys/bus/serio/devices/serioX/resync_time

to get back the expected fluent behavior, since without a KVM, there is 
no automatic resyncing required ...


Of course I stand ready for corrections or for giving more detailed info 
if required.

----
Ernst Rohlicek jun.
