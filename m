Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbTLXDlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 22:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbTLXDlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 22:41:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58785 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263137AbTLXDlX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 22:41:23 -0500
Date: Wed, 24 Dec 2003 03:41:21 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>
Cc: Ian Kent <raven@themaw.net>, greg@kroah.com, ULMO@Q.NET,
       linux-kernel@vger.kernel.org
Subject: Re: DevFS vs. udev
Message-ID: <20031224034121.GH4176@parcelfarce.linux.theplanet.co.uk>
References: <20031223215910.GA15946@kroah.com> <Pine.LNX.4.33.0312240938450.890-100000@wombat.indigo.net.au> <20031223183820.5b297c50.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223183820.5b297c50.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 06:38:20PM -0800, Andrew Morton wrote:
 
> And yes, there are architectural/cleanliness issues with devfs.  In 2.5
> Adam Richter totally reinventing devfs's internals, basing it around the
> ramfs infrastructure.  If we elect to retain devfs in 2.8 then that effort
> should be resurrected.

Switching internals to ramfs won't be enough, though.  There are problems
with devfs API that can't be solved by work on internals - lifetime rules
for devfs nodes make no sense.  Take a look at the insertion/removal
primitives and think of the lifetime rules they create for directories and
user-created nodes.  _That_ is independent from the way you implement
the internals (and sanitized version of the interface won't fit into
use of ramfs, BTW).
