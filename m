Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261906AbREPMp7>; Wed, 16 May 2001 08:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbREPMps>; Wed, 16 May 2001 08:45:48 -0400
Received: from burdell.cc.gatech.edu ([130.207.3.207]:28932 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S261906AbREPMpj>; Wed, 16 May 2001 08:45:39 -0400
Message-ID: <3B02766E.8F6A040B@cc.gatech.edu>
Date: Wed, 16 May 2001 08:45:34 -0400
From: Josh Fryman <fryman@cc.gatech.edu>
Organization: CoC, GaTech
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Oystein Viggen <oysteivi@tihlde.org>
CC: Helge Hafting <helgehaf@idb.hist.no>,
        "Chemolli Francesco (USI)" <ChemolliF@GruppoCredit.it>,
        linux-kernel@vger.kernel.org
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E504453C04C1D311988D00508B2C5C2DF2F9E1@mail11.gruppocredit.it>
		<3B0261EC.23BE5EF0@idb.hist.no> <031ypp1oi2.fsf@colargol.tihlde.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oystein Viggen wrote:
> What happens if I insert a hard drive from another computer which also
> has partitions named "home", "usr", and soforth?

not to belabor the obvious, but there are a lot of issues with this
particular approach.  

for those who advocate writing some form of signature into an NVM 
space on each device that can support it (and using this signature 
to appropriately configure the right device), there are obvious
solutions: (1) use a "motherboard serial number" or (2) the infamous
CPU serial number pre-pended to whatever tag for disk/cdrw/etc.
thus, it's easy to know when a device has just been moved within the
same machine, or has been relocated to a new machine.  no conflict
will be found.

for those who are willing to take a step back and look at the big
picture, (a) not every device on the planet has a unique key 
associated with it as many people keep pointing out; (b) not every
device has some area of "user" (eg, not hardware manufacturer) space
that can be programmed that is NVM.  if you have a situation of
BOTH (a) and (b) then you are screwed, period.  use an arbitrary
ordering, as there's no other possible choice - and no way to 
preserve anything.  note that "arbitrary" can just be "sequential
scan of bus + assign based on sequence # found" to get pseudo-logical 
ordering *just as easily* as doing "scan bus + randomly assign"  

if however you can do either (a) or (b), then the problem is solved.

the more interesting question is: for what class of devices does
neither unique-key or storage-NVM exist?  and are they important?

serial ports, for example, are important.  if i am monitoring a UPS
on ttyS0 and it suddenly gets remapped on the next boot to ttyS9,
that would be bad.  likewise printers and such.  but is there any 
kind of unique key or trigger that can be found for them?
