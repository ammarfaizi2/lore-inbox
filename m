Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbUBURpg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 12:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbUBURpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 12:45:34 -0500
Received: from mx2.elte.hu ([157.181.151.9]:33469 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261590AbUBURpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 12:45:33 -0500
Date: Sat, 21 Feb 2004 18:46:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, Tridge <tridge@samba.org>,
       Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040221174631.GA8728@elte.hu>
References: <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu> <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org> <20040220170438.GA19722@elte.hu> <Pine.LNX.4.58.0402200911260.2533@ppc970.osdl.org> <20040220184822.GA23460@elte.hu> <20040221075853.GA828@elte.hu> <20040221080426.GO31035@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040221080426.GO31035@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* viro@parcelfarce.linux.theplanet.co.uk <viro@parcelfarce.linux.theplanet.co.uk> wrote:

> On Sat, Feb 21, 2004 at 08:58:53AM +0100, Ingo Molnar wrote:
> > filesystems that dont have 64-bit, monotonic timestamps will return
> > -ENOSYS. This should include even XFS at the moment, because the
> > timestamp is not guaranteed to be monotonic.
>  
> > any other problems with this concept?
> 
> If we are demanding specific filesystems, we could simply say "use JFS
> in case-insensitive mode" and be done with that.  Which deals with all
> problems, since fs code will guarantee uniqueness, etc.

what i propose is a pretty generic feature that we need anyway (current
32-bit, 1-sec granular mtime in most filesystems is already problematic
for things like make dependencies), while "use JFS in case-insensitive
mode" is to degrade a filesystem to a non-POSIX mode. I dont think the
two approaches are equivalent. Having good, monotonic, finegrained
timestamps is a thing of the future - case-insensitive lowlevel
filesystems are a thing of the past.

	Ingo
