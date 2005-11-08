Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbVKHDpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbVKHDpq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 22:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVKHDpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 22:45:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38040 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932431AbVKHDpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 22:45:44 -0500
Date: Mon, 7 Nov 2005 19:45:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Neil Brown <neilb@suse.de>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Subject: Re: [OT] Re: [PATCH 3/18] allow callers of seq_open do allocation
 themselves
In-Reply-To: <17264.6769.472245.973213@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.64.0511071937130.3247@g5.osdl.org>
References: <E1EZInj-0001Eh-9T@ZenIV.linux.org.uk> <20051107190340.129bc8c3.rdunlap@xenotime.net>
 <17264.6769.472245.973213@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Nov 2005, Neil Brown wrote:
> On Monday November 7, rdunlap@xenotime.net wrote:
> > 
> > What format is that date in, please?
> 
>  %s %z
> 
> (as date(1) understands it).

Yes. It happens to be one of the formats git understands, and is also 
the least ambiguous. 

> Or was this a rhetorical question, meaning to say "Who in their right
> mind would used that sort of date format on a public mailing list?" :-)

Yeah, it's really only machine-readable. In this case git-readable, 
although git will accept dates in almost any format.

It happens to be the format internally used by git, since it's easy to 
parse and you can't get it wrong.

It may be a mistake to expose it outside in that format, though. The git 
"format patch as email" script will just use the internal date format, 
which is nice from a "you can't get it wrong" angle, but arguably not very 
human-friendly.

Not being able to get it wrong by converting it to a human-readable format 
and then converting it back is a pretty big advantage, though (it's damn 
easy to screw up summer-time and timezone when converting to/from UTC: 
the "%s %z" format doesn't leave any confusion: the seconds is always 
since the epoch in UTC, and the %z is purely informational to tell in 
which timezone the change was made).

			Linus
