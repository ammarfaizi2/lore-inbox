Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270566AbTGNIGU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 04:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270567AbTGNIGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 04:06:20 -0400
Received: from [81.2.110.254] ([81.2.110.254]:12793 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S270566AbTGNIEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 04:04:55 -0400
Subject: RE: [Patch][RFC] epoll and half closed TCP connections
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: David Schwartz <davids@webmaster.com>, Jamie Lokier <jamie@shareable.org>,
       Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0307131605480.15022@bigblue.dev.mcafeelabs.com>
References: <MDEHLPKNGKAHNMBLJOLKEEFKEFAA.davids@webmaster.com>
	 <Pine.LNX.4.55.0307131605480.15022@bigblue.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058170455.561.30.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jul 2003 09:14:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-14 at 00:09, Davide Libenzi wrote:
> On Sun, 13 Jul 2003, David Schwartz wrote:
> 
> > 	It's not O(N) with 'poll' and 'select'. Twice as many file descriptors
> > means twice as many active file descriptors which means twice as many
> > discovered per call to 'poll'. If the calls to 'poll' are further apart
> 
> It is O(N), if N if the number of fds queried. The poll code does "at least"
> 2 * N loops among the set (plus other stuff), and hence it is O(N). Even
> if you do N "nop" in your implementation, this becomes O(N) from a
> mathematical point of view.

You need to apply queue theory and use a model of the distribution of
data arrival on the inputs/outputs to actually tell. The its O(N) claim
is like most such claims and probably only useful if data arrives
infinitely slowly and you have infinite ram and cache is not a factor.

For some loads poll/select are actually extremely efficient. X clients
batch commands up and there is a cost to switching between tasks for
different clients. Viewed as an entire system you actually get quite
interesting little graphs, especially in the critical load cases where
select/poll's batching effect makes throughput increase rapidly at 100%
CPU load, even if it gets you there far too early. Ditto with
webservers.

