Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVCWW16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVCWW16 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 17:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVCWW16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 17:27:58 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:29659 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262067AbVCWW1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 17:27:55 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Paul Slootman <paul+nospam@wurtel.net>
Date: Thu, 24 Mar 2005 09:27:40 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16961.60764.827542.318291@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: md: bug in file drivers/md/md.c, line 1513
In-Reply-To: message from Paul Slootman on Tuesday March 22
References: <d1pi21$gjq$1@news.cistron.nl>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday March 22, paul+nospam@wurtel.net wrote:
> This is on kernel 2.6.11, mdadm 1.4.0
> 
> The system has MD devices that are auto-configured on boot.
> 
> However, there are also devices connected via another SCSI adapter
> (actually, a Qlogic QLA2300). I'm using a module for that. As the
> auto-configure only runs at boot (or rather, when the md subsystem is
> started).  I wanted to restart a raid-0 device that I had previously
> created. I did:
> 
> 	mdadm --run /dev/md10

As you admit, this is wrong.  You want something like
  mdadm --assemble /dev/md10 /dev/.....(list of component devices)

or describe the md10 array (e.g. via UUID) in /etc/mdadm.conf

> 
> as a simple attempt to see what would happen. What happened was the
> error message in the subject, and a "COMPLETE RAID STATE PRINTOUT"...
> In that output there is a line "md10:", the next line is
> "md1: <sde1><sdd1><sdc1><sdb1><sda1>".
> 
> 
> Admittedly the usage may be wrong, but having the kernel say "bug" can't
> be right :-)
> 

Yes, there are quite a few of those silly bug messages.  I've removed
a few, but have not yet gone through and checked and removed all the
bad ones.
NeilBrown
