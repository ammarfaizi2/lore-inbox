Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVDZPZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVDZPZF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVDZPZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:25:04 -0400
Received: from mail.shareable.org ([81.29.64.88]:12201 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261581AbVDZPYm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:24:42 -0400
Date: Tue, 26 Apr 2005 16:24:34 +0100
From: Jamie Lokier <jamie@shareable.org>
To: John Stoffel <john@stoffel.org>
Cc: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>, Ville Herva <v@iki.fi>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
Message-ID: <20050426152434.GB14297@mail.shareable.org>
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com> <20050426134629.GU16169@viasys.com> <20050426141426.GC10833@mail.shareable.org> <426E4EBD.6070104@oktetlabs.ru> <20050426143247.GF10833@mail.shareable.org> <17006.22498.394169.98413@smtp.charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17006.22498.394169.98413@smtp.charter.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Stoffel wrote:
> >>>>> "Jamie" == Jamie Lokier <jamie@shareable.org> writes:
> 
> Jamie> No.  A transaction means that _all_ processes will see the
> Jamie> whole transaction or not.
> 
> This is really hard.  How do you handle the case where process X
> starts a transaction modifies files a, b & c, but process Y has file b
> open for writing, and never lets it go?  Or the file gets unlinked?  

Then it starts to depend on what kind of transactions you want to
implement.

You can say that a transaction isn't allowed when a process has one of
the files opened for writing.  Or you can say a transaction is
equivalent to calling all of the I/O system calls at once.  You can
also decide if you want the reads and directory lookups performed in
the transactions to become prerequisites for the transaction
completing (so it's aborted if another process writes to those file
regions or changes the directory structure in a way which breaks a
prerequisite), or if you want those to lock the things which are read
for the duration of the transaction, or even just ignore reads for
transaction purposes.  Or, you can say that transactions are limited
to just directory structure, and not file contents (that's good enough
for package management), or you can say they're limited to just file
contents (that's good enough for databases and text file edits).

Etc, etc, quite a lot of semantic choices.

> What about programs that are already open and running?  
> 
> It might be doable in some sense, but I can see that details are
> really hard to get right.  Esp without breaking existing Unix
> semantics.  

It's even harder without kernel support! :)

-- Jamie
