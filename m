Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932670AbWKGOVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbWKGOVy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 09:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbWKGOVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 09:21:54 -0500
Received: from mailhub.stratus.com ([134.111.1.17]:27087 "EHLO
	mailhub4.stratus.com") by vger.kernel.org with ESMTP
	id S932670AbWKGOVx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 09:21:53 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.19-rc4-mm2
Date: Tue, 7 Nov 2006 09:21:34 -0500
Message-ID: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A051@EXNA.corp.stratus.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.19-rc4-mm2
Thread-Index: AccCJZJw0qYZDx1YRqqtooT0wvm1ygAThcQA
From: "Richardson, Charlotte" <Charlotte.Richardson@stratus.com>
To: <ajwade@alumni.uwaterloo.ca>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-fbdev-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 07 Nov 2006 14:21:35.0829 (UTC) FILETIME=[08154050:01C70278]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again, Andrew -

(Sorry, I don't know what timezone you're in, but I went home, cooked
supper, ate supper, did two loads of laundry, slept for about seven
hours, ate breakfast, did another load of laundry, and voted, and now
I'm back!)

I'll go investigate whether any virtual consoles do anything weird
in 24-bit TrueColor mode with our chip here. Of course, I don't remember
what the problem with the Radeon chips I worked on several years
ago (about 7 now!) looked like. I got a list of the device ids for those
Radeons from someone who is still at my old company, and your chip is
one of them, so it isn't surprising that there is a problem. I don't
recall
exactly what we had to do about it (and as I said I can't really ask).
If the chip we are using here works solidly in 24 bit mode, I won't
be able to test it, either. I hadn't messed much with using a graphical
console at all other than to make sure that the various modes we are
supposed to support (resolution, refresh rate, and bit depth) worked
- I didn't try switching virtual consoles, etc. The systems are early
protos and there are not many of them around yet, but I pretty much
have the use of one almost all of the time. So after I finish dealing
with
the morning's email, I'll go into the lab and beat on it a bit!
I'll email results later...

If I can't repro it with this chip, if you want to mess around with it
on yours, here's what I think we had to do... I believe the trick was
to use 16bpp mode as far as what mode you write to the chip, and then
double all the x coordinate values for things like offset, width, and
pitch. You would have to do that to the accelerated routines also.
(Btw we have to turn off the acceleration here anyhow because we
essentially are hot-plugging the boards.)

/Charlotte

> -----Original Message-----
> From: Andrew Wade [mailto:andrew.j.wade@gmail.com]
> Sent: Monday, November 06, 2006 11:31 PM
> To: Richardson, Charlotte
> Cc: Andrew Morton; linux-kernel@vger.kernel.org; Kimball Murray;
linux-
> fbdev-devel@lists.sourceforge.net
> Subject: Re: 2.6.19-rc4-mm2
> 
> On 11/6/06, Richardson, Charlotte <Charlotte.Richardson@stratus.com>
> wrote:
> ...
> > How much is each line offset when you have the garbled stuff? I
mean,
> > is it a couple pixels, half the total width, something else? And is
> > it always the same for each line (or can you tell)?
> 
> Each ghost is 1/3 of a screen horizontally from the other ghosts. I've
> been looking carefully at test patterns to figure out what is going
on.
> 
> If
> 
> (1,1) (2,1) (3,1) (4,1) (5,1) (6,1) (7,1) (8,1)
> (1,2) (2,2) (3,2) (4,2) (5,2) (6,2) (7,2) (8,2)
> (1,3) (2,3) (3,3) (4,3) (5,3) (6,3) (7,3) (8,3)
> (1,4) (2,4) (3,4) (4,4) (5,4) (6,4) (7,4) (8,4)
> (1,5) (2,5) (3,5) (4,5) (5,5) (6,5) (7,5) (8,5)
> (1,6) (2,6) (3,6) (4,6) (5,6) (6,6) (7,6) (8,6)
> 
> is what should be displayed, I'm getting instead
> 
> (1,1) (2,1) (3,1) black (4,1) (5,1) (6,1) black
> (7,1) (8,1) (1,2) black (2,2) (3,2) (4,2) black
> (5,2) (6,2) (7,2) black (8,2) (1,3) (2,3) black
> (3,3) (4,3) (5,3) black (6,3) (7,3) (8,3) black
> (1,4) (2,4) (3,4) black (4,4) (5,4) (6,4) black
> (7,4) (8,4) (1,5) black (2,5) (3,5) (4,5) black
> 
> i.e., a black pixel is inserted every thee pixels.
> 
> However, it's not just a garbled display, the acceleration (I think)
is
> also bogus. When I tried setting a solid colour using echo -e
'\e[47m',
> instead of the above display, I got
> 
> (1,1) (2,1) (3,1) black (4,1) black black black
> black black (1,2) black (2,2) (3,2) (4,2) black
> black black black black black (1,3) (2,3) black
> (3,3) (4,3) black black black black black black
> (1,4) (2,4) (3,4) black (4,4) black black black
> black black (1,5) black (2,5) (3,5) (4,5) black
> 
> i.e., in addition to a black pixel being inserted every three pixels,
> one of the halves of the "source" image is black. And in the X virtual
> console, the cursor is ungarbled.
> 
> Two other thing of note is that virtual consoles 2-6 are garbled after
> only some boots. (vc7, the X server console, is always garbled). And
> output below the as-displayed bottom of a garbled virtual console
> prevents me from switching to a different vc. (I get "radeonfb FIFO
> Timeout !"/"radeonfb Idle Timeout !" on the serial line).
> 
> Hope this helps,
> 
> ajw
