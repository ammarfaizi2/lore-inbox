Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265821AbUAEBE3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 20:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbUAEBE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 20:04:29 -0500
Received: from findaloan.ca ([66.11.177.6]:12204 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S265821AbUAEBE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 20:04:27 -0500
Date: Sun, 4 Jan 2004 20:02:36 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andries Brouwer <aebr@win.tue.nl>, Linus Torvalds <torvalds@osdl.org>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040105010236.GA24001@mark.mielke.cc>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	Andries Brouwer <aebr@win.tue.nl>,
	Linus Torvalds <torvalds@osdl.org>, Rob Love <rml@ximian.com>,
	rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <20040103141029.B3393@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031423180.2162@home.osdl.org> <20040104000840.A3625@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031802420.2162@home.osdl.org> <20040104034934.A3669@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <20040104223710.GY4176@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040104223710.GY4176@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 10:37:10PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Sun, Jan 04, 2004 at 11:01:04PM +0100, Andries Brouwer wrote:
> > A common Unix idiom is testing for the identity
> > of two files by comparing st_ino and st_dev.
> > A broken idiom?
> 	No, just your usual highly selective reading.  First of all, that
> idiom relies only on different ->s_dev *among* *currently* *mounted*
> *filesystems*.
> ...
> Now, care to explain how preserving aforementioned common Unix idiom
> is related to your expostulations?

I think he is defending bad design practices by pointing out common
bad design practices, and asking why these bad practices shouldn't be
allowed to continue, given that they are so common... :-)

Are there any real programs that assume st_dev/st_ino values are constant
across mount/unmount/mount? If so, Linus is saying we should break these
programs, so that the authors can become aware of the problem, rather than
leaving the problem as a subtle corner case.

I see no reason at all to keep these programs running. They are incorrect,
and that is that.

If and when this comes up in 2.7 development, I would like to see an
option of the sort: 1) Try to maintain major:minor numbers across
reboots (even at the expense of complexity and efficiency), 2) Try to
maintain a subset of the major:minor numbers across reboots
(compromise) 3) Provide the most efficient implementation, making no
guarantees regarding the numbering scheme, unless using a numbering
scheme turns out to be more efficient. Deprecate 1), and let 2) and 3)
evolve until we see who the victor is... :-) As long as the interface
that maps device to number is abstracted, the above should be pluggable.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

