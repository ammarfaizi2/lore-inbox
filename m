Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263071AbVAFX6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbVAFX6z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbVAFXpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:45:53 -0500
Received: from [213.146.154.40] ([213.146.154.40]:35504 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263119AbVAFXl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:41:29 -0500
Date: Thu, 6 Jan 2005 23:41:23 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, paulmck@us.ibm.com,
       arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050106234123.GA27869@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	paulmck@us.ibm.com, arjan@infradead.org,
	linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
	pbadari@us.ibm.com, markv@us.ibm.com, greghk@us.ibm.com,
	Linus Torvalds <torvalds@osdl.org>
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106152621.395f935e.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 03:26:21PM -0800, Andrew Morton wrote:
> 
> Guys, the technical arguments are all of course correct.  But the fact
> remains that we broke things without any notice.  (Yes, perhaps someone did
> say something at sometime, but the affected party didn't know, and it's our
> job to make sure that they knew).  (These exports were removed in October -
> the IBM guys need to work out why it took so long to detect the breakage).
> 
> I think the exports should be restored.  So does Linus ("Not that I like it
> all that much, but I don't think we should break existing modules unless we
> have a very specific reason to break just those modules.").

No.  I specificly asked the question how they're using it and they're use is

 a) completely buggy
 b) poking so deep in the kernel that the user falls under the GPL
    derived works clause.  As a copyright holder of quite a bit of fs/*.c
    I certainly wouldn't give IBM a special exception to use it even if
    it was exported.

These exports were only added for intermezzo during 2.4.x and with the
removal of intermezzo they go.  They never were a public API, and that they
were needed at all was a managment mistake in how that code was merged.

> Which begs the question "how do we ever get rid of these things when we
> have no projected date for Linux-2.8"?

We've been removing stuff that has

 (1) no intree users
 (2) doesn't make sense as API

there's simply no guarantee with out of tree users.  I've gotten quite a few
mails for the recent removals, and I could tell everyone a better way to
solve it.  Just as we did to IBM for this problem (very highlevel as they
don't show sources), but they insist on their completely broken way of doing
it.

