Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263326AbUCPBpj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUCPBmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:42:53 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:6902 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262927AbUCPBlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 20:41:53 -0500
To: "Woodruff, Robert J" <woody@co.intel.com>
Cc: "Greg KH" <greg@kroah.com>, "Woodruff, Robert J" <woody@jf.intel.com>,
       <linux-kernel@vger.kernel.org>, "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
References: <1AC79F16F5C5284499BB9591B33D6F000B4805@orsmsx408.jf.intel.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 15 Mar 2004 17:41:50 -0800
In-Reply-To: <1AC79F16F5C5284499BB9591B33D6F000B4805@orsmsx408.jf.intel.com>
Message-ID: <52oeqxo9ep.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Mar 2004 01:41:50.0908 (UTC) FILETIME=[DA4FCFC0:01C40AF7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I understand that you've only had a short time to review the code, and
many of your comments are points well taken.  I think most of the
technical comments can wait to be debated on the openib.org mailing
lists (which I am assured are coming soon).  However, since this is
being preserved for posterity in the linux-kernel archive, I wanted to
correct a few inaccuracies.

    Robert> 3.) The code is not compliant with the InfiniBand
    Robert> specification and has proprietary implementations of
    Robert> things like "path records" so it will only work with the
    Robert> TopSpin subnet manager that requires you to buy a topspin
    Robert> switch.

This is definitely not our intent, and we fix whatever IB compliancy
bugs we find as soon as we know about them.  In addition, I know that
people have been able to use the Topspin/Mellanox code from OpenIB
with OpenSM and no Topspin switch (this did require some compliance
fixes to both OpenSM and the Topspin code).

    Robert> 6.)The VAPI code has extra propietary verbs that are not
    Robert> specified by the InfiniBand Specification.

True, but I'm not sure why this is a deficiency.  We found certain
things that were required for good performance were not specified by
the IBTA, and we added them.  The Linux way is definitely not to
follow a spec when the spec is wrong.

    Robert> 9.) The CM does not support reliable datagrams.

Fair enough but I'm sure we can easily add RD support before any
hardware supporting RD is ready.  We took a pragmatic approach and
didn't implement "speculative" features.

    Robert> 10) There is no built in support for plug and play events,
    Robert> port up/down, LID change, SM change

I'm not sure what plug and play events are (certainly they're not part
of the IB spec).  However, we did add extended IB asynchronous events
for LID/SM changes and P_Key changes (port up and down are already
part of the IB spec).

As I said above, the rest of your points are well taken (although of
course there are two sides to every story) and we can talk about them
when we get the openib.org mailing lists up.

 - Roland
