Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbVILS6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVILS6z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVILS6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:58:55 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:54811 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932151AbVILS6z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:58:55 -0400
Date: Mon, 12 Sep 2005 21:01:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: new asm-offsets.h patch problems
Message-ID: <20050912190101.GB13374@mars.ravnborg.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F045A9188@scsmsx401.amr.corp.intel.com> <20050912165056.GM25261@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912165056.GM25261@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 05:50:56PM +0100, Al Viro wrote:
> On Mon, Sep 12, 2005 at 09:00:06AM -0700, Luck, Tony wrote:
> > So I still don't understand what is really happening here.
> > 
> > I left my build script running overnight ... working on a
> > kernel at the 357d596bd... commit (where Linus merged in
> > my tree last night).  This one has your "archprepare" patch
> > already included.
> > 
> > Sometimes a build for a config succeeds, and sometimes it
> > fails. (tiger_defconfig for the last six builds has had a
> > GOOD, BAD, BAD, BAD, GOOD, GOOD sequence, while bigsur_defconfig
> > went GOOD, BAD, BAD, BAD, BAD, BAD).  This non-determinism
> > doesn't fit in well with your explanation of missing defines
> > for PAGE_SIZE etc.
> 
> There's more, apparently - I'm seeing
> make # successful full build
> make C=2 # triggering full rebuild, not just sparse run

The circular dependency:
asm-offsets.c depends on asm-offsets.h and is used to generate
asm-offsets.h. So if they do not have equal timestamp all files
including asm-offsets.h (direct or indirect) will be rebuild.
Do you see same pattern as Tony where the same build sometimes goes
well, sometimes goes bad?

	Sam
