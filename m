Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVAaUuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVAaUuK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 15:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVAaUuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 15:50:09 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:50584 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261357AbVAaUuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 15:50:02 -0500
Date: Mon, 31 Jan 2005 12:49:57 -0800
From: Paul Jackson <pj@sgi.com>
To: Matt Mackall <mpm@selenic.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/8] lib/sort: turn off self-test
Message-Id: <20050131124957.098ed888.pj@sgi.com>
In-Reply-To: <20050131170344.GP2891@waste.org>
References: <20050131074400.GL2891@waste.org>
	<20050131035742.1434944c.pj@sgi.com>
	<20050131170344.GP2891@waste.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt wrote:
> I actually think that more code
> ought to have such tests, so long as they don't obscure the code in
> question.

If all the little unit tests that had ever been coded for kernel code
were embedded in "#if 0 ... #endif" sections, it _would_ obscure the
code.

To the local maintainer of a file, it's not much of an issue, as they
are actively familiar with what's there and look past the disabled test.
But to the stranger passing through, it's just another three dozen lines
of code that need to be waded through, or another false hit or two on
some wide ranging grep that needs to be filtered out.

Instead, I'd suggest a couple of comments:

 1) Describe this unit test in a comment, such as:

	/*
	 * Nice unit test for this sort: try sorting the array
	 * of 1000 integers constructed with the loop:
	 *	for (i = 0; i < 1000; i ++)
	 *		a[i] = r = (r * 725861) % 6599;
	 * Sort then verify that for each i: a[i] <= a[i+1].
	 */

    Five lines of comment are substantially less intrusive
    than three dozen lines of code.  Both smaller, and even
    in the output of a grep, visually distinct.

 2) Describe whatever it was you stumbled on that's behind
    your comment:

	I ran into a strange regparm-related bug ...

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
