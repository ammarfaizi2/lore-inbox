Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUD3BCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUD3BCP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 21:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263670AbUD3BCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 21:02:15 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:6410 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261234AbUD3BCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 21:02:14 -0400
Date: Thu, 29 Apr 2004 17:54:42 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: adi@hexapodia.org, vonbrand@inf.utfsm.cl, nickpiggin@yahoo.com.au,
       jgarzik@pobox.com, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040429175442.4059b57f.pj@sgi.com>
In-Reply-To: <20040429173223.3ea4d0c5.akpm@osdl.org>
References: <40904A84.2030307@yahoo.com.au>
	<200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
	<20040429133613.791f9f9b.pj@sgi.com>
	<20040429141947.1ff81104.akpm@osdl.org>
	<20040429143403.35a7a550.pj@sgi.com>
	<20040429145725.267ea7b8.akpm@osdl.org>
	<20040430000408.GA29096@hexapodia.org>
	<20040429173223.3ea4d0c5.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> fadvise(POSIX_FADV_DONTNEED) is ideal for this.

Perhaps ... perhaps not.

Just as the knobs "only reclaim pagecache" and "reclaim vfs caches
harder" had too big a scope (system-wide), using fadvise might have too
small a scope (currently cached pages of current task only).

If his background daemon is some shell script, say, that uses 'cat' to
generate the i/o to the other spindle, then he probably wants to be
marking that daemon job "don't let this entire job eat my pagecache",
not rebuilding a hacked up cat command with added POSIX_FADV_DONTNEED
calls every megabyte.

CKRM to the rescue ... ??

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
