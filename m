Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWDSWTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWDSWTK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 18:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWDSWTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 18:19:09 -0400
Received: from mx1.suse.de ([195.135.220.2]:63883 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751278AbWDSWTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 18:19:07 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 20 Apr 2006 08:18:52 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17478.46924.439611.402803@cse.unsw.edu.au>
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [RFC] copy_from_user races with readpage
In-Reply-To: message from Andrew Morton on Wednesday April 19
References: <200604191318.45738.mason@suse.com>
	<20060419134148.262c61cd.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday April 19, akpm@osdl.org wrote:
> 
> The application is being a bit silly, because the read will return
> indeterminate results depending on whether it gets there before or after
> the write.  But that's assuming that the read is reading the part of the
> page which the writer is writing.  If the reader is reading bytes 1000-1010
> and the writer is writing bytes 990-1000 then the reader is being non-silly
> and would be justifiably surprised to see zeroes.

However this non-silly case will not cause a problem.  If the write is
writing bytes 990-1000, then only those bytes risk being zeroed by
__copy_from_user.  Bytes 1000-1010 (assuming those ranges are intended
not to overlap) will not be at risk.

> 
> 
> I'd have thought that a sufficient fix would be to change
> __copy_from_user_inatomic() to not do the zeroing, then review all users to
> make sure that they cannot leak uninitialised memory.

I would agree with this.

NeilBrown
