Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269811AbUHZXsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269811AbUHZXsP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 19:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269670AbUHZXnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 19:43:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13955 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269671AbUHZXkv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:40:51 -0400
Date: Fri, 27 Aug 2004 00:40:48 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: [some sanity for a change] possible design issues for hybrids
Message-ID: <20040826234048.GD21964@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0408261132150.2304@ppc970.osdl.org> <20040826191323.GY21964@parcelfarce.linux.theplanet.co.uk> <20040826203228.GZ21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408261344150.2304@ppc970.osdl.org> <20040826212853.GA21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408261436480.2304@ppc970.osdl.org> <20040826223625.GB21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408261538030.2304@ppc970.osdl.org> <20040826225308.GC21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408261619230.2304@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408261619230.2304@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 04:24:51PM -0700, Linus Torvalds wrote:
> So basically: the "d_mounted++" just makes sure we get into
> "lookup_mnt()". That's where we will usually find the actual mount thing.
> 
> And that's also where the special case comes in: if we _don't_ find the 
> mount thing there, that's where we need to create it. That will only 
> happen if somebody looks it up using another namespace, though, so it 
> should be rare.

No.  Trivial example:

mount --bind /foo /bar
mount /dev/sda1 /bar/baz

do lookup for /foo/baz.  No namespaces involved, no vfsmounts found, d_mounted
positive and we certainly do *not* want anything to be created at that point.
