Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265658AbTFXETW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 00:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265659AbTFXETW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 00:19:22 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:35732 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S265658AbTFXETV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 00:19:21 -0400
Date: Mon, 23 Jun 2003 21:33:28 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Samphan Raruenrom <samphan@thai.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Crusoe's performance on linux?
In-Reply-To: <Pine.LNX.4.53.0306231821480.17484@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.53.0306232128430.9041@twinlark.arctic.org>
References: <3EF1E6CD.4040800@thai.com> <20030619200308.A2135@ucw.cz>
 <3EF2144D.5060902@thai.com> <20030619221126.B3287@ucw.cz> <3EF67AD4.4040601@thai.com>
 <20030623102623.A18000@ucw.cz> <3EF74DBF.6000703@thai.com>
 <Pine.LNX.4.53.0306231821480.17484@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jun 2003, dean gaudet wrote:

> On Mon, 23 Jun 2003, Samphan Raruenrom wrote:
>
> > Desktop - Pentium III 1 G Hz 754 MB	->	10.x min.
> > Tablet PC - Crusoe TM5800 1 GHz 731 MB	->	17.x min.
...
> but i'm really guessing you're causing excessive disk i/o by having a
> small memory system use a huge tmpfs... get rid of the tmpfs and

you know a few other things occured to me -- you should use "vmstat 5" to
find out if any disk i/o is occuring (not that if longrun is doing its job
then the "idle%" for cpu statistic is completely useless -- longrun should
be making it as close to 100% as possible) .  i'm guessing you've got a
desktop disk drive in your p3 system -- which almost certainly outperforms
the laptop disk in the tablet pc...

not only for reasons like platter transfer speed, and seek latency, but
it's also possible your tablet isn't using anything faster than UDMA33 --
and in fact it's entirely possible you're not even using UDMA33.  do
something like "grep hda /var/log/dmesg" to see what the bootup messages
said.  try "hdparm -d /dev/hda" to see if dma is active -- and if it
isn't, try "hdparm -d1 /dev/hda" to enable it.

if that doesn't work then it's most likely you don't have the IDE driver
necessary for your tablet -- try "lspci -v" and try to find your
southbridge IDE controller... i don't recall which southbridge is in the
tablet, many crusoe boxes have ALi southbridges which have a kernel
driver, but i think the tablet has something other than ALi... if in doubt
post here and i'm sure someone can point you to the right driver.

-dean
