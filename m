Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbTBGNM2>; Fri, 7 Feb 2003 08:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264886AbTBGNM2>; Fri, 7 Feb 2003 08:12:28 -0500
Received: from mons.uio.no ([129.240.130.14]:58592 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S264706AbTBGNM1>;
	Fri, 7 Feb 2003 08:12:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15939.45806.714661.655592@charged.uio.no>
Date: Fri, 7 Feb 2003 14:21:50 +0100
To: Jakob Oestergaard <jakob@unthought.net>
Cc: linux-kernel@vger.kernel.org
Subject: Race in RPC code
In-Reply-To: <20030207123123.GA25807@unthought.net>
References: <20030207123123.GA25807@unthought.net>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jakob Oestergaard <jakob@unthought.net> writes:


     > We don't know whether req has been modified between the
     > assignment and the spin_lock.

It had better not be. If it is, then I want to know where so that we
can fix it.

req->rq_xprt is set up when the request is initialized. It
is not meant to change until the request gets released. This again
should not happen while the request is still on the wait queue.

IOW the fix you propose would just be papering over another problem.

Cheers,
  Trond
