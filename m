Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTEaSmz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 14:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTEaSms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 14:42:48 -0400
Received: from mail211.mail.bellsouth.net ([205.152.58.151]:22041 "EHLO
	imf47bis.bellsouth.net") by vger.kernel.org with ESMTP
	id S264432AbTEaSml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 14:42:41 -0400
From: "J.C. Wren" <jcwren@jcwren.com>
Reply-To: jcwren@jcwren.com
To: linux-kernel@vger.kernel.org
Subject: More on Blade 100/AC97 codec detection failure
Date: Sat, 31 May 2003 14:56:01 -0400
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.53.0305311354230.2743@bellini.mit.edu>
In-Reply-To: <Pine.LNX.4.53.0305311354230.2743@bellini.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305311456.01357.jcwren@jcwren.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've done a little bit more playing around, trying to get sound working on the 
Blade 100.  First, ac97_codec.c is reading an ID of 0x00000000 for the codec.  
It's supposed to be 0x41445348 (AD1881A).  I didn't have much hope that 
forcing the codec ID to that value would solve anything, and sure enough, it 
didn't.  There are two ambiguous comments in the codec detection area:

       /* probing AC97 codec, AC97 2.0 says that bit 15 of register 0x00 
(reset) should
         * be read zero.
         *
         * FIXME: is the following comment outdated?  -jgarzik
         * Probing of AC97 in this way is not reliable, it is not even SAFE !!
         */

So which is it?

I have talked to another person with a Blade 100, using 2.4.21-rc6 (I'm on 
-rc4), and they have the EXACT same problem.  So I'm not hallucinating, 
unless we all shared the Koolaid.

I don't know the significance of this but using mpg123 to play a MP3 gives no 
audio.  Using mpg321 produces a loud hissing *way* over-amped audio that one 
can vaguely here modulation on.  It sounds like the rate is off somewhat, but 
the only way I can even remotely tell that is to use a gain of 1 (-g 1) to 
mpg321.  To even get mpg123 to work, I had to modprobe in the 'dmy' device 
and give it a fake /dev/audioctl to play with itself with.

The other person with the Blade 100 reported that 2.4.20-r8 produced the same 
hissy results.  However, there are reports of people using Debian with 2.4.18 
having it work (http://www.de-brauwer.be/docs/debian_on_sun.html).

--jcwren

