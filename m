Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281809AbRLQSGh>; Mon, 17 Dec 2001 13:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281795AbRLQSG1>; Mon, 17 Dec 2001 13:06:27 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:32365 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S281762AbRLQSGV>; Mon, 17 Dec 2001 13:06:21 -0500
Date: Mon, 17 Dec 2001 18:07:47 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: GOTO Masanori <gotom@debian.org>, Andrew Morton <akpm@zip.com.au>,
        Suresh Gopalakrishnan <gsuresh@cs.rutgers.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT wierd behavior..
In-Reply-To: <20011217181840.G2431@athlon.random>
Message-ID: <Pine.LNX.4.21.0112171757530.2812-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Andrea Arcangeli wrote:
> 
> I'm unsure (it's basically a matter of API, not something a kernel
> developer can choose liberally), and the SuSv2 is not saying anything about
> O_SYNC failures in the write(2) manapge, but I guess it would be at
> least saner to put the "pos" backwards if we fail osync but we just
> written something (so if we previously advanced pos).

I don't have references to back me up, don't take my word for it:
but I'm sure that the correct behaviour for a partially successful
read or write in any UNIX is that it return the count done, O_SYNC
or not, and file position should match that count; only when none
has been done is -1 returned with errno set.  Most implementations will
get this wrong in one corner or another, but that's how it should be.

Hugh

