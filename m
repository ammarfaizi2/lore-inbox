Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264105AbUD0OHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264105AbUD0OHe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 10:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264130AbUD0OHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 10:07:34 -0400
Received: from dsl081-101-153.den1.dsl.speakeasy.net ([64.81.101.153]:57800
	"EHLO mail.chen-becker.org") by vger.kernel.org with ESMTP
	id S264105AbUD0OGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 10:06:05 -0400
Message-ID: <408E68C9.5010102@chen-becker.org>
Date: Tue, 27 Apr 2004 08:06:01 -0600
From: Derek Chen-Becker <derek@chen-becker.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040119
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kim Holviala <kim@holviala.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Troubleshooting PS/2 mouse in 2.6.5
References: <408D4CB4.4070901@chen-becker.org> <200404270849.23397.kim@holviala.com> <408E64EB.6080204@chen-becker.org>
In-Reply-To: <408E64EB.6080204@chen-becker.org>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Derek Chen-Becker wrote:
> Kim Holviala wrote:
> 
>> On Monday 26 April 2004 20:53, Derek Chen-Becker wrote:
>>
>>
>>>     I'm upgrading my workstation from 2.4.22 to 2.6.5 and everything is
>>> working great except for /dev/input/mice: it doesn't appear to be
>>> producing anything, even if I cat it. I've checked and both dmesg and
>>> /proc/bus/input/devices show the mouse handler loaded and show the mouse
>>> as recognized.
>>
>>
>>
>> What do the system logs say? I suggest you build psmouse into a module 
>> so that you can modprobe/rmmod it to test stuff without rebooting.
>>

OK, this is weird. I changed psmouse to be a module and now it works (I 
also made gameport a module). Here's /proc/bus/input/devices from when 
it *didn't* work:

I: Bus=0011 Vendor=0002 Product=0005 Version=0000
N: Name="ImPS/2 Generic Wheel Mouse"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=103

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd
B: EV=120003
B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe
B: LED=7


And here's from when it *does* work:

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd
B: EV=120003
B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe
B: LED=7

I: Bus=0011 Vendor=0002 Product=0005 Version=0000
N: Name="ImPS/2 Generic Wheel Mouse"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=103

The only difference I can see is the ordering. Does the mouse handler 
have to be initialized after the keyboard handler?

Thanks,

Derek


-- 
+---------------------------------------------------------------+
| Derek Chen-Becker                                             |
| derek@chen-becker.org                                         |
| http://chen-becker.org                                        |
|                                                               |
| PGP key available on request or from public key servers       |
| ID: 21A7FB53                                                  |
| Fngrprnt: 209A 77CA A4F9 E716 E20C  6348 B657 77EC 21A7 FB53  |
+---------------------------------------------------------------+
