Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265521AbUHCKjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265521AbUHCKjF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 06:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbUHCKjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 06:39:05 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:33965 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S265521AbUHCKjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 06:39:02 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Date: Tue, 3 Aug 2004 20:38:52 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16655.27452.741143.31043@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem: nfsd producing stales when restarting too fast
In-Reply-To: message from Frank Steiner on Tuesday August 3
References: <410F69DF.7050602@bio.ifi.lmu.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 3, fsteiner-mail@bio.ifi.lmu.de wrote:
> 
> Btw, it's not a problem with the init script, I can also
> produce this behaviour manually by
> /usr/sbin/exportfs -au
> killall -9 nfsd
> killall -9 /usr/sbin/rpc.mountd
> [sleep 5]
> /usr/sbin/exportfs -r
> /usr/sbin/rpc.nfsd
> /usr/sbin/rpc.mountd
> 
> Without the sleep, everything stales. With the sleep, it works
> fine.

Try doing the "exportfs -au"  *after* killing nfsd.
Unexporting active filesystems while nfsd is running almost guarantees stale
file handles.

NeilBrown
