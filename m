Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWBSWE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWBSWE5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 17:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWBSWE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 17:04:57 -0500
Received: from cantor2.suse.de ([195.135.220.15]:43905 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750788AbWBSWE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 17:04:57 -0500
From: Neil Brown <neilb@suse.de>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Date: Mon, 20 Feb 2006 09:04:27 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17400.60267.923268.861047@cse.unsw.edu.au>
Cc: Alasdair Kergon <agk@redhat.com>, Lars Marowsky-Bree <lmb@suse.de>,
       device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] sysfs representation of stacked devices (dm/md)
In-Reply-To: message from Jun'ichi Nomura on Friday February 17
References: <43F60F31.1030507@ce.jp.nec.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday February 17, j-nomura@ce.jp.nec.com wrote:
> Hello,
> 
> These patches provide common representation of dependencies
> between stacked devices (dm and md) in sysfs.
> For example, if dm-0 maps to sda, we have the following symlinks;
>    /sys/block/dm-0/slaves/sda --> /sys/block/sda
>    /sys/block/sda/holders/dm-0 --> /sys/block/dm-0

I happy with the idea of having these links.
I agree that it would be nice to have this very strongly based on the
bd_claim infrastructure.

It would be really nice if bd_claim took a "kobject *" rather than a 
"void *" and put a link in there.  This would be easy for dm and md,
but awkward for other claimers like filesystems and open file
descriptors as they don't currently have kobjects.

Possibly an extra flag that says if the 'holder' is a kobject or not,
and if it is, appropriate symlinks are created...??

NeilBrown
