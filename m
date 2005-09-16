Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161224AbVIPSPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161224AbVIPSPG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161225AbVIPSPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:15:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42375 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161224AbVIPSPF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:15:05 -0400
Date: Fri, 16 Sep 2005 19:14:58 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Sripathi Kodi <sripathik@in.ibm.com>, Al Viro <viro@ZenIV.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, patrics@interia.pl,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
Message-ID: <20050916181458.GG19626@ftp.linux.org.uk>
References: <Pine.LNX.4.58.0509131000040.3351@g5.osdl.org> <20050913171215.GS25261@ZenIV.linux.org.uk> <43274503.7090303@in.ibm.com> <Pine.LNX.4.58.0509131601400.26803@g5.osdl.org> <20050914015003.GW25261@ZenIV.linux.org.uk> <4328C0D0.6000909@in.ibm.com> <20050915011850.GZ25261@ZenIV.linux.org.uk> <432A17E0.3060302@in.ibm.com> <20050916074606.GE19626@ftp.linux.org.uk> <20050916180535.GA10430@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916180535.GA10430@nevyn.them.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 02:05:35PM -0400, Daniel Jacobowitz wrote:
> On Fri, Sep 16, 2005 at 08:46:06AM +0100, Al Viro wrote:
> > > Further, about actual permission checks that we are doing, can we say: "A 
> > > process should be able to see /proc/<pid>/task/* of another process only if 
> > > they both belong to same uid or reader is root"? But any such change will 
> > > change the behavior of commands like 'ps', right?
> > 
> > Right.  The real question is whether the current behaviour makes any sense.
> > I've no objections to your patch + modification above, but I really wonder
> > if we should keep current rules in that area.
> 
> Why should there be any more restrictions on /proc/<pid>/task than
> there are in /proc?  Threads are not listed in the latter, but that's
> strictly for performance/usability; you can enumerate threads in /proc
> by just trying all the valid PIDs.

But we *do* see processes outside of chroot jail in /proc.  That's the
point - we have seriously inconsistent rules here.
