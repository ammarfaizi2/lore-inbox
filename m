Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVACUn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVACUn3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 15:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVACUn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 15:43:29 -0500
Received: from open.hands.com ([195.224.53.39]:59603 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S261693AbVACUnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 15:43:24 -0500
Date: Mon, 3 Jan 2005 20:53:18 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org, xen-devel@lists.sf.net
Subject: Re: [XEN] using shmfs for swapspace
Message-ID: <20050103205318.GD6631@lkcl.net>
References: <20050102162652.GA12268@lkcl.net> <20050103183133.GA19081@samarkand.rivenstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103183133.GA19081@samarkand.rivenstone.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 01:31:34PM -0500, Joseph Fannin wrote:
> On Sun, Jan 02, 2005 at 04:26:52PM +0000, Luke Kenneth Casson Leighton wrote:
> [...] 
> > this is presumed to be infinitely better than forcing the swapspace to
> > be always on disk, especially with the guests only being allocated
> > 32mbyte of physical RAM.
> 
>     I'd be interested in knowing how a tmpfs that's gone far into swap
> performs compared to a more normal on-disk fs.  I don't know if anyone
> has ever looked into it.  Is it comparable, or is tmpfs's ability to
> swap more a last-resort escape hatch?
> 
>     This is the part where I would add something valuable to this
> conversation, if I were going to do that. (But no.)

 :)

 okay.
 
 some kind person from ibm pointed out that of course if you use a
 file-based swap file (in xen terminology,
 disk=['file:/xen/guest1-swapfile,/dev/sda2,rw'] which means "publish
 guest1-swapfile on the DOM0 VM as /dev/sda2 hard drive on the
 guest1 VM) then you of course end up using the linux filesystem cache
 on DOM0 which is of course RAM-based.

 so this tends to suggest a strategy where you allocate as
 much memory as you can afford to the DOM0 VM, and as little
 as you can afford to the guests, and make the guest swap
 files bigger to compensate.

 ... and i thought it was going to need some wacky wacko non-sharing
 shared-memory virtual-memory pseudo-tmpfs block-based filesystem
 driver.  dang.

 l.

