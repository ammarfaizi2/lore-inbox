Return-Path: <SRS0=Z6pD=A3=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E361C433E0
	for <io-uring@archiver.kernel.org>; Thu, 16 Jul 2020 00:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC7220658
	for <io-uring@archiver.kernel.org>; Thu, 16 Jul 2020 00:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgGPAMe (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 15 Jul 2020 20:12:34 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35417 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726479AbgGPAMe (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 15 Jul 2020 20:12:34 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 06G0CCDh007246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 20:12:13 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8BA07420304; Wed, 15 Jul 2020 20:12:12 -0400 (EDT)
Date:   Wed, 15 Jul 2020 20:12:12 -0400
From:   tytso@mit.edu
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        strace-devel@lists.strace.io, io-uring@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: strace of io_uring events?
Message-ID: <20200716001212.GA388817@mit.edu>
References: <CAJfpegu3EwbBFTSJiPhm7eMyTK2MzijLUp1gcboOo3meMF_+Qg@mail.gmail.com>
 <D9FAB37B-D059-4137-A115-616237D78640@amacapital.net>
 <20200715171130.GG12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715171130.GG12769@casper.infradead.org>
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Wed, Jul 15, 2020 at 06:11:30PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 15, 2020 at 07:35:50AM -0700, Andy Lutomirski wrote:
> > > On Jul 15, 2020, at 4:12 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > This thread is to discuss the possibility of stracing requests
> > > submitted through io_uring.   I'm not directly involved in io_uring
> > > development, so I'm posting this out of  interest in using strace on
> > > processes utilizing io_uring.

> > > 
> > > Is there some existing tracing infrastructure that strace could use to
> > > get async completion events?  Should we be introducing one?

I suspect the best approach to use here is use eBPF, since since
sending asyncronously to a ring buffer is going to be *way* more
efficient than using the blocking ptrace(2) system call...

	       	     	 	  	    - Ted
