Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279190AbRJ2LRC>; Mon, 29 Oct 2001 06:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279196AbRJ2LQw>; Mon, 29 Oct 2001 06:16:52 -0500
Received: from workplace.tp1.ruhr-uni-bochum.de ([134.147.240.2]:28169 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S279190AbRJ2LQf>; Mon, 29 Oct 2001 06:16:35 -0500
Date: Mon, 29 Oct 2001 12:17:02 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Greg KH <greg@kroah.com>
cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.13 errors and warnings
In-Reply-To: <20011028100317.C8059@kroah.com>
Message-ID: <Pine.LNX.4.33.0110291205560.29385-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Oct 2001, Greg KH wrote:

> These, and lots of the other pci_id table warnings are due to the tables
> being used for MODULE_DEVICE_TABLE() information.  When the code is not
> compiled as modules, those tables are not needed.
> 
> Hm, I guess I should look into some kind of macro to keep this from
> happening...

A couple of months ago I thought about this and could think of two 
possible solutions:

o add a __moddevtable which expands to __devinitdata 
  __attribute((unused)).
  Drawback: Needs changing of all drivers which produce the warning.
o add a variable which references the table within MODULE_DEVICE_TABLE. 
  I implemented this, minor drawback is that it costs 4 bytes per table. 
  However, IIRC Keith didn't like it at this time.

The best option, of course, is to move drivers to the new-style pci or 
whatever interface, such that the table actually gets used. But the 
middle of a stable series is not necessarily the best time to do so.
  
--Kai


