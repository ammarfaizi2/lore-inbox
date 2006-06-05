Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932399AbWFEDMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWFEDMR (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 23:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWFEDMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 23:12:17 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:46263 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932399AbWFEDMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 23:12:17 -0400
Date: Sun, 4 Jun 2006 23:07:32 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [minor fix] radixtree: regulate tag get return value
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Wu Fengguang <wfg@mail.ustc.edu.cn>
Message-ID: <200606042309_MC3-1-C19F-CFFD@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060604131824.e2d1c934.akpm@osdl.org>

On Sun, 4 Jun 2006 13:18:24 -0700, Andrew Morton wrote:

> test_bit() returns (1 & (expr)) - it _has_ to return 0 or 1.

On i386, test_bit(nr, addr) will return 0 or 1 only when nr is
a constant -- it uses (expr != 0).

If nr is a variable it will return either 0 or -1 because it uses:

        __asm__ __volatile__(
                "btl %2,%1\n\tsbbl %0,%0"
                :"=r" (oldbit)
                :"m" (*addr),"Ir" (nr));
        return oldbit;

btl %2,%1 sets the carry flag if the selected bit is set.

sbbl %0,%0 subtracts a register from itself and then subtracts one
from the result if the carry flag is set.

-- 
Chuck

