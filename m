Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265109AbTFUJNk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 05:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbTFUJNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 05:13:39 -0400
Received: from remt23.cluster1.charter.net ([209.225.8.33]:2270 "EHLO
	remt23.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S265109AbTFUJNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 05:13:38 -0400
Date: Sat, 21 Jun 2003 05:25:52 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: misty-@charter.net, Bernd Schubert <bernd-schubert@web.de>,
       andre@linux-ide.org, linux-kernel@vger.kernel.org, despair@adelphia.net
Subject: Re: Problems with IDE on GA-7VAXP motherboard
Message-ID: <20030621092551.GA28276@charter.net>
References: <200306191429.40523.bernd-schubert@web.de> <20030619193118.GA32406@charter.net> <20030620075249.GA7833@charter.net> <20030620105853.A16743@ucw.cz> <20030620114030.GA11827@charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030620114030.GA11827@charter.net>
User-Agent: Mutt/1.3.28i
From: misty-@charter.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, minor update. I was messing around tonight not really expecting
to get anywhere, and to my horror, saw a 'hda: lost interrupt' message.
Again. So. Off I go, trying to figure out what is going on and what do I
find out? You sir were totally right. even with the -k1 setting, the wd
drive changes it's settings back to whatever it wants when it throws the
crc errors. Which incidentally appears to be settings it shouldn't be
capable of supporting, but... whatever. Anyway. A friend of mine (who
I'm very grateful for putting up with me) helped me screw around with
PIO modes, and we managed to get the disk working with dma off and PIO
mode 4 enabled.

What was likely fooling me into thinking the drive was working properly
is the enormous amount of ram my computer has now - I tend to forget
that with almost 512MB free of ram, my disk cache can be absolutely
enormous. Which of course means I can easily  get fooled into thinking a
disk operation is working perfectly fine when in fact the disk isn't
even being touched at all.

it looks like I was very lucky with my original motherboard and that the
wd drive was able to communicate at it's stock settings without having
any special setup - otherwise, this entire assumption would never have
happened - the disk worked perfectly fine with dma on my previous
motherboard, which is why I was so surprised things broke so damn fast
now.

So, the Gigabyte motherboard I'm using is still missetting the values
for the hard disks - but on the other hand, my hard disk was also
playing foul games.

I tested right after doing a reboot with the PIO4 settings, and it
appears to be working just fine. My test consisted of a hdparm -t -T
/dev/hda and also a tar c / > /dev/null for completeness. No problems.

I'll have more detailed information on my setup for you to look at
fairly soon.

After I get the data moved off of it, I plan on sticking this WD drive
into my 486, where it will happily work without any dma support at all.
And it can stay there, for all I care. :)

Timothy C. McGrath
