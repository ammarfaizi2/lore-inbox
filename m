Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264391AbUEOCnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbUEOCnj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 22:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbUEOCnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 22:43:39 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:52440
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264391AbUEOCnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 22:43:37 -0400
Date: Sat, 15 May 2004 04:43:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2
Message-ID: <20040515024336.GN3044@dualathlon.random>
References: <20040513032736.40651f8e.akpm@osdl.org> <20040513114520.A8442@infradead.org> <20040513035134.2e9013ea.akpm@osdl.org> <20040513121850.B22989@build.pdx.osdl.net> <20040513123809.01398f93.akpm@osdl.org> <20040513124249.J21045@build.pdx.osdl.net> <20040514191454.GJ3044@dualathlon.random> <20040514135849.Y21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514135849.Y21045@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 01:58:49PM -0700, Chris Wright wrote:
> gives the feel of cleaner hack), and is runtime safe (unless you care

what makes no sense to me is the "cleaner hack" approch. Since this is a
dirty hack anyways, trying to make it cleaner seems quite pointless, we
should keep it simple and localized instead, so it can be deleted with
minimal effort.  Having more than 1 hack (i.e. more than 1 sysctl) for
this as well seems pointless. Dealing with the groups as well seems
overkill and not needed.

The question is is if what you are proposing could be a long term
solution or not. If it cannot be a long term solution, then going with
a single disable_cap_mlock simplest of all hack is the best from my
point of view.

> that want safe gpg.  In fact, they probably aren't same machine, and I

they can or cannot be in the same machine, but the big question is if
the gpg user is "locally" trusted too or not. But this isn't just about
gpg. I had to put remap_file_pages under mlock too, not because of the
paging, paging of nonlinear VMAs works fine, but the truncate of the
nonlinear vmas doesn't work yet correctly. This will be eventually fixed
but in the short term I had to keep it under remap_file_pages under
mlock since you can mlock memory with remap_file_pages+truncate.

So if one group uses uml and the other group uses oracle, the group
approch won't work, only disable_cap_mlock will work. I can very well
imagine uml being run as nobody.nogroup or as wwwrun.www.

> [..] Well, anyway for gpg we only want rlimits, and this work is
> already done...

correct.
