Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbTDFM0t (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 08:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbTDFM0t (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 08:26:49 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:41857 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262943AbTDFM0s (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 08:26:48 -0400
Date: Sun, 6 Apr 2003 13:37:53 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Andrea Arcangeli <andrea@suse.de>, mbligh@aracnet.com, mingo@elte.hu,
       hugh@veritas.com, dmccr@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030406123753.GA23536@mail.jlokier.co.uk>
References: <20030404163154.77f19d9e.akpm@digeo.com> <12880000.1049508832@flay> <20030405024414.GP16293@dualathlon.random> <20030404192401.03292293.akpm@digeo.com> <20030405040614.66511e1e.akpm@digeo.com> <20030405163003.GD1326@dualathlon.random> <20030405132406.437b27d7.akpm@digeo.com> <20030405220621.GG1326@dualathlon.random> <20030405143138.27003289.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030405143138.27003289.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> And treating the nonlinear mappings as being mlocked is a great
> simplification - I'd be interested in Ingo's views on that.

More generally, how about automatically discarding VMAs and rmap
chains when pages become mlocked, and not creating those structures in
the first place when mapping with MAP_LOCKED?

The idea is that adjacent locked regions would be mergable into a
single VMA, looking a lot like the present non-linear mapping, and
with no need for rmap chains.

Because mlock is reversible, you'd need the capability to reconsitute
individual VMAs from ptes when unlocking a region.

-- Jamie
