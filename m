Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbUDAWjO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 17:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263308AbUDAWjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 17:39:14 -0500
Received: from us01smtp1.synopsys.com ([198.182.44.79]:35779 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S263304AbUDAWjL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 17:39:11 -0500
Date: Thu, 1 Apr 2004 14:39:08 -0800
From: Joe Buck <Joe.Buck@synopsys.COM>
To: Andi Kleen <ak@suse.de>,
       Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>, gcc@gcc.gnu.org,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
Message-ID: <20040401143908.B4619@synopsys.com>
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de> <20040401220957.5f4f9ad2.ak@suse.de> <20040401203923.GA32177@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040401203923.GA32177@nevyn.them.org>; from dan@debian.org on Thu, Apr 01, 2004 at 03:39:23PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Linux 2.6 losing the nanoseconds from a file timestamp ]

There are two different failure modes, but in most cases only one
results in a real problem.

Case 1: make falsely thinks that the .o is younger than the .c.  It
decides not to rebuild the .o, resulting in a bad build.

Case 2: make falsely thinks that the .c is younger than the .o.  It
recompiles the .c file, even though it didn't have to.  Harmless.

So if we can make the bad situation look like a tie, and always rebuild
in the case of a tie, we will obtain valid builds, sometimes with
an extra compilation or two.

