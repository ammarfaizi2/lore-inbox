Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317068AbSH0Tbb>; Tue, 27 Aug 2002 15:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSH0Tbb>; Tue, 27 Aug 2002 15:31:31 -0400
Received: from mons.uio.no ([129.240.130.14]:5307 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S317068AbSH0Tba>;
	Tue, 27 Aug 2002 15:31:30 -0400
To: Chris Wedgwood <cw@f00f.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Thunder from the hill <thunder@lightweight.ods.org>,
       Zheng Jian-Ming <zjm@cis.nctu.edu.tw>, linux-kernel@vger.kernel.org
Subject: Re: problems with changing UID/GID
References: <Pine.LNX.4.44.0208260855480.3234-100000@hawkeye.luckynet.adm>
	<1030382219.1751.14.camel@irongate.swansea.linux.org.uk>
	<20020827075426.GA6696@tapu.f00f.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 27 Aug 2002 21:35:10 +0200
In-Reply-To: <20020827075426.GA6696@tapu.f00f.org>
Message-ID: <shsvg5wqemp.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Chris Wedgwood <cw@f00f.org> writes:

     > On Mon, Aug 26, 2002 at 06:16:59PM +0100, Alan Cox wrote:
     >     It changes the whole semantics of every security test in
     >     Linux, and breaks most of them totally. Our syscalls know
     >     the uid is constant during the call

     > Could we not (eventually) have CLONE_CREDs and then lock using
     > task->cred->lock or whatever?  Or might there be cases where
     > this will deadlock?  It does mean set[eu]id will have to wait
     > of other threads and IO to complete... no matter how long that
     > takes, but other than might it be reasonable?

Locking does absolutely nothing for the problem of checking file
access with one set of credentials, and then doing the subsequent file
operation with another set of credentials.

->permission(), ->lookup(), ->create(), ->read(), etc.. may all sleep,
giving some alternate thread ample time to change uid/gid/... behind
your back.

Cheers,
  Trond
