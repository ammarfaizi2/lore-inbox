Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbTDFNBw (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 09:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbTDFNBw (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 09:01:52 -0400
Received: from holomorphy.com ([66.224.33.161]:40090 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262958AbTDFNBu (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 09:01:50 -0400
Date: Sun, 6 Apr 2003 06:12:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030406131251.GN993@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@digeo.com>,
	Andrea Arcangeli <andrea@suse.de>, mbligh@aracnet.com,
	mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030404163154.77f19d9e.akpm@digeo.com> <12880000.1049508832@flay> <20030405024414.GP16293@dualathlon.random> <20030404192401.03292293.akpm@digeo.com> <20030405040614.66511e1e.akpm@digeo.com> <20030405163003.GD1326@dualathlon.random> <20030405132406.437b27d7.akpm@digeo.com> <20030405220621.GG1326@dualathlon.random> <20030405143138.27003289.akpm@digeo.com> <20030406123753.GA23536@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030406123753.GA23536@mail.jlokier.co.uk>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>> And treating the nonlinear mappings as being mlocked is a great
>> simplification - I'd be interested in Ingo's views on that.

On Sun, Apr 06, 2003 at 01:37:53PM +0100, Jamie Lokier wrote:
> More generally, how about automatically discarding VMAs and rmap
> chains when pages become mlocked, and not creating those structures in
> the first place when mapping with MAP_LOCKED?

There is some complexity there, as multiple allocationns are involved.


On Sun, Apr 06, 2003 at 01:37:53PM +0100, Jamie Lokier wrote:
> The idea is that adjacent locked regions would be mergable into a
> single VMA, looking a lot like the present non-linear mapping, and
> with no need for rmap chains.

This is an even harder issue than we've considered. We're going to have
to redefine things before this is certain.


On Sun, Apr 06, 2003 at 01:37:53PM +0100, Jamie Lokier wrote:
> Because mlock is reversible, you'd need the capability to reconsitute
> individual VMAs from ptes when unlocking a region.

This is a horror from which we've not yet recovered (that I know of).
I'd like to see a proper answer for this.


-- wli
