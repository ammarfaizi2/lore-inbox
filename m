Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbUCRBpc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 20:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbUCRBpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 20:45:32 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:56751 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S262283AbUCRBp0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 20:45:26 -0500
Date: Wed, 17 Mar 2004 19:45:25 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: 2.6.5-rc1 SCSI + st regressions (was: Linux 2.6.5-rc1)
Message-ID: <20040318014525.GE20793@hexapodia.org>
References: <Pine.LNX.4.58.0403152154070.19853@ppc970.osdl.org> <20040316211203.GA3679@merlin.emma.line.org> <20040316211700.GA25059@parcelfarce.linux.theplanet.co.uk> <20040316215659.GA3861@merlin.emma.line.org> <Pine.LNX.4.58.0403172145420.1093@kai.makisara.local> <20040317213201.GB5722@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040317213201.GB5722@merlin.emma.line.org>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2004 at 10:32:01PM +0100, Matthias Andree wrote:
> On Wed, 17 Mar 2004, Kai Makisara wrote:
> > # ChangeSet
> > #   2004/03/12 16:22:36-08:00 greg@kroah.com 
> > #   remove cdev_set_name completely as it is not needed.
> > 
> > (and editing drivers/char/tty_io.c to get the kernel to compile) solved 
> > the problem for me. st.c is using the name put into kobj.name in making 
> > the class file names. I will make a patch that removes this dependency.
> 
> I had backed out that ChangeSet here as I was suspecting it (about the
> only one "new enough" to cause these problems) but bumped into tty_io.c
> compile failures and didn't have time to investigate.
> 
> > While looking at this problem, I noticed that the naming changes already 
> > committed to BK had disappeared. Looking at st.c history revealed that the 
> > following change had been committed (sorry for wrapping) by greg@kroah.com 
> > 46 hours ago:
> 
> This is how the change tree looks like in BitKeeper's histtool,
> the top line is the date in MM-DD format:
> 
> 02-22  02-24   03-03     03-13        03-13           03-15
> kai  -> axbø -> kai ------------------------------->  greg
> 1.78    1.79\   1.80                                  1.81
>              \                                   /
>               `----------corbet-------greg------'
>                          1.79.1.1     1.79.1.2
> 
> ...
> 
> Logs:
> 
> ======== st.c 1.1..1.81 ========
> D 1.81 04/03/15 15:02:26-08:00 greg@kroah.com 104 101 0/5/4363
> P drivers/scsi/st.c
> C merge
> ------------------------------------------------
> D 1.79.1.2 04/03/12 08:22:11-08:00 greg@kroah.com[greg] 103 102 0/1/4350
> P drivers/scsi/st.c
> C remove cdev_set_name completely as it is not needed.
> ------------------------------------------------
> D 1.79.1.1 04/03/13 00:47:18-08:00 corbet@lwn.net[greg] 102 100 2/3/4349
> P drivers/scsi/st.c
> C cdev 2/2: hide cdev->kobj
> ------------------------------------------------
> D 1.80 04/02/26 05:24:19-06:00 Kai.Makisara@kolumbus.fi[jejb] 101 100 28/12/4340
> P drivers/scsi/st.c
> C SCSI tape sysfs name fixes
> ------------------------------------------------
> D 1.79 04/02/23 06:23:46-08:00 axboe@suse.de[torvalds] 100 99 1/1/4351
> P drivers/scsi/st.c
> C fix SCSI non-sector bio backed IO
> 
> > The change comment was "merge" and it resulted in st.c version 1.81. (I am 
> > not using Bitkeeper but trying to extract information from bkbits.net.)
> 
> BitKeeper doesn't have more info and this doesn't look like an auto-generated
> comment of BitKeeper's, but seems to have been entered manually. Blame Greg?

That's a pretty nasty merge, so it's not real suprising that Greg didn't
get it completely right.

Nice ASCII art, BTW.  If you can reduce it to an algorithm I bet Larry
would like to hire you to add it to BK. :)

-andy
