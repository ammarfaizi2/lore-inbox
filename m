Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262690AbUKENni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbUKENni (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 08:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbUKENni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 08:43:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2474 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262683AbUKENnc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 08:43:32 -0500
Date: Fri, 5 Nov 2004 13:43:31 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Thomas Babut <thomas@babut.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, matthew@wil.cx,
       groudier@free.fr
Subject: Re: Kernel 2.6.x hangs with Symbios Logic 53c1010 Ultra3 SCSI Adapter
Message-ID: <20041105134331.GV24690@parcelfarce.linux.theplanet.co.uk>
References: <418B7790.3060905@babut.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418B7790.3060905@babut.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 01:52:32PM +0100, Thomas Babut wrote:
> Here I am again with some news. :)

Um, again?  This is the first I've heard from you.  BTW, Gerard seems to
be unreachable, which is why I took over the driver.

> I tried last night Kernel 2.6.0 and 2.6.1 (both vanilla) and the system 
> bootet up with the controller! Then I tried this:
> 
> 1) unpack vanilla Kernel 2.6.9
> 2) copy drivers/scsi/sym53c8xx_comm.h, drivers/scsi/sym53c8xx_defs.h and 
> the whole directory drivers/scsi/sym53c8xx_2/* from Kernel 2.6.1 into 
> the Kernel 2.6.9 source
> 
> It booted, too. But on all this three 2.6 Kernels the SCSI-Harddisk has 
> got very poor performance. With Kernel 2.4.26 and 2.4.27 it makes almost 
> 30 MB/s. With all three 2.6 Kernels it makes about 5 MB/s.

Sounds like your drive isn't negotiating the correct transfer rate.
If it's able to do 30MB/s, I guess it should be negotiating at least
wide, 20MHz -- 5MB/s sounds like asynchronous.

> (see http://marc.theaimsgroup.com/?l=linux-kernel&m=109953598029428&w=2 
> for detailed hardware specs and other informations)

Hrm.  Domain validation is failing.  I bet what's going on is that the
controller is U160-capable, so we're sending a PPR message to the drive
which is going haywire.  I do hope we don't have to start blacklisting
drives as being PPR-incapable.

Can you turn on negotiation debugging and send me the result?  If you
have 2.1.18m, that's sym53c8xx.debug=0x200 ... earlier than that, it's
sym53c8xx=debug:0x200

Now ... you say:

> sym0: SCSI BUS reset detected.
> sym0: SCSI BUS has been reset.
> sym0: SCSI BUS operation completed.
> 
> At this point only a hard-reset helps.

Do you mean the machine freezes at this point, or you can't boot because
this drive has your root partition on it and it can't be found?  If the
former, this is another bug that needs to be fixed.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
