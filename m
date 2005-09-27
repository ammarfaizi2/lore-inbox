Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbVI0MCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbVI0MCF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 08:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbVI0MCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 08:02:05 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:9630 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S964908AbVI0MCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 08:02:04 -0400
Message-ID: <4339344C.9050305@cs.aau.dk>
Date: Tue, 27 Sep 2005 14:00:12 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Framework for automatic Configuration of a Kernel
References: <20050927093929.83645.qmail@web51010.mail.yahoo.com>
In-Reply-To: <20050927093929.83645.qmail@web51010.mail.yahoo.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First of all, I guess that the point of a script here is to decide
whether or not the hardware device is here or not. So, the output should
be something like "true" or "false", better than echoing some stupid
characters, maybe a direct "exit 0" and "exit 1" would be much less
troublesome.


Then, I might be wrong but I think we can get a more stable detection of
the PCI devices by grabbing directly the PCI vendor and device codes as
numbers instead of looking them up in the PCI ID database.

lspci -n

Or even, ask for a specific device like this:
lspci -d [<vendor>]:[<device>]

Which would give something like this:

[fleury@rade7 ~]$ lspci -d 8086:1a30
0000:00:01.0 PCI bridge: Intel Corporation 82845 845 (Brookdale) Chipset
AGP Bridge (rev 04)

Or if the device is not present:
[fleury@rade7 ~]$ lspci -d 8087:1a30
<no output>

This way just avoid to depend from the way the PCI database is written,
because whenever there is a change in the spelling of one keyword, it
might need quite a lot of updates in the Kconfigs. On the contrary, the
vendor and device PCI code will never change (hopefully).

So, the 'autorule' would look like this:

autorule pciscript.sh "8086:1a30"

And the script would be:
#/bin/sh

if [ -z "`lspci -d $1`" ]
then
    exit 1
else
    exit 0
fi

What do you think ?

Regards
-- 
Emmanuel Fleury

Unix is user-friendly. It's just more specific about his friends.
  -- Unknown
