Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263864AbUEXD3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263864AbUEXD3c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 23:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUEXD3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 23:29:32 -0400
Received: from zasran.com ([198.144.206.234]:43907 "EHLO zasran.com")
	by vger.kernel.org with ESMTP id S263864AbUEXD33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 23:29:29 -0400
Message-ID: <40B16C16.9000203@bigfoot.com>
Date: Sun, 23 May 2004 20:29:26 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: udev and /dev/sda1 not found during boot (it's there right after
 boot)
References: <408A1945.1030506@bigfoot.com> <20040424155507.GA11273@kroah.com> <40B0C9BB.4020304@bigfoot.com> <20040523162546.GA6500@kroah.com>
In-Reply-To: <20040523162546.GA6500@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sun, May 23, 2004 at 08:56:43AM -0700, Erik Steffl wrote:
> 
>>Greg KH wrote:
>>
>>>On Sat, Apr 24, 2004 at 12:37:41AM -0700, Erik Steffl wrote:
>>>
>>>
>>>>just moved to udev and everything seems to be working OK except of 
>>>>SATA drive (visible as /dev/sda1) when fsck checks it during boot (it 
>>>>works fine right after that).
>>>
>>>
>>>This is a Debian specific bug/issue.  I suggest you file it against the
>>>Debian udev package, as it is not a kernel issue.
>>
>>  why would you think it's debian specific issue?
> 
> Because it doesn't happen on my Gentoo or Red Hat based systems? :)

   I was hoping for something that would shed some light on _why_ this 
happens on my (debian) system. The fact that it doesn't happen on your 
systems that happen to be non-debian doesn't mean much... because I 
don't see anything debian specific in debian package (which is the same 
thing debian maintainer wrote, see link below).

>>  btw if I add sleep at the beginning of /etc/init.d/checkfs.sh (runs 
>>fsck for all filesystems) everythings works. Which I guess confirms that 
>>there is some delay between when the module is loaded and when the 
>>device is available in userspace. Is that how udev works? How can this 
>>issue be solved?
> 
> 
> As you point out, this is all in how udev is handled by the boot
> scripts, if they wait long enough for the device node to show up before
> continuing on or not.  Thereby showing that this is a distro specific
> issue.

   the udev is started (before the modules are loaded and certainly 
before the attempt to fsck), how's that different from any other system? 
what 'handling' are you talking about?

here are relevant startup scripts in /etc/rcS.d on my machine:

S04udev -> ../init.d/udev
S20modutils -> ../init.d/modutils
S30checkfs.sh -> ../init.d/checkfs.sh

> Now the Debian maintainer of udev has said that you should also read the
> README file for udev for more information about this type of issue.  I

   said to whom? not to me, he responded to my previous email saying 
that he cannot see how it would be debian specific issue and that it 
makes no sense to open debian bug report, see previous emails in this 
thread, here' random google URL for his post:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0404.3/0054.html

> suggest you go through the Debian bug reporting process for further
> help.

   it looks like the problem is that after the modprobe is done the 
device is still not available. that _seems_ like a serious problem of 
udev. Maybe I am missing something but after the modprobe is done and 
reports success the device should be available, ortherwise the programs 
have no way to find out what's going on. Adding random sleeps (for how 
long?) doesn't seem like a solution.

	erik
