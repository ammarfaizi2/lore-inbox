Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWBVVhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWBVVhV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 16:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWBVVhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 16:37:20 -0500
Received: from pat.uio.no ([129.240.130.16]:37093 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751466AbWBVVhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 16:37:19 -0500
Subject: Re: FMODE_EXEC or alike?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Andrew Morton <akpm@osdl.org>, Oleg Drokin <green@linuxhacker.ru>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20060222195721.GC28219@fieldses.org>
References: <20060220221948.GC5733@linuxhacker.ru>
	 <20060220215122.7aa8bbe5.akpm@osdl.org>
	 <1140530396.7864.63.camel@lade.trondhjem.org>
	 <20060221232607.GS22042@fieldses.org>
	 <1140564751.8088.35.camel@lade.trondhjem.org>
	 <20060222195721.GC28219@fieldses.org>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 16:36:56 -0500
Message-Id: <1140644216.7879.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.118, required 12,
	autolearn=disabled, AWL 1.70, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 14:57 -0500, J. Bruce Fields wrote:
> On Tue, Feb 21, 2006 at 06:32:31PM -0500, Trond Myklebust wrote:
> > Hmm... I don't think you want to overload write deny bits onto
> > FMODE_EXEC. FMODE_EXEC is basically, a read-only mode, so it
> > would mean that you could no longer do something like
> > 
> >   OPEN(READ|WRITE,DENY_WRITE) 
> > 
> > which I would assume is one of the more frequent Windoze open modes.
> 
> Since exec will never use the above combination, I don't think the
> current proposal mandates any particular semantics in that case.
> 
> So I'm assuming that we could choose the semantics to fit nfsd's
> purposes.  Am I missing anything?

Yes. I'm saying that your mapping of the  NFSv4 DENY_WRITE share mode
into FMODE_EXEC will _only_ work for the specific combination
OPEN(READ,DENY_WRITE).

Basically, your proposal makes heavy assumptions on what clients will
want to use the share modes for, and will misbehave badly for any client
that breaks those assumptions.

Cheers,
  Trond

