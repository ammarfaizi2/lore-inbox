Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269641AbTGOUPJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 16:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269645AbTGOUPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 16:15:09 -0400
Received: from code.and.org ([63.113.167.33]:29902 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id S269641AbTGOUPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 16:15:06 -0400
To: "David Schwartz" <davids@webmaster.com>
Cc: "Davide Libenzi" <davidel@xmailserver.org>,
       "Eric Varsanyi" <e0206@foo21.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
References: <MDEHLPKNGKAHNMBLJOLKGEFKEFAA.davids@webmaster.com>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 15 Jul 2003 16:27:56 -0400
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGEFKEFAA.davids@webmaster.com>
Message-ID: <m3y8yz3583.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Schwartz" <davids@webmaster.com> writes:

> 	This is really just due to bad coding in 'poll', or more precisely very bad
> for this case. For example, why is it allocating a wait queue buffer if the
> odds that it will need to wait are basically zero? Why is it adding file
> descriptors to the wait queue before it has determined that it needs to
> wait?

 Because this is much easier to do in userspace, it's just not very
well documented that you should almost always call poll() with a zero
timeout first. However it's been there for years, and things have used
it[1].
 There are still optimizations that could have been done to poll() to
speed it up but Linus has generally refused to add them.

[1] http://www.and.org/socket_poll/

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
