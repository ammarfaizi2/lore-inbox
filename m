Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWEBIT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWEBIT7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 04:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWEBIT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 04:19:59 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:28347 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932506AbWEBIT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 04:19:58 -0400
Message-ID: <346557995.03234@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Tue, 2 May 2006 16:20:10 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060502082009.GA9038@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Badari Pulavarty <pbadari@us.ibm.com>
References: <20060502075049.GA5000@mail.ustc.edu.cn> <20060502080935.GS3814@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502080935.GS3814@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 10:09:36AM +0200, Jens Axboe wrote:
> I tried something very similar to this years ago, except I made it
> explicit instead of hiding it in the blk_run_backing_dev() which we
> didn't have at that time. My initial results showed that you would get a
> load of requests for different pages so would end up doing io randomly
> instead again.

Yes, the hard one would be _not_ to impact normal I/Os in any way.
A simple solution for the case of deadline scheduler would be:

- static const int read_expire = HZ / 2;  /* max time before a read is submitted. */
+ static const int read_expire = HZ / 2;  /* max time before a impending read is submitted. */
+ static const int reada_expire = HZ * 30;  /* max time before a read-ahead is submitted. */

Wu
