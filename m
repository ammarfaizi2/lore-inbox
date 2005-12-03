Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVLCSqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVLCSqG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 13:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVLCSqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 13:46:06 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:8592 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S932129AbVLCSqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 13:46:05 -0500
Date: Sat, 3 Dec 2005 19:48:19 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
cc: Bodo Eggert <7eggert@gmx.de>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       horms@verge.net.au
Subject: Re: security / kbd
In-Reply-To: <20051203181140.GA25534@apps.cwi.nl>
Message-ID: <Pine.LNX.4.58.0512031940050.3014@be1.lrz>
References: <5f6Fp-1ZB-11@gated-at.bofh.it> <E1EiLA5-0001VE-64@be1.lrz>
 <20051203013455.GB24760@apps.cwi.nl> <Pine.LNX.4.58.0512030251570.6039@be1.lrz>
 <20051203023946.GC24760@apps.cwi.nl> <Pine.LNX.4.58.0512030616230.6684@be1.lrz>
 <20051203144659.GA2091@apps.cwi.nl> <Pine.LNX.4.58.0512031650450.2051@be1.lrz>
 <20051203181140.GA25534@apps.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Dec 2005, Andries Brouwer wrote:
> On Sat, Dec 03, 2005 at 06:19:47PM +0100, Bodo Eggert wrote:

> > > But there are many ways of using such a file descriptor.
> > > This patch cripples the keymap changing but does not solve anything.
> > 
> > Obviously it solves only a part. OTOH you can't keep an exploit open just 
> > because there is another exploit.
> > Like I said, use chmod u+s loadkeys.
> 
> Hmm. There is an obscure security problem. It was fixed in a bad way -
> people want to say unicode_start and unicode_stop and find that that
> fails today. Ach.
> 
> You argue "you can't keep an exploit open" - but as far as I can see
> there is no problem that needs solving in kernel space.
> For example - today login does a single vhangup() for the login tty.
> In case that is a VC it could do a vhangup() for all VCs.
> That looks like a better solution.

I tried this, but 
1) vhangup doesn't seem to close file descriptors, so it won't help 
   against the exploit
2) even if it did, the behaviour you described would kill all console
   sessions at once when you terminate one, which is very undesirable
3) it wouldn't prevent sb from running 'exec sleep 2147483647' and
   changing to another console hoping nobody notices.

> And "chmod u+s loadkeys" - you can't be serious..

Allow the specific commmands by sudo/su1.
-- 
Top 100 things you don't want the sysadmin to say:
71. Ooops.
