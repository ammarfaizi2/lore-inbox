Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269451AbUINPz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269451AbUINPz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265773AbUINPyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:54:16 -0400
Received: from holomorphy.com ([207.189.100.168]:35988 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269455AbUINPvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:51:11 -0400
Date: Tue, 14 Sep 2004 08:51:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, Ray Bryant <raybry@sgi.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [profile] amortize atomic hit count increments
Message-ID: <20040914155103.GR9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914044748.GZ9106@holomorphy.com> <20040914113419.GH4180@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914113419.GH4180@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 09:47:48PM -0700, William Lee Irwin III wrote:
>> timer interrupt, usually at boot. The following patch attempts to 
>> amortize the atomic operations done on the profile buffer to address 
>> this stability concern. This patch has nothing to do with performance;

On Tue, Sep 14, 2004 at 01:34:19PM +0200, Andrea Arcangeli wrote:
> isn't it *much* simpler and much more efficient to just have a per-cpu
> idle function? I seriously doubt you'll get simultaneous collisions on
> anything but the 'halt' instruction in the idle function.

Sampling the profile buffer at regular intervals shows far less than
256 distinct functions hit in 1s intervals even with all cpus busy. As
for whether that would be sufficient, that will have to be answered by
those who reported the bug. I suppose to test whether things besides
idling do cause this problem, one would boot with a restricted
prof_cpu_mask, load all cpus on the machine, set the prof_cpu_mask to
unrestricted, and see if it livelocks before the load terminates.


-- wli
