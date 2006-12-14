Return-Path: <linux-kernel-owner+w=401wt.eu-S1751812AbWLNAQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbWLNAQT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 19:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbWLNAQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 19:16:19 -0500
Received: from ns2.suse.de ([195.135.220.15]:39929 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812AbWLNAQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 19:16:18 -0500
From: Neil Brown <neilb@suse.de>
To: Robert Hancock <hancockr@shaw.ca>
Date: Thu, 14 Dec 2006 11:16:33 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17792.38881.996767.961053@cse.unsw.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc6-mm2 oops and udev misbehavior
In-Reply-To: message from Robert Hancock on Tuesday December 12
References: <457F48D4.2070505@shaw.ca>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday December 12, hancockr@shaw.ca wrote:
> Seeing this oops on 2.6.19-rc6-mm2 intermittently on bootup. Also, when 
> this doesn't happen it seems like udev goes crazy adding and removing 
> /dev/md0 over and over using up a ton of CPU. Is this a known problem? 
> This also happened with -mm1.

Yes....  There is a patch in -mm called
    md-change-lifetime-rules-for-md-devices.patch

which tries to remove md devices when they are no longer needed.
However it is racy, and it seems to be impossible to close the race
without making changes in core code as well.

For now, just revert that patch.
Andrew: you can drop that patch and the two related one.  This is 
  going to need a lot more thought, and I'm not sure it is worth it
  at the moment.

Thanks,
NeilBrown
