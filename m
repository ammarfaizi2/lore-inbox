Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130791AbRDBRh7>; Mon, 2 Apr 2001 13:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131079AbRDBRht>; Mon, 2 Apr 2001 13:37:49 -0400
Received: from platan.vc.cvut.cz ([147.32.240.81]:13323 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S130791AbRDBRhj>; Mon, 2 Apr 2001 13:37:39 -0400
Message-ID: <3AC8B8B2.FF9F66B7@vc.cvut.cz>
Date: Mon, 02 Apr 2001 10:36:50 -0700
From: Petr Vandrovec <vandrove@vc.cvut.cz>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac28-4g i686)
X-Accept-Language: cz, cs, en
MIME-Version: 1.0
To: mythos <papadako@csd.uoc.gr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Matrox G400 Dualhead
In-Reply-To: <Pine.GSO.4.33.0104012313000.20758-100000@iridanos.csd.uch.gr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mythos wrote:
> 
> I solved the problem with dualhead!!!
> Second head from 2.4.3 is /dev/fb2 rather than /dev/fb1.
> Just had to look to the messages.

And who is /dev/fb1? You must change your configuration...

> P.S. Petr on the second head if I put mouse in the right-corner at the
> bottom of the screen I will have a nice white border around the screen.

It is feature. Secondary head does not have any blanking, it just
repeats
last 64bits (last memory fetch cycle) again and again through whole
vertical
blanking interval (try 'setterm -bgcolor red' and you'll see). There are
two possible workarounds:
(1) create screen with width = 648 instead of 640 (it must be visible
width!)
    and fill this column with black.
    This brokes too many apps because of they expect that they can
horizontally
    scroll for vxres - xres pixels :-( 
    This is what Windows drivers do.
(2) create screen with height = 481 instead of 480 and fill this line
with
    black. Unfortunately, you cannot use virtual scrolling then :-(
So I decided just to live with it... You can just try 'fbset -yres 481
-vyres 481'
- it should implement (2).

> Also cursor blinks very strange if there is a lot of move on another
> framebuffer on the first head and leaves some white blocks around.

You are not using 'video=scrollback:0', do you? You should... There were
some
changes in console_lock recently, maybe that someone now forgets to grab
lock
when doing scrolling/putcs?
									Petr
