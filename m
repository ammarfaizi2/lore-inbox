Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbTKNOBw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 09:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTKNOBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 09:01:52 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:7603
	"EHLO x30.random") by vger.kernel.org with ESMTP id S262433AbTKNOBv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 09:01:51 -0500
Date: Fri, 14 Nov 2003 15:01:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>, Davide Libenzi <davidel@xmailserver.org>,
       Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031114140124.GQ1649@x30.random>
References: <3FAFD1E5.5070309@zytor.com> <Pine.LNX.4.44.0311101004150.2097-100000@bigblue.dev.mdolabs.com> <20031110183722.GE6834@x30.random> <3FAFE22B.3030108@zytor.com> <20031110193101.GF6834@x30.random> <20031114051300.GA3466@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031114051300.GA3466@pimlott.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 12:13:00AM -0500, Andrew Pimlott wrote:
> For transparency, I would change the file contents to "updating"
> during an update, instead of the even-odd thing.  I think this will
> make it more obvious to people how to use it properly.

we've more solutions now. The file contents to "updating" would work too
but I believe it would be by far the most complicated, the md5sum has
the advantage of valiating the file contents too and it only requires 1
file update to be atomic, no matter how the upload of the data paylod
happens, so I tend to like it most even if it only works
probabilitsically (but it's sure safe enough).

However I understand Larry has no real interest in helping us to
rsync a known to be coherent copy of the repository (very understandable
from his own business standpoint), so I guess this is all wasted time,
and we've to live with an heuristic like:

       1:rsync
	sleep 60
	rsync -> if something changed goto 1

I doubt Peter can provide the coherency guarantee with the md5sum on his
side, unless it's Peter fetching the update of the scm data, and not the
other way around.
