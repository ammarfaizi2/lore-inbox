Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264316AbUENGxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264316AbUENGxt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 02:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264737AbUENGxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 02:53:49 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:13235 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S264316AbUENGxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 02:53:47 -0400
Date: Fri, 14 May 2004 08:53:39 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: "Y.Ishikawa" <y.ishikawa@soft.fujitsu.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [rft] testing BSD accounting format on different archs
In-Reply-To: <20040514104838.7e052881.y.ishikawa@soft.fujitsu.com>
Message-ID: <Pine.LNX.4.53.0405140833570.25886@gockel.physik3.uni-rostock.de>
References: <20040514104838.7e052881.y.ishikawa@soft.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2004, Y.Ishikawa wrote:

> Please see the attachment for details of the result of acct after applying
> your patch.

Thanks!

> BTW. how is your development for "version2" that you posted in this Mar.19.
> I have been interested in your V2 format. The account data is very 
> useful for performance analysis of processes. It would be more convenient 
> if acct datainclude pid and ppid.
> Naturally I understood V2 would have some incompatibility against current
> acct structure. However I'm sure the value of acct data would become larger
> in V2.
> I hope V2 structure would be included in 2.7 successfully.
> I also found tgid is useful in multithread environment, especially NPTL, to
> identify the thread and process of a work-unit. Could you add a tgid field
> in your V2 structure?


Unfortunaltely my day job consumes all my time until end of next week.
After that I want to hack on the GNU acct tools so they understand the new 
formats. If that doesn't raise new problems, I'll submit a patch for 2.6.

Both v1 and v2 are intended to be binary compatible, v2 on m68k, v1 on 
all other platforms (I'll probably reverse the version numbers, so that
only m68k user might get confused by thinking that v2 is "better" than 
v1)

For 2.7, (and optional for 2,6), a new v3 format is planned with a 
properly aligned layout, so that much of the compatibility cruft can go.
Since v1, v2 and v3 formats already use up all 64 bytes of struct acct,
there also has been interest in an optional 128 byte v4 format. This would 
provide enough space to include tgid (further suggestions welcome).

This may sound like a plethora of new formats, but I think it provides a 
smooth transition if just one new release of the acct tools is able to 
read all of them.

sorry for the delay,
Tim
