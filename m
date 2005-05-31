Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVEaTA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVEaTA3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 15:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVEaTA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 15:00:29 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:8375 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261226AbVEaTAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 15:00:09 -0400
Date: Tue, 31 May 2005 15:00:08 -0400
To: Tobias Reinhard <tracer@robotech.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with concurrent SATA-Writes
Message-ID: <20050531190008.GJ23621@csclub.uwaterloo.ca>
References: <429C9BFA.5090901@robotech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429C9BFA.5090901@robotech.de>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 07:16:42PM +0200, Tobias Reinhard wrote:
> I have a problem with two SATA-Discs. I have an onboard SIL3114 with
> four SATA-Ports an onboard NVIDIA with two SATA-Ports - both controllers
> are disable via BIOS (and are not detected by Linux)(only for this test
> of course - normally I have other HDD on this ports). The only
> controller that is found is the add-on controller in a PCI-Slot
> (SIL3112). And that is the one I have trouble with.
> 
> If I read or write  (via dd) from the first one -> no problems. Same
> when read or write from the second or when I read (only read!) from both
> at the same time. Data-Transfer-Rate is around 45MB/s for one HDD.
> 
> The problem occures when I try to write on both discs at the same time.
> For example I write /dev/zero to the first one and then start to write
> /dev/zero to the second one. The System-Load goes up to 4 with nearly
> 100% io-wait and nearly no write-access to the drives.
> 
> Any hints?
> 
> - no errormessages in syslog
> - happens with Kernel 2.6.11.7 and with 2.6.12-rc5
> - HDDs are Samsung Spinpoint 200GB
> - (I use the SCSI-SATA-Drivers)

Might it be a problem with having two things using /dev/zero at the same
time?

What blocksize do you use with dd?

What happens if you do dd from /dev/zero to two different files on one
of the hds (with some filesystem on the drive obviously)?

How about:
dd if=/dev/zero bs=128k| tee >(dd of=/dev/disk1 bs=128k) | dd of=/dev/disk2 bs=128k

That seems pretty fast here (writing to two files in /tmp rather than
two disks since I don't have two disks I can just destroy.).

Len Sorensen
