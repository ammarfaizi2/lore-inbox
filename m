Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268301AbUJOSrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268301AbUJOSrq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 14:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268306AbUJOSrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 14:47:46 -0400
Received: from holomorphy.com ([207.189.100.168]:23692 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268301AbUJOSre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 14:47:34 -0400
Date: Fri, 15 Oct 2004 11:47:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Albert Cahalan <albert@users.sf.net>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: per-process shared information
Message-ID: <20041015184713.GO5607@holomorphy.com>
References: <Pine.LNX.4.44.0410151207140.5682-100000@localhost.localdomain> <1097846353.2674.13298.camel@cube> <20041015162000.GB17849@dualathlon.random> <1097857912.2669.13548.camel@cube> <20041015171355.GD17849@dualathlon.random> <1097862714.2666.13650.camel@cube> <20041015181446.GF17849@dualathlon.random> <20041015183025.GN5607@holomorphy.com> <20041015184009.GG17849@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015184009.GG17849@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 11:30:25AM -0700, William Lee Irwin III wrote:
>> I just checked in with some Oracle people and the primary concern
>> is splitting up RSS into shared and private. Given either shared
>> or private the other is calculable.

On Fri, Oct 15, 2004 at 08:40:09PM +0200, Andrea Arcangeli wrote:
> can you define private a bit more? Is private the page_count == 1 like
> 2.4? Or is "private" == anonymous? that's the only question.
> In Hugh's patch private == "anonymous". With 2.4 private == "page_count
> == 1" (which is a subset of anonymous).

Private should be "anonymous" as far as I can tell. What's actually
going on is that they're trying to estimate per-process user memory
footprints so that the amount of client load that should be distributed
to a given box may be estimated from that. They at least used to
believe (I've since debunked this) that 2.4.x reported this information.
Their task (and hence our reporting) is not providing the complete
information to determine per-process memory footprints for general
workloads, rather it's known up-front that no fork()-based COW sharing
is going on in Oracle's case, so in this case, "anonymous" very happily
corresponds to "process-private". In fact, the /proc/ changes to report
threads only under the directory hierarchy of some distinguished thread
assists in this estimation effort.


-- wli
