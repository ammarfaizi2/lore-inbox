Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWBWRe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWBWRe1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWBWRe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:34:26 -0500
Received: from kanga.kvack.org ([66.96.29.28]:36993 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932311AbWBWReZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:34:25 -0500
Date: Thu, 23 Feb 2006 12:29:25 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>,
       christoph <hch@lst.de>, mcao@us.ibm.com,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] change b_size to size_t
Message-ID: <20060223172925.GD27682@kvack.org>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com> <20060222151216.GA22946@lst.de> <1140627510.22756.81.camel@dyn9047017100.beaverton.ibm.com> <20060222165942.GA25167@lst.de> <20060223014004.GA900@frodo> <20060222175923.784ce5de.akpm@osdl.org> <1140712093.22756.106.camel@dyn9047017100.beaverton.ibm.com> <20060223163204.GA27682@kvack.org> <1140715738.22756.125.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140715738.22756.125.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 09:28:58AM -0800, Badari Pulavarty wrote:
> How about doing this ? Change b_state to u32 and change b_size
> to "size_t". This way, we don't increase the overall size of
> the structure on 64-bit machines. Isn't it ?

I was thinking of that too, but that doesn't work with the bit operations 
on big endian machines (which require unsigned long).  Oh well, I guess 
that even with adding an extra 8 bytes on x86-64 we're still at the 96 
bytes, or 92 bytes if the atomic_t is put at the end of the struct.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
