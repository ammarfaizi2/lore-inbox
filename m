Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWBCRjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWBCRjm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 12:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWBCRjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 12:39:42 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:8079 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1751270AbWBCRjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 12:39:41 -0500
Date: Fri, 3 Feb 2006 18:39:27 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
cc: Phillip Susi <psusi@cfl.rr.com>, Bill Davidsen <davidsen@tmr.com>,
       Cynbe ru Taren <cynbe@muq.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: FYI: RAID5 unusably unstable through 2.6.14
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F0217F765@otce2k03.adaptec.com>
Message-ID: <Pine.LNX.4.60.0602031829460.24081@kepler.fjfi.cvut.cz>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F0217F765@otce2k03.adaptec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Salyzyn, Mark wrote:

> Martin Drab [mailto:drab@kepler.fjfi.cvut.cz] sez:
> > That may very well be true. I do not know what the Adaptec 
> > BIOS does under the "Low-Level Format" option. Maybe someone from
> Adaptec 
> > would know that.
> 
> The drive is low level formatted. This resolved the problem you were
> having.
> 
> > No, I don't think this was the case of a physically bad 
> > sectors. I think it was just an inconsistency of the RAID controllers
> metadata (or 
> > something simillar) related to that particular array.
> 
> It was a case of a set of physically bad sectors in a non-redundant
> formation resulting in a non-recoverable situation, from what I could
> tell. Read failures do not take the array offline, write failures do.

Again, neither read, nor write did result in disk offline. (Even though 
I'm not quite positive on trying the writing under Linux.) And it 
definitelly wasn't caused by the controller, since I was doing both reads 
and writes to that "faulty" array from Windows and all those operations 
completed without any problem.

> Instead the adapter responds with a hardware failure to the read
> responses. Writing the data would have re-assigned the bad blocks. (RAID
> controllers do reassign media bad blocks automatically, but sets them as
> inconsistent under some scenarios, requiring a write to mark them
> consistent again. This is no different to how single drive media reacts
> to faulty or corruption issues).
>
> The bad sectors were localized only affecting the Linux partition, the
> accesses were to directory or superblock nodes if memory serves. Another
> system partition was unaffected because the errors were not localized to
> it's area.

However I was able to read the Linux Ext3 data (from the /dev/sda2) 
partition using the Total Commander's ext2 plugin from Windows, and that 
worked well for the entire partition (both reads and writes).

Are you a 100% certain it must have been bad physical sectors? Since I'm 
not all that sure.

> Besides low level formatting, there is not much anyone can do about this
> issue except ask for a less catastrophic response from the Linux File
> system drivers.

This has nothing to do with filesystems, since no access was possible at 
all to that block device entirely.

> I make no offer or suggestion regarding the changes that
> would be necessary to support the system limping along when file system
> data has been corrupted; UNIX policy in general is to walk away as
> quickly as possible and do the least continuing damage.
> 
> Except this question: If a superblock can not be read in, what about the
> backup copies? Could an fsck play games with backup copies to result in
> a write to close inconsistencies?

OK, this is probably also something needed to be improved if there is the 
problem as well, but it is a totally different case than what happend 
here. This certainly had nothing to do with filesystems. As (as I've 
mentioned earlier) not even plain access to the whole /dev/sda using dd(1) 
was working.

Martin
