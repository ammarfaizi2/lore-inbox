Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbVLCVoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVLCVoE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 16:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVLCVoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 16:44:04 -0500
Received: from hera.cwi.nl ([192.16.191.8]:57319 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S1751295AbVLCVoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 16:44:03 -0500
Date: Sat, 3 Dec 2005 22:43:49 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, horms@verge.net.au
Subject: Re: security / kbd
Message-ID: <20051203214349.GB26620@apps.cwi.nl>
References: <5f6Fp-1ZB-11@gated-at.bofh.it> <E1EiLA5-0001VE-64@be1.lrz> <20051203013455.GB24760@apps.cwi.nl> <Pine.LNX.4.58.0512030251570.6039@be1.lrz> <20051203023946.GC24760@apps.cwi.nl> <Pine.LNX.4.58.0512030616230.6684@be1.lrz> <20051203144659.GA2091@apps.cwi.nl> <Pine.LNX.4.58.0512031650450.2051@be1.lrz> <20051203181140.GA25534@apps.cwi.nl> <Pine.LNX.4.58.0512031940050.3014@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0512031940050.3014@be1.lrz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 07:48:19PM +0100, Bodo Eggert wrote:

> > You argue "you can't keep an exploit open" - but as far as I can see
> > there is no problem that needs solving in kernel space.
> > For example - today login does a single vhangup() for the login tty.
> > In case that is a VC it could do a vhangup() for all VCs.
> > That looks like a better solution.
> 
> I tried this, but 
> 1) vhangup doesn't seem to close file descriptors, so it won't help 
>    against the exploit

Yes, it does. The permission test was

	current->signal->tty == tty

and even if the file descriptor may still be open, after a vhangup
the loadkeys call fails.

> 2) even if it did, the behaviour you described would kill all console
>    sessions at once when you terminate one, which is very undesirable

Your definition of desirable is not mine. In all cases it is bad
to put policy in the kernel. Policy belongs in user space.
