Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbUARFxg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 00:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266219AbUARFxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 00:53:35 -0500
Received: from holomorphy.com ([199.26.172.102]:14764 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265792AbUARFxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 00:53:34 -0500
Date: Sat, 17 Jan 2004 21:52:33 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: joe.korty@ccur.com, linux-kernel@vger.kernel.org, colpatch@us.ibm.com,
       akpm@osdl.org, paulus@samba.org
Subject: Re: [PATCH] bitmap parsing routines, version 3
Message-ID: <20040118055233.GA24421@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, joe.korty@ccur.com,
	linux-kernel@vger.kernel.org, colpatch@us.ibm.com, akpm@osdl.org,
	paulus@samba.org
References: <20040114204009.3dc4c225.pj@sgi.com> <20040115081533.63c61d7f.akpm@osdl.org> <20040115181525.GA31086@tsunami.ccur.com> <20040115161732.458159f5.pj@sgi.com> <400873EC.2000406@us.ibm.com> <20040117063618.GA14829@tsunami.ccur.com> <20040117020815.3ac17c46.pj@sgi.com> <20040117145545.GA16318@tsunami.ccur.com> <20040117153615.GA16385@tsunami.ccur.com> <20040117153344.1072ae7c.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117153344.1072ae7c.pj@sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17, 2004 at 03:33:44PM -0800, Paul Jackson wrote:
> Having the various bitop routines cease treating the unused high bits as
> a garbage dump is a separate task.  I don't like the way it is, as it
> seems to open the door for some random bugs, in case some hapless code
> is depending on these high bits in ways it shouldn't.
> This whole mechanism seems to have a design confusion - whether to
> specify and honor a specific bit count, or not.

There has never been any confusion. The slop bits are treated
consistently as "don't cares". The functions used to inspect the values,
bitmap_empty(), bitmap_full(), bitmap_equal(), and bitmap_weight(), all
properly check the boundary cases. The remaining functions clobber the
slop bits without hesitation in order to simplify the implementation,
as those bits are never examined by the inspection functions.

If those bits are ever examined and interpreted when they should not be,
I'd be far more interested in hearing about that than about don't cares
being clobbered when they are supposed to be.


-- wli
