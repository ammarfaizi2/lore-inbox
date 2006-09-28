Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751916AbWI1PM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbWI1PM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 11:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbWI1PM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 11:12:56 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:44619 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1751918AbWI1PMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 11:12:55 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=zFXwCjhwyKUl5XOMqCG4WUfH0ej6SxYm7PU2KU2zDXLL1GeQHXIzox478vy1PR4uljS9DyTqZwm3XW8VWUS2fTkeSZI3hG3Id8rADoT6z/aw6MCtek0I/ZvT8w00vPV/;
X-IronPort-AV: i="4.09,231,1157346000"; 
   d="scan'208"; a="87935474:sNHT17346762"
Date: Thu, 28 Sep 2006 10:12:57 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dell poweredge 2400 harddisks going into offline mode when heavy I/O occurs
Message-ID: <20060928151257.GA18268@lists.us.dell.com>
References: <20060928141923.GH9348@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928141923.GH9348@vanheusden.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 04:19:23PM +0200, Folkert van Heusden wrote:
> Hi,
> 
> I have a Dell Poweredge 2400 with 6 scsi harddisks in (hw-) raid 5.
> 512MB ram, 2x P3.
> When heavy disk i/o occurs, the system puts the harddisks into offline
> mode causing the filesystems to be put in readonly. The current kernel
> is 2.6.8, with 2.4.27 this did not occure. Googling did not help. The
> disks all have green lights (there's a special led for each to indicate
> errors - that one is off).

[snip]
> Sep 28 16:05:12 kasparov kernel: aacraid: Host adapter reset request. SCSI hang ?
> Sep 28 16:06:12 kasparov kernel: aacraid: SCSI bus appears hung
> Sep 28 16:06:12 kasparov kernel: scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 0 lun 0

Yes, this is familiar. See:

http://lists.us.dell.com/pipermail/linux-poweredge/2004-May/014694.html

In addition, please consider mounting your file systems with
'noatime', as this reduces the number of small writes being sent to
the disks.

2.6.x kernels have the ability to swamp the RAID controller firmware
with requests where 2.4.x kernels couldn't so easily.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
