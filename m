Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263834AbUEMGqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbUEMGqU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 02:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263831AbUEMGqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 02:46:20 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:45875 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S263840AbUEMGqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 02:46:03 -0400
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, Adam Litke <agl@us.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: More convenient way to grab hugepage memory
References: <20040513055520.GF27403@zax> <20040513060549.GA12695@mulix.org>
	<20040513062014.GJ27403@zax>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 12 May 2004 23:45:57 -0700
In-Reply-To: <20040513062014.GJ27403@zax>
Message-ID: <52wu3g9656.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 May 2004 06:45:58.0275 (UTC) FILETIME=[F28C8D30:01C438B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> Well, it's only called in one place - it's really the one
    David> function, just split up to let us put the wrapper creating
    David> the hugetlb file in the right place without excessive
    David> indentation.  I guess it doesn't really matter, with
    David> -funit-at-a-time it will end up the same anyway.

We seem to be in a strange situation with respect to -funit-at-a-time:

    arch/i386/Makefile:
    # Disable unit-at-a-time mode, it makes gcc use a lot more stack
    # due to the lack of sharing of stacklots.
    CFLAGS += $(call check_gcc,-fno-unit-at-a-time,)

    arch/x86_64/Makefile:
    # -funit-at-a-time shrinks the kernel .text considerably
    # unfortunately it makes reading oopses harder.
    CFLAGS += $(call check_gcc,-funit-at-a-time,)

    arch/ppc64/Makefile:
    # Enable unit-at-a-time mode when possible. It shrinks the
    # kernel considerably.
    CFLAGS += $(call check_gcc,-funit-at-a-time,)

It looks like i386/x86_64 led the way to -funit-at-a-time, ppc64
followed, and then i386 had second thoughts because of increased stack
usage around the time of 4K stacks.

No other archs have a position one way or another.

 -  Roland
