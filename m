Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbTDFJSO (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 05:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbTDFJSO (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 05:18:14 -0400
Received: from to-telus.redhat.com ([207.219.125.105]:28665 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id S262883AbTDFJSN (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 05:18:13 -0400
Date: Sun, 6 Apr 2003 05:29:43 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, mbligh@aracnet.com, mingo@elte.hu,
       hugh@veritas.com, dmccr@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030406052943.B4440@redhat.com>
References: <20030404163154.77f19d9e.akpm@digeo.com> <12880000.1049508832@flay> <20030405024414.GP16293@dualathlon.random> <20030404192401.03292293.akpm@digeo.com> <20030405040614.66511e1e.akpm@digeo.com> <20030405163003.GD1326@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030405163003.GD1326@dualathlon.random>; from andrea@suse.de on Sat, Apr 05, 2003 at 06:30:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 06:30:03PM +0200, Andrea Arcangeli wrote:
> 
> I'm not questioning during paging rmap is more efficient than objrmap,
> but your argument about rmap having lower complexity of objrmap and that
> rmap is needed is wrong. The fact is that with your 100 mappings per
> each of the 100 tasks case, both algorithms works in O(N) where N is
> the number of the pagetables mapping the page. No difference in

Small mistake on your part: there are two different parameters to that:
objrmap is O(N) where N is the number of vmas, and regular rmap is O(M) 
where M is the number of currently mapped ptes.  M <= N and is frequently 
less for sparsely resident pages (ie in things like executables).

		-ben
