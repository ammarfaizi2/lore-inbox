Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262876AbVAQUjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbVAQUjp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 15:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbVAQUjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 15:39:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56448 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262876AbVAQUjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 15:39:31 -0500
Date: Mon, 17 Jan 2005 20:39:26 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
Message-ID: <20050117203926.GU26051@parcelfarce.linux.theplanet.co.uk>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk> <41EC0466.9010509@sun.com> <20050117190028.GF24830@fieldses.org> <41EC1253.8080902@sun.com> <20050117193206.GH24830@fieldses.org> <41EC1BE6.1030506@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EC1BE6.1030506@sun.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 03:11:18PM -0500, Mike Waychison wrote:
 
> I don't think that solves the problem.  B should receive copies (with
> shared semantics if called for) of all mountpoints C1,..,Cn that are
> children of A if A->A.  This is regardless of whether or not propagation
> occurs before or after the attach.

... when that makes sense.  Do you see any real problems with the proposed
behaviour (i.e. propagation happens before attachment)?

BTW, you do realize that rbind also has "copy before attaching" semantics,
right?
 
> Allowing this is like allowing directory aliasing in the sense that an
> aliased directory that is nested within itself opens us to
> badness/headaches 8)
> 
> I still think the only way to handle this is to disallow vfsmounts in a
> p-node to have (grand)parent-child relationships.  This may have to be
> extended to the 'owned by' case as well.

Not feasible (and think what _that_ will do to --move, especially since
propagation can span namespace boundaries).
