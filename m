Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTJCAux (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 20:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263569AbTJCAux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 20:50:53 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:29704
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263568AbTJCAuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 20:50:52 -0400
Date: Thu, 2 Oct 2003 17:51:16 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa1
Message-ID: <20031003005116.GD13051@matchmail.com>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org
References: <20031002152648.GB1240@velociraptor.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031002152648.GB1240@velociraptor.random>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 02, 2003 at 05:26:48PM +0200, Andrea Arcangeli wrote:
> Only in 2.4.23pre6aa1: 05_vm_27-pte-dirty-bit-in-hardware-1
> 
> 	This fixes a longstanding bug for a number of archs that haven't the
> 	dirty bit updated in hardware. For those archs we can't mark the pte
> 	writeable when it's still in swap cache, unless we don't mark it dirty
> 	too at the same time. Otherwise the cpu will go ahead writing to the
> 	page, no fault will happen and the swapcache will be still clean, and
> 	the data will be lost at the next zeroIO swapout leading to userspace
> 	data corruption and segfaults during swap. Affected archs are
> 	alpha/s390/s390x for example.
> 
> 	This bug was specific to the -aa VM, it couldn't happen
> 	in mainline. In my tree I optimized the code to exploited
> 	properties of archs that updates the bit in hardware for the
> 	first time. Hence the first need of a #define to differentiate the
> 	two code paths. The logic in the software-dirty-bit case will
> 	be less efficient of course (that's why there's a difference
> 	in the first place).

What does rmap do in this case then?
