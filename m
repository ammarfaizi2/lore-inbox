Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbVCJK7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbVCJK7K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 05:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbVCJK7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 05:59:09 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:38650 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262514AbVCJK6f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 05:58:35 -0500
Date: Thu, 10 Mar 2005 11:56:10 +0100 (CET)
To: rbultje@ronald.bitfreak.net
Subject: Re: [PATCH 2.6] Fix i2c messsage flags in video drivers
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <6TEha2ac.1110452170.7309170.khali@localhost>
In-Reply-To: <Pine.LNX.4.56.0503092336240.16415@www.ithos.nl>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Chris Wright" <chrisw@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       "Daniel Staaf" <dst@bostream.nu>, "LKML" <linux-kernel@vger.kernel.org>,
       "Andrei Mikhailovsky" <andrei@arhont.com>,
       "Ian Campbell" <icampbell@arcom.com>, "Gerd Knorr" <kraxel@bytesex.org>,
       stable@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ronald,

[Jean Delvare]
> It is possible that people are able to get their board to still work
> without my patch, if the chips were properly configured in the first
> place and they don't attempt to reconfigure them (like norm change). I
> don't know the chips well enough to tell how probable this is.

[Ronald S. Bultje]
> I'm pretty sure the patch is correct, I trust you a lot more on that than
> myself (I still need to test it, though; but that's a detail). However,
> this statement is not correct. I test this driver daily, I still own a
> whole bunch of such cards. Even after hard reboots, they still just work.
> Norm changes, input changes, everything works. I test (and use) all of
> this. I would've noticed if it was really as broken as you're describing
> above.

I'm glad to learn you are testing things. Still the oops in saa7110 went
unnoticed for the past 3 months, so I guess that either you don't have
a DC10(+) in your test panel, or you did not test mm/rc kernels.

I've gone through the code again, and here is what I think is broken in
2.6.11 on the various Zoran-based boards. Then everyone will be free to
pick any patch chunk he/she wants and apply it to any tree he/she likes.

BUZ:
Input (saa7111): works
Output (saa7185): no init, cannot set norm

DC10:
Input (saa7110): oops
Output (adv7175): no init, cannot set norm

DC30:
Input (vpx3220): works
Output (adv7175): no init, cannot set norm

LM33:
Input (bt819): no init
Output (bt856): works

LM33R10:
Input (saa7114): no init, cannot set norm
Output (adv7170): no init, cannot set norm

As you can see, all boards are affected at some level but every user
might not be equally affected, depends whether you use input or output
or both. Note that "no init" might not affect everyone either, depends
on the chip init defaults and the user needs. Ronald, can you tell us
what exactly in the above you are testing?

Personally I have only been able to test input on a DC10+ board (saa7110
driver). I lack hardware to test the output.

Hope that clarifies things,
--
Jean Delvare
