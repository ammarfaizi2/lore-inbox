Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266472AbUBQTGZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 14:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUBQTGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 14:06:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:10468 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266472AbUBQTGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 14:06:22 -0500
Date: Tue, 17 Feb 2004 11:06:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jonathan Brown <jbrown@emergence.uk.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.3-rc4
In-Reply-To: <403263EE.9010609@emergence.uk.net>
Message-ID: <Pine.LNX.4.58.0402171100350.2154@home.osdl.org>
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
 <403263EE.9010609@emergence.uk.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, Jonathan Brown wrote:
> 
> There are still two problems with the radeonfb on my IBM X31:
> 
> 1) The screen is garbled when the fb kicks in at boot - its not 
> converting the text from the VGA console correctly. I have a photo of 
> this here: http://emergence.uk.net/radeonfb_corruption.jpeg

Yup, I see it too, it looks like it's just that fbcon doesn't clear the 
backing store when it does a resolution switch, so when the bootup process 
switches from the original VGA 80x25 text mode into 200x75 or whatever, it 
has random garbage in the new area.

It scrolls away, so it's a beauty wart at worst. I haven't bothered to 
look into where the missing clear is. Hint hint.

> 2) If I run X and then exit X or switch to a fb vt then the bottom line 
> doesn't clear when scrolling and running `clear` only clears the middle 
> line of pixels on each line of text.

This is due to the issue that I and BenH discussed on the kernel mailing 
list under the subject 

	2.6.3-rc3 radeonfb: Problems with new (and old) driver

where radeonfb doesn't even get the callback to reset the graphics engine,
so when X has changed some of the engine setup, radeonfb does the wrong 
thing afterwards. BenH already posted a patch, but I complained about how 
ugly it was ;)

So this will get fixed, but it almost certainly won't be fixed by 2.6.3.

		Linus
