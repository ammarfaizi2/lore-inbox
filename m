Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbTI3UTb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 16:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbTI3UTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 16:19:30 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:5640 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S261708AbTI3UT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 16:19:26 -0400
From: Matt Gibson <gothick@gothick.org.uk>
Organization: The Wardrobe Happy Cow Emporium
To: Simon Ask Ulsnes <simon@ulsnes.dk>
Subject: Re: Complaint: Wacom driver in 2.6
Date: Tue, 30 Sep 2003 18:13:03 +0100
User-Agent: KMail/1.5.4
References: <200309291421.45692.simon@ulsnes.dk> <200309291956.27688.gothick@gothick.org.uk> <200309300859.23281.simon@ulsnes.dk>
In-Reply-To: <200309300859.23281.simon@ulsnes.dk>
Cc: linux-kernel@vger.kernel.org
X-Pointless-MIME-Header: yes
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309301813.03609.gothick@gothick.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[disclaimer: I am not a kernel developer!]
On Tuesday 30 Sep 2003 07:59, Simon Ask Ulsnes <simon@ulsnes.dk> wrote:
> Thanks for replying.
> You aren't even using the wacom driver!

I _am_ using the wacom driver.  I'm just using the wacom kernel driver rather 
than the XFree86 wacom  driver.

> Mine works too in that way (I think it is some kind of regular PS/2 mouse
> emulation or so).

I think it goes something like this: the kernel wacom driver now interprets 
wacom packets into standard kernel mouse input.  See drivers/usb/input/
wacom.c for that: it's the wacom_graphire_irq() function that's doing it for 
us both.  Then /dev/mice gathers the input from all sources like this and 
presents them as a single ps/2-style mouse interface.  I _think_ this is 
done in mousedev.c, but I haven't really looked into it.  Someone feel free 
to correct me!

On my machine, the result is that events from both my Wacom and my old PS/2 
style mouse are seamlessly merged into /dev/mice, so that's all X needs to 
consider, and I could use them both at once if I wanted.  Not that useful to 
me, in fact, and the PS/2 mouse is only connected for those rare occasions 
when I boot into some ancient program from a DOS floppy, but hey...

I think, if you want to get the XFree86 driver working, you can't use /dev/
mice as well (otherwise, for example, when using the pen,  your X mouse will 
get events from both /dev/mice, as the kernel translates the pen movements 
into /dev/mice events, _and_ from the Wacom driver interpreting the same 
input event stream.

> Come to think of it, maybe the problem lies in the XFree86 driver, which I
> suppose isn't really compatible with the new kernel. Well, whatayaknow...
> ;-)

I think that may be your problem.  I don't know whether the standard event 
interface has changed at all recently.  I haven't found any need for the 
extra tablet features yet that would need me to look into the XFree driver 
thoroughly (one thing I do remember, though, is that the last time I looked, 
you needed to remove the mouse from the pad and drop it back down again 
before the driver started working -- did you try that, or were you seeing 
weird results rather than no results at all?)

Anyway.  It's quite possible that as 2.6 starts "getting about a bit", the 
XFree86 driver will be naturally updated to cope with it.  I don't know what 
the current status of the driver is.  The project homepage is here: 
http://people.mandrakesoft.com/~flepied/projects/wacom/ ...but I'm guessing 
you'd already found that.

Good luck!

M

-- 
"It's the small gaps between the rain that count,
 and learning how to live amongst them."
	      -- Jeff Noon
