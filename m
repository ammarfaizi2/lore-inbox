Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265370AbUFHWwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265370AbUFHWwL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 18:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbUFHWwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 18:52:11 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:45954
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265370AbUFHWwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 18:52:09 -0400
Date: Wed, 9 Jun 2004 00:52:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: downgrade_write replacement in remap_file_pages
Message-ID: <20040608225206.GO18083@dualathlon.random>
References: <20040608154438.GK18083@dualathlon.random> <20040608193621.GA12780@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040608193621.GA12780@holomorphy.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2004 at 12:36:21PM -0700, William Lee Irwin III wrote:
> On Tue, Jun 08, 2004 at 05:44:38PM +0200, Andrea Arcangeli wrote:
> > -		if (pgoff != linear_page_index(vma, start) &&
> > -		    !(vma->vm_flags & VM_NONLINEAR)) {
> > +		if (unlikely(pgoff != linear_pgoff && !(vma->vm_flags & VM_NONLINEAR))) {
> 
> There is no linear_pgoff variable...

I tested it on a different codebase and I didn't notice this issue while
fixing the rejects, fixing it up is easy, replace linear_pgoff with
linear_page_index(vma, start).
