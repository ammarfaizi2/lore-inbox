Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268767AbRG3Wvr>; Mon, 30 Jul 2001 18:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269079AbRG3Wvh>; Mon, 30 Jul 2001 18:51:37 -0400
Received: from ns.caldera.de ([212.34.180.1]:8367 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S268754AbRG3WvY>;
	Mon, 30 Jul 2001 18:51:24 -0400
Date: Tue, 31 Jul 2001 00:50:49 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Kip Macy <kmacy@netapp.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Hans Reiser <reiser@namesys.com>,
        Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org,
        Vitaly Fertman <vitaly@namesys.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010731005048.A29237@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Kip Macy <kmacy@netapp.com>, Rik van Riel <riel@conectiva.com.br>,
	Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
	Vitaly Fertman <vitaly@namesys.com>
In-Reply-To: <Pine.LNX.4.33L.0107301858350.5582-100000@duckman.distro.conectiva> <Pine.GSO.4.10.10107301538410.3195-100000@orbit-fe.eng.netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.10.10107301538410.3195-100000@orbit-fe.eng.netapp.com>; from kmacy@netapp.com on Mon, Jul 30, 2001 at 03:41:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 30, 2001 at 03:41:16PM -0700, Kip Macy wrote:
> How does compiling in debug infrastructure protect the user's data? By
> making the file system so slow that he won't use it? :-)

The <<reiserfs debugging code>> isn't debugging code in a strict sense.
It mostly it consists of sequences in the form of:

 (sometimes there is also code that the documentation states as deadlock-
 avoidance, why it is not enabled without _CHECK defined is left as
 exercise to the reader)

#ifdef CONFIG_REISERFS_CHECK
	if (condition_that_should_not_happen)
		reiserfs_panic (sb, "some_obscure_error_code");
#endif

This way the system stops with a indication of the failing component
instead of silently corrupting disk contents.  As reiserfs maintains
a log the recovery from that panic shouldn't take that long either.

(On the other hand I've seen some reiserfs systems that destroyed their
 disk contents while trying to recover.  That's a reason why I still
 can't recomend using reiserfs for anything but /tmp, test machines
 or proxy caches).

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
