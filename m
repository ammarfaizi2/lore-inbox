Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262534AbRENWZD>; Mon, 14 May 2001 18:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262532AbRENWYx>; Mon, 14 May 2001 18:24:53 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41994 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262528AbRENWYo>; Mon, 14 May 2001 18:24:44 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: hpa@transmeta.com (H. Peter Anvin)
Date: Mon, 14 May 2001 23:21:00 +0100 (BST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        torvalds@transmeta.com (Linus Torvalds), viro@math.psu.edu
In-Reply-To: <3B003FB0.9D12436A@transmeta.com> from "H. Peter Anvin" at May 14, 2001 01:27:28 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zQi4-0001YI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's not so much about hardcoding the names as hardcoding the *STRUCTURE*
> of the names.  For example, the current devfs has /dev/misc/* which is
> completely bogus -- it exposes an implementation detail (using the

The fact kernel space touches on naming directly is itself bogus. devfsd doing
it is nice, devfs doing naming - well it could be done.

> miscdev API as opposed to the charmajor API) which should be hidden; in
> fact a number of drivers have started their lives as miscdev devices and
> changed over time.

IHMO We have three types of namespaces

1.	Kernel interface namespace. Policy set by the kernel. Mappings
	constant and well defined where the underlying objects are well
	defined

	- inodes, dev_t

	You can make it a string if you like but at the end of the day 
	has to be an opaque handle. For constant devices it also has to be
	a constant name. Otherwise the /dev file I archived with the corporate
	backup system turns out to be a different device when I restore the 
	box after a problem and I reformat the wrong disk...

	And yes some stuff really is dynamic. Trying to talk about USB
	devices in a constant way is kind of hard. 

	We could re-encode these as strings. In fact thats how AmigaOS and
	VMS seem to do it. But we have the standards that are based on
	numbers and people who do like to assume they have meaning (eg
	hdparm, some scsi tools, ...). At best the string is a variable length
	encoding of a cookie.

	Another real horror we have is trademarks. We've already had people
	force changes on the name of kernel modules by threatening/asking 
	because names have trademark value and they argue module names 
	could be confusing.

	*NOBODY* at the 2.5 kernel summit had an answer to that problem.

2.	User namespaces. Language dependant. Policy dependant.
	Can be dynamic, can be static, can be arbitary. Not set by kernel
	policy

		/dev/foo

	Generally has to be centrally managed to put an order on the
	name spaces.

3.	Enumeration spaces

	Things like /dev/disc on devfs. Spaces that allow you to walk across
	all devices with a given property. A device can be in many

I don't care how #2 is implemented.  I care that I can implement #2 any way
I like. I care that I can implement #2 compatibly with my existing apps and
my existing backup system. I care that people who dont speak a word of English
can internationalise it.


