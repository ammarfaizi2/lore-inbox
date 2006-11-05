Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965823AbWKED4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965823AbWKED4P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 22:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965821AbWKED4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 22:56:15 -0500
Received: from kanga.kvack.org ([66.96.29.28]:39049 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S965823AbWKED4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 22:56:14 -0500
Date: Sat, 4 Nov 2006 22:55:56 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc patch] i386: don't save eflags on task switch
Message-ID: <20061105035556.GQ9057@kvack.org>
References: <200611040200_MC3-1-D04D-6EA3@compuserve.com> <454CE576.3000709@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454CE576.3000709@vmware.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2006 at 11:09:42AM -0800, Zachary Amsden wrote:
> Every processor I've ever measured it on, popf is slower.  On P4, for 
> example, pushf is 6 cycles, and popf is 54.  On Opteron, it is 2 / 12.  
> On Xeon, it is 7 / 91.

pushf has to wait until all flag dependancies can be resolved.  On the 
P4 with >100 instructions in flight, that can take a long time.  Popf 
on the other hand has no dependancies on outstanding instructions as it 
resets the machine state.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
