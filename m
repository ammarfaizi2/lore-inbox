Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129402AbRCBSpA>; Fri, 2 Mar 2001 13:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRCBSou>; Fri, 2 Mar 2001 13:44:50 -0500
Received: from zeus.kernel.org ([209.10.41.242]:713 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129402AbRCBSoo>;
	Fri, 2 Mar 2001 13:44:44 -0500
Date: Fri, 2 Mar 2001 18:43:08 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>, Robert Read <rread@datarithm.net>
Subject: Re: [patch] set kiobuf io_count once, instead of increment
Message-ID: <20010302184308.Z28854@redhat.com>
In-Reply-To: <20010227162222.A6389@tenchi.datarithm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010227162222.A6389@tenchi.datarithm.net>; from rread@datarithm.net on Tue, Feb 27, 2001 at 04:22:22PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2001 at 04:22:22PM -0800, Robert Read wrote:
> Currently in brw_kiovec, iobuf->io_count is being incremented as each
> bh is submitted, and decremented in the bh->b_end_io().  This means
> io_count can go to zero before all the bhs have been submitted,
> especially during a large request. This causes the end_kio_request()
> to be called before all of the io is complete.  

brw_kiovec is currently entirely synchronous, so end_kio_request()
calling is probably not a big deal right now.  It would be much more
important for an async version.

--Stephen
