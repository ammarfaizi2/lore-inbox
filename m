Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUGIFXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUGIFXI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 01:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264307AbUGIFXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 01:23:08 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:42143 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S264299AbUGIFXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 01:23:04 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Date: Fri, 9 Jul 2004 15:22:45 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16622.11173.888745.161113@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: raidstart used deprecated START_ARRAY ioctl
In-Reply-To: message from Norberto Bensa on Friday July 9
References: <200407090135.12493.norberto+linux-kernel@bensa.ath.cx>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday July 9, norberto+linux-kernel@bensa.ath.cx wrote:
> Hello,
> 
> What does this mean and how do I fix it? 
> 
> md: raidstart(pid 4983) used deprecated START_ARRAY ioctl. This will not be 
> supported beyond 2.6
> 

It means that the mechanism (that START_ARRAY ioctl) that 'raidstart'
uses to start an array is "deprecated", as in it won't be supported in
future. 
The reason for this is that it is badly designed and is not reliable.
If you have a degraded array, there is at-least and even chance that
raidstart will not successfully start it for you.

So, you should stop using raidstart.

The options are:

 1/ use "autodetect".  I'm not a big fan of this personally, but it is
   much more reliable than START_ARRAY.
   This is done by set the partition type of all partitions that
   contain part of an MD array to "Linux Raid Autodetect" (0xFD).
   Then all arrays are found and assembled at boot time.
   This requires having all of md (that you need) compiled into the
   kernel, not as modules.

 2/ use mdadm.  Read the man page about ASSEMBLE MODE.
    You have  an /etc/mdadm.conf that lists 
      - devices (or partitions) to scan
      - arrays to be started
      -  UUID of each array

    and mdadm will find and assemble the arrays.

NeilBrown
