Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTLYCwJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 21:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbTLYCwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 21:52:09 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:35333 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264272AbTLYCwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 21:52:05 -0500
Message-ID: <3FEA5044.5090106@amberdata.demon.co.uk>
Date: Thu, 25 Dec 2003 02:49:40 +0000
From: David Monro <davidm@amberdata.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: handling an oddball PS/2 keyboard
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a slightly odd PS/2 keyboard which I'm not quite sure of the best 
way to handle. Its an NCD N-97, which shipped with some NCD X terminals 
and also with some Mips workstations IIRC. Most of the keys produce the 
normal scancodes, and most which don't can be fixed using setkeycodes. 
However there are 2 keys which can't be made to work, which are F9 and 
F10. The problem is that these produce raw scancodes 0x60 and 0x61, 
which means the _release_ codes (setting the top bit) are 0xe0 and 0xe1. 
Unfortunately on a normal PS/2 keyboard these are special prefixes, and 
so pressing these keys usually ends up getting the keyboard driver into 
a very confused state.

What would be the cleanest way of handling this? My quick and dirty plan 
is to add a parameter to the atkbd module which just disables the 
special handling of e0 and e1 (which from a cursory glance seems to be 
pretty easy). However, I know that the NCD X terminals used to be able 
to autodetect this keyboard. I'm guessing that they did this using the 
ATKBD_CMD_GETID command, which on this keyboard returns 0xab85 (and the 
comments in atkbd.c suggest that 0xab83 is normal). So the _really_ neat 
way of handling this would be to match that ID and turn off the e0/e1 
processing then (and it would also allow me to map the keys correctly 
out-of-the box...).

So.. could I get a bunch of people to have a look in 
/proc/bus/input/devices, and see what the 'Version' field for their 
keyboard is? If it turns out that 0xab85 turns up on normal keyboards 
then obviously I'll have to abandon the 2nd approach (or find another 
way to ID it).

What chance would either of these approaches have of getting merged?

Cheers,

	David

(please CC to me, I'm not currently subscribed...)

