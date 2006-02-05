Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWBEW2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWBEW2J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 17:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWBEW2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 17:28:09 -0500
Received: from cantor.suse.de ([195.135.220.2]:32919 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750754AbWBEW2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 17:28:08 -0500
From: Neil Brown <neilb@suse.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Date: Mon, 6 Feb 2006 09:27:57 +1100
Message-ID: <17382.31725.813127.10435@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Phillip Susi <psusi@cfl.rr.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Krzysztof Halasa <khc@pm.waw.pl>, Olivier Galibert <galibert@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: message from Kyle Moffett on Sunday February 5
References: <43E1EA35.nail4R02QCGIW@burner>
	<20060202161853.GB8833@voodoo>
	<787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
	<Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr>
	<20060202210949.GD10352@voodoo>
	<43E27792.nail54V1B1B3Z@burner>
	<"787b0d920602 <Pine.LNX.4.61.0602050838110.6749"@yvahk01.tjqt.qr>
	<43E62492.6080506@cfl.rr.com>
	<E4D853FC-34C1-4332-BF92-D90E059D7543@mac.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday February 5, mrmacman_g4@mac.com wrote:
> 
> If you specify O_EXCL (and not O_CREAT), it is implementation defined  
> what will happen (in the Linux case, this opens a block device for  
> exclusive access).

With Linux, O_EXCL on a block devices isn't *exactly* exclusive
access.
It only provided you exclusive access against other people who ask for
exclusive access, which includes in-kernel usage like mount, md, dm,
and swap.

So if you open a block device O_EXCL, it will fail if the block device
is already open O_EXCL or is mounted, or in use by the kernel in some
other way (including if a partition is open O_EXCL).  An if you
succeed in getting an O_EXCL open, then no-one else will be able to
get an O_EXCL open, or mount the filesystem etc.
Bit on open without O_EXCL will always succeed no matter whether
someone has it O_EXCL or not.

So it is a lot like an advisory exclusive lock on the whole block
device.

NeilBrown
