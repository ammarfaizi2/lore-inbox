Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269302AbUH0JD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269302AbUH0JD6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 05:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269296AbUH0JDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 05:03:43 -0400
Received: from verein.lst.de ([213.95.11.210]:27117 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S269303AbUH0JCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 05:02:23 -0400
Date: Fri, 27 Aug 2004 11:00:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de, christer@weinigel.se,
       spam@tnonline.net, Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       jra@samba.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: [some sanity for a change] possible design issues for hybrids
Message-ID: <20040827090015.GB22093@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Linus Torvalds <torvalds@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
	jamie@shareable.org, christophe@saout.de, christer@weinigel.se,
	spam@tnonline.net, Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
	jra@samba.org, reiser@namesys.com, linux-fsdevel@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>, flx@namesys.com,
	reiserfs-list@namesys.com
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com> <200408262128.41326.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0408261132150.2304@ppc970.osdl.org> <20040826191323.GY21964@parcelfarce.linux.theplanet.co.uk> <20040826203228.GZ21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408261344150.2304@ppc970.osdl.org> <20040826212853.GA21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408261436480.2304@ppc970.osdl.org> <1093596998.5994.34.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093596998.5994.34.camel@imp.csi.cam.ac.uk>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 09:56:39AM +0100, Anton Altaparmakov wrote:
> If it is created on the fly, it should be "easy" to destroy on the fly
> using time-based expiry, i.e. a kernel daemon going over all of those
> beasts every X seconds (X = 5 perhaps?) and doing something like:
> 
> for (each vfsmount) {
> 	lock_vfsmount(vfsmount);
> 	if (MOUNT_IS_BUSY(vfsmount)) {
> 		unlock_vfsmount(vfsmount);
> 		continue;
> 	}
> 	if (current_time() < (vfsmount->last_used_time +
> 			vfsmount->expire_after)) {
> 		unlock_vfsmount(vfsmount);
> 		continue;
> 	}
> 	destroy_locked_vfsmount(vfsmount);
> }
> 
> Wouldn't that work?

That would work for a low number of them.  But with Hans' "visions" we'd
have a damn lot of them at which point this isn't really scalable.

