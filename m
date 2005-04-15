Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVDOSHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVDOSHi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 14:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVDOSHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 14:07:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24806 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261890AbVDOSHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 14:07:24 -0400
Date: Fri, 15 Apr 2005 14:07:03 -0400
From: Dave Jones <davej@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Chris Wright <chrisw@osdl.org>, Andi Kleen <ak@suse.de>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6 II
Message-ID: <20050415180703.GA26289@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Hugh Dickins <hugh@veritas.com>, Chris Wright <chrisw@osdl.org>,
	Andi Kleen <ak@suse.de>,
	"Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
	Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
References: <20050407062928.GH24469@wotan.suse.de> <Pine.LNX.4.61.0504141419250.25074@goblin.wat.veritas.com> <20050414170117.GD22573@wotan.suse.de> <Pine.LNX.4.61.0504141804480.26008@goblin.wat.veritas.com> <20050414181015.GH22573@wotan.suse.de> <20050414181133.GA18221@wotan.suse.de> <20050414182712.GG493@shell0.pdx.osdl.net> <20050415172408.GB8511@wotan.suse.de> <20050415172816.GU493@shell0.pdx.osdl.net> <Pine.LNX.4.61.0504151833020.29919@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504151833020.29919@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 06:58:20PM +0100, Hugh Dickins wrote:

 > > > If there was a fix for the bad pmd problem it might be a candidate
 > > > for stable, but so far we dont know what causes it yet.
 > > If I figure a way to trigger here, I'll report back.
 > 
 > Dave, earlier on you were quite able to reproduce the problem on 2.6.11,
 > finding it happened the first time you ran X.  Do you have any time to
 > reverify that, then try to reproduce with the load_cr3 in leave_mm patch?
 > 
 > But please don't waste your time on this unless you think it's plausible.

I used to be able to reproduce it 100% by doing this on an vanilla
upstream kernel. Then it changed behaviour so I only saw it happening
on the Fedora kernel.  For the latest Fedora update kernel I backported
this change..
- x86_64: Only free PMDs and PUDs after other CPUs have been flushed
as a 'try it and see'.  At first I thought it killed the bug, but
a day or so later, it started doing it again.

In the Fedora kernel we have a patch which restricts /dev/mem reading,
so I got suspicious about this interacting with any of the changes
that had happened to drivers/char/mem.c
Out of curiousity, I backported the 3-4 patches from .12rc to
the Fedora .11 kernel, and haven't seen the problem since.

The bizarre thing is I can't explain why any of those patches would
make such a difference.  Given the bug seems to be coming and going
for me, its possible its just masked the problem.

		Dave

