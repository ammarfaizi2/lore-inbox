Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265074AbUD3Fij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbUD3Fij (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 01:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265075AbUD3Fij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 01:38:39 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:44687 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S265074AbUD3Fig
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 01:38:36 -0400
Date: Fri, 30 Apr 2004 00:38:35 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, vonbrand@inf.utfsm.cl,
       nickpiggin@yahoo.com.au, jgarzik@pobox.com, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040430053835.GA32479@hexapodia.org>
References: <40904A84.2030307@yahoo.com.au> <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl> <20040429133613.791f9f9b.pj@sgi.com> <20040429141947.1ff81104.akpm@osdl.org> <20040429143403.35a7a550.pj@sgi.com> <20040429145725.267ea7b8.akpm@osdl.org> <20040430000408.GA29096@hexapodia.org> <20040429173223.3ea4d0c5.akpm@osdl.org> <20040429175442.4059b57f.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429175442.4059b57f.pj@sgi.com>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 05:54:42PM -0700, Paul Jackson wrote:
> Andrew wrote:
> > fadvise(POSIX_FADV_DONTNEED) is ideal for this.
> 
> Perhaps ... perhaps not.
> 
> Just as the knobs "only reclaim pagecache" and "reclaim vfs caches
> harder" had too big a scope (system-wide), using fadvise might have too
> small a scope (currently cached pages of current task only).
> 
> If his background daemon is some shell script, say, that uses 'cat' to
> generate the i/o to the other spindle, then he probably wants to be
> marking that daemon job "don't let this entire job eat my pagecache",
> not rebuilding a hacked up cat command with added POSIX_FADV_DONTNEED
> calls every megabyte.

Well, in this case it's bespoke C code so adding the fadvise isn't
terribly difficult.  (The structure of the code doesn't lend itself to
"do this every 10 MB" but I'm sure I can hack something up.)

It would be nicer if the kernel would do the right thing without needing
to have its hand held, but the fadvise will solve my immediate need.
(Assuming it works on 2.4.)

-andy
