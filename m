Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbULNS7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbULNS7z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 13:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbULNS7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 13:59:55 -0500
Received: from cantor.suse.de ([195.135.220.2]:41950 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261606AbULNS7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 13:59:52 -0500
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk
Subject: arch/xen is a bad idea 
References: <41BF1983.mailP9C1B91GB@suse.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 14 Dec 2004 19:59:50 +0100
In-Reply-To: <41BF1983.mailP9C1B91GB@suse.de.suse.lists.linux.kernel>
Message-ID: <p73acsg1za1.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Andi Kleen" <ak@suse.de> writes:

[again this time with subject. sorry for the screwup]
[very late answer]

> Stunned silence I guess - merging an architecture is
> usually much more controversial ;)

In my opinion it's still an extremly bad idea to have arch/xen
an own architecture. It will cause a lot of work long term
to maintain it, especially when it gets x86-64 support too.
It would be much better to just merge it with i386/x86-64.

Currently it's already difficult enough to get people to
add fixes to both i386 and x86-64, adding fixes to three
or rather four (xen32 and xen64) architectures will be quite bad.
In practice we'll likely get much worse code drift and missing
fixes. Also I still suspect Ian is underestimating how much
work it is long term to keep an Linux architecture uptodate.

I cannot imagine the virtualization hooks are intrusive anyways. The
only things it needs to hook idle and the page table updates, right?
Doing that cleanly in the existing architectures shouldn't be that
hard.

I suspect xen64 will be rather different from xen32 anyways
because as far as I can see the tricks Xen32 uses to be
fast (segment limits) just plain don't work on 64bit
because the segments don't extend into 64bit space.
So having both in one architecture may also end up messy.

And i386 and x86-64 are in many pieces very different anyways,
I have my doubts that trying to mesh them together in arch/xen
will be very pretty.

Also the other thing I'm worried about is that there is no clear
specification on how the Xen<->Linux interface works. Assuming
there will be other para Hypervisors in the future too will we
end up with even more virtual architectures? It would be much
better to have at least a somewhat defined "linux virtual interface"
first that is actually understood by multiple people outside
the Xen group.

I think before merging stuff the hypervisor interfaces need to be
discussed on linux-kernel. Splitting the patches and posting them
as individual pieces for i386 with good description will be a good
first step for that.

-Andi
