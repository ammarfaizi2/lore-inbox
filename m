Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161147AbWJDOzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161147AbWJDOzx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 10:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161162AbWJDOzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 10:55:53 -0400
Received: from users.ccur.com ([66.10.65.2]:54979 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S1161147AbWJDOzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 10:55:52 -0400
Date: Wed, 4 Oct 2006 10:55:24 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, reinette.chatre@linux.intel.com,
       linux-kernel@vger.kernel.org, inaky@linux.intel.com
Subject: Re: [PATCH] bitmap: bitmap_parse takes a kernel buffer instead of a user buffer
Message-ID: <20061004145524.GA24335@tsunami.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <200610030816.27941.reinette.chatre@linux.intel.com> <20061003163936.d8e26629.akpm@osdl.org> <20061004141405.GA22833@tsunami.ccur.com> <20061004072746.8e4b97a0.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004072746.8e4b97a0.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 07:27:46AM -0700, Paul Jackson wrote:

> Perhaps I should have my coffee first, but I don't see where the
> order in which we wrap these affects the need to impose a crude
> upper limit on what the user can ask for.
> 
> Off hand, I'd expect the kernel version to be the actual implementing
> code, and the user version to be the wrapper and also to impose the
> crude upper limit.

I guess I am a sucker for no-transient-buffer (bufferless?)
implementations, as with them there is an intrinsic
simplicity that automatically avoids problems.  The price
in this case, though, is the use of the more expensive
get_user() where, for kernel buffers, it is not needed.

I have no objection though, and in either case we should
impose a sanity check on 'count'.

Joe
