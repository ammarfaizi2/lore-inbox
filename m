Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262825AbREVVEH>; Tue, 22 May 2001 17:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbREVVD5>; Tue, 22 May 2001 17:03:57 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:4612 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S262821AbREVVDp>;
	Tue, 22 May 2001 17:03:45 -0400
Message-ID: <20010522075634.A6096@bug.ucw.cz>
Date: Tue, 22 May 2001 07:56:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>,
        Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending Device Num
In-Reply-To: <81Cnv5o1w-B@khms.westfalen.de> <Pine.GSO.4.21.0105200925370.8940-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.GSO.4.21.0105200925370.8940-100000@weyl.math.psu.edu>; from Alexander Viro on Sun, May 20, 2001 at 09:40:28AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I've seen this question several times in this thread. I haven't seen the  
> > obvious answer, though.
> > 
> > Have a new system call:
> > 
> > ctlfd = open_device_control_fd(fd);
> > 
> > If fd is something that doesn't have a control interface (say, it already  
> > is a control filehandle), this returns an appropriate error code.
> 
> It may have several. Which one?
> 
> FWIW, I think that mixing network and device ioctls is a bad idea. These
> groups are very different and we'd be better off dealing with changes in
> them separately.
> 
> For devices... I'd say that fpath(2) (same type as getcwd(2)) would be
> a good way to deal with that. Or fpath(3) - implemented via readlink(2)
> on /proc/self/fd/<n>.

fpath is *wrong* solution, and extremely ugly.

stty 115200 < /dev/ttyS0 &
rm /dev/ttyS0

or even worse

stty 115200 < /dev/ttyS0 &
ln -s /dev/ttyS1 /dev/ttyS0

What I'm trying to show is that with fpath you can no longer delete
open devices and continue to work with them. I really think that
open_sub(fd, "control") is right solution.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
