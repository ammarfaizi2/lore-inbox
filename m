Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbUCEPtA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 10:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbUCEPtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 10:49:00 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:24485 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262627AbUCEPs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 10:48:59 -0500
Date: Fri, 5 Mar 2004 16:39:17 +0100
From: Tobias Diedrich <ranma@gmx.at>
To: Daniel McNeil <daniel@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
Subject: Re: [PATCH 2.6.3-mm4] direct_io_worker-aio_complete patch (fixes AIO Oops)
Message-ID: <20040305153916.GA2779@melchior.yamamaya.is-a-geek.org>
Mail-Followup-To: Tobias Diedrich <ranma@gmx.at>,
	Daniel McNeil <daniel@osdl.org>,
	Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-aio@kvack.org" <linux-aio@kvack.org>,
	Suparna Bhattacharya <suparna@in.ibm.com>
References: <20040228024815.GA2835@melchior.yamamaya.is-a-geek.org> <200403020954.44886.pbadari@us.ibm.com> <1078450281.1773.4.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078450281.1773.4.camel@ibm-c.pdx.osdl.net>
X-GPG-Fingerprint: 7168 1190 37D2 06E8 2496  2728 E6AF EC7A 9AC7 E0BC
X-GPG-Key: http://studserv.stud.uni-hannover.de/~ranma/gpg-key
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.17.1
X-Spam: No
X-Seen: false
X-ID: r3THOaZTYeAui0JJmrIh8G65UB8Ao5ffwh0iYjfsIFeF2btNSWr2cU@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil wrote:

> Here is the fix to this AIO oops.  An AIO O_DIRECT request was extending
> the file so it was done synchronously.  However, the request got an
> EFAULT and direct_io_worker() was calling aio_complete() on the iocb and
> returning the EFAULT.  When io_submit_one() got the EFAULT return,
> it assume it had to call aio_complete() since the i/o never got
> queued.

Thanks, this does indeed fix the oops for me.

-- 
Tobias						PGP: http://9ac7e0bc.2ya.com
Be vigilant!

