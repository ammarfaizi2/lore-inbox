Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030484AbVIBH2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030484AbVIBH2B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 03:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030522AbVIBH2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 03:28:01 -0400
Received: from nproxy.gmail.com ([64.233.182.194]:53294 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030484AbVIBH2A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 03:28:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZRp0R3sX2+PUNrltRT/5PokRWAy6Evrqj570K/vnEjs51Qi0p8QP109lCIEzDr6MbOZYnW2M31MZjj8aplvaG3FzAyz/3lZkx4unBHVbhpBUh9ytW8oeyxPQIAx0nTwsUI+1RvfjCz8jhpa8XwuyRM2/sIQu4JAMqx7MO0Kf3TI=
Message-ID: <62b0912f0509020027212e6c42@mail.gmail.com>
Date: Fri, 2 Sep 2005 07:27:58 +0000
From: Molle Bestefich <molle.bestefich@gmail.com>
To: ataraid-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: IDE HPA
In-Reply-To: <87941b4c050830095111bf484e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <87941b4c05082913101e15ddda@mail.gmail.com>
	 <200508300859.19701.tennert@science-computing.de>
	 <87941b4c05083008523cddbb2a@mail.gmail.com>
	 <1125419927.8276.32.camel@localhost.localdomain>
	 <87941b4c050830095111bf484e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Greg Felix wrote:
> > Right.  I get the output at bootup time.  It reads that the HPA is
> > 20MB.  Which is exactly the size of how far off the metadata is in
> > Linux (once the HPA is disabled).
> 
> So your actual problem is nothing to do with the kernel or with the HPA
> behaviour ? Whatever tool you are using for raid set up isn't reading
> and processing the right fields.

If the formula is to fix all the userspace apps to take into account a
potential HPA, then eg. FDISK + SFDISK + Disk Druid et al should also
be fixed.  Because if you create a partition spanning your entire
disk, including the HPA area, and your boot files by some coincidence
ends up in the HPA part of the disk, the BIOS won't be able to read
them, and your system will not boot.  And if you fix those tools now,
what about users that use older Linux distributions?  They'll have a
parade of problems coming to them with their new HPA-enabled disks
because every userspace tool assumes that <BIOS sector count == Linux
sector count>.

> It isnt the kernels fault if you compute from of end of disk rather than
> from end of non reserved area is it ?

I agree that the entire disk should be visible under Linux.  But
instead of fixing every userspace app that assumes <BIOS sector count
== Linux sector count> (I'm guessing that's a lot), how about simply
exporting the HPA as /dev/ide/hostX/busY/targetZ/lunA/hpa, next to the
'disc' device ?
