Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267481AbUBSS5B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 13:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbUBSSzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 13:55:41 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:15366 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S267481AbUBSSzC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 13:55:02 -0500
Date: Thu, 19 Feb 2004 20:08:08 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>, tridge@samba.org,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
Message-ID: <20040219190808.GB32480@hh.idb.hist.no>
References: <Pine.LNX.4.58.0402181422180.2686@home.osdl.org> <Pine.LNX.4.58.0402181427230.2686@home.osdl.org> <16435.60448.70856.791580@samba.org> <Pine.LNX.4.58.0402181457470.18038@home.osdl.org> <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 08:54:51AM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 19 Feb 2004, Jamie Lokier wrote:
> > Linus Torvalds wrote:
> > > For example, the rule can be that _any_ regular dentry create will 
> > > invalidate all the "case-insensitive" dentries. Just to be simple about 
> > > it.
> > 
> > If that's the rule, then with exactly the same algorithmic efficiency,
> > readdir+dnotify can be used to maintain the cache in userspace
> > instead.  There is nothing gained by using the helper module in that case.
> 
> Wrong.
> 
> Because the dnotify would trigger EVEN FOR SAMBA OPERATIONS.
> 
> Think about it. Think about samba doing a "rename()" within the directory.

Avoiding its own operations is a nice one.  Could dnotify pass
some information, such as the inode number involved to samba?
samba could then look up the filename in its cache and take a
closer look at that file only.  That would avoid loosing the cache,
even in case of other processes intruding.

Helge Hafting
