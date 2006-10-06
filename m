Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422790AbWJFRyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422790AbWJFRyq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 13:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbWJFRyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 13:54:46 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:52092 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1422790AbWJFRyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 13:54:45 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=lMmEwQ2TqR8zaiBj88OThah3zwc6k1Icd15zSgqUOP7jcugkeXjyfcTcmExixHIy5eniY51UIvD2U75xj91nGNugpLR3bz0vuavxmn1MCT1ipyKs7LJ44bBlc8/knLZW;
X-IronPort-AV: i="4.09,273,1157346000"; 
   d="scan'208"; a="93117780:sNHT17193213"
Date: Fri, 6 Oct 2006 12:53:51 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dell poweredge 2400 harddisks going into offline mode when heavy I/O occurs
Message-ID: <20061006175351.GA6688@lists.us.dell.com>
References: <20060928141923.GH9348@vanheusden.com> <20060928151257.GA18268@lists.us.dell.com> <45231A63.3020102@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45231A63.3020102@tmr.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 10:20:19PM -0400, Bill Davidsen wrote:
> Matt Domsch wrote:
> >On Thu, Sep 28, 2006 at 04:19:23PM +0200, Folkert van Heusden wrote:
> >>Hi,
> >>
> >>I have a Dell Poweredge 2400 with 6 scsi harddisks in (hw-) raid 5.
> >>512MB ram, 2x P3.
> >>When heavy disk i/o occurs, the system puts the harddisks into offline
> >>mode causing the filesystems to be put in readonly. The current kernel
> >>is 2.6.8, with 2.4.27 this did not occure. Googling did not help. The
> >>disks all have green lights (there's a special led for each to indicate
> >>errors - that one is off).
> >
> >[snip]
> >>Sep 28 16:05:12 kasparov kernel: aacraid: Host adapter reset request. 
> >>SCSI hang ?
> >>Sep 28 16:06:12 kasparov kernel: aacraid: SCSI bus appears hung
> >>Sep 28 16:06:12 kasparov kernel: scsi: Device offlined - not ready after 
> >>error recovery: host 1 channel 0 id 0 lun 0
> >
> >Yes, this is familiar. See:
> >
> >http://lists.us.dell.com/pipermail/linux-poweredge/2004-May/014694.html
> >
> >In addition, please consider mounting your file systems with
> >'noatime', as this reduces the number of small writes being sent to
> >the disks.
> >
> >2.6.x kernels have the ability to swamp the RAID controller firmware
> >with requests where 2.4.x kernels couldn't so easily.
> 
> Can you configure the controller as JBOD and use software raid.

Yes, you can.  It's an option in the BIOS SETUP screen during POST.

> Would the controller keep up with that?

Yes.  (This is what I had done on my PE2400 for years too, before I
replaced it entirely).  The SCSI controller is then driven by aic7xxx,
80MB/sec capable, though in that unit it's only a single SCSI channel
and the backplane is a single 1x6 backplane, so you can't split the
bus in half; but that's no different than what you've already got.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
