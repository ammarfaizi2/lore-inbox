Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129910AbRB0XWP>; Tue, 27 Feb 2001 18:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129926AbRB0XWF>; Tue, 27 Feb 2001 18:22:05 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:1465 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129910AbRB0XVt>; Tue, 27 Feb 2001 18:21:49 -0500
Message-ID: <3A9C3664.774E0E65@uow.edu.au>
Date: Tue, 27 Feb 2001 23:21:08 +0000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mario Vanoni <vanonim@dial.eunet.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3c59x new version, help me please with the new kernels
In-Reply-To: <3A9C2948.506897B8@dial.eunet.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mario Vanoni wrote:
> 
> PCI 3COM 3C905B COMBO Etherlink XL 10/100Mbit BNC+RJ-45
> running a LAN with 3 machines 10MB with BNC/RG-58U cable.
> 

Which interface do you actually want to use?  BNC?

Try `options=3'.

If that doesn't work, please send me (off-list) the log
output from the driver when it is loaded an opened
with the `debug=4' module parm.


I suspect what has happened is this:  in older kernels,
the interface selection code would try different interfaces
even if the user has selected, say, 10baseT.  This was causing
the driver to select 10base2 when the RJ45 is unplugged. It
gets stuck there, necessitating a reboot or driver reload.
So I changed the driver so that if the user says 10baseT,
we unconditionally _use_ 10baseT, dammit.

The module option (and patch) which you've been using
were relying on the old behaviour - they select the
10baseT interface.  This interface doesn't have link beat,
so the driver tries 10base2 and all is happy.

Using `options=3' will select 10base2 immediately. For the
non-modular case you'll need to use the `ether=' LILO option.

hmm..  In fact, you shouldn't need any option for 10base2 - perhaps
your EEPROM doesn't have the correct "available media" info.  Please
send me the output of `vortex-diag -aaee' - http://www.scyld.com/diag/#pci-diags

-
