Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290547AbSBGR0p>; Thu, 7 Feb 2002 12:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290490AbSBGR0f>; Thu, 7 Feb 2002 12:26:35 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:43025 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S289829AbSBGR0Y>;
	Thu, 7 Feb 2002 12:26:24 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Patrick Mochel <mochel@osdl.org>
Date: Thu, 7 Feb 2002 18:25:57 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] read() from driverfs files can read more bytes 
CC: <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <11240BA04440@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 Feb 02 at 8:45, Patrick Mochel wrote:
> On Thu, 7 Feb 2002, Andrey Panin wrote:
> > Attached patch adds check that returned value is less then requested 
> > byte count. I know that actual callback function device_read_status()
> > should also be fixed, but I found this bug after midnight and 
> > decided to sleep a little :)
> 
> That sanity check was in there, once upon a time. However, in moving the 
> weight from the driver callbacks to the driverfs read_file() and 
> write_file(), it must have got dropped...
> 
> Thank you. It's been applied and will be pushed forward.

[I have only 2.5.3 sources here yet]

Can you also check for size >= PAGE_SIZE on enter to entry->show()
procedure? It looks ugly to me that each driver has to check for this
constant unless it wants to smash some innocent kernel memory.

And neither of driverfs_read_file nor driverfs_write_file supports
semantic we use with other filesystems: If at least one byte was 
read/written, return byte count (even if error happens). Only if zero 
bytes was written, return error code.
                                Thanks,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz

