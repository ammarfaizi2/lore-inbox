Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271919AbTGYDjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 23:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271920AbTGYDjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 23:39:18 -0400
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.42]:54924 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S271919AbTGYDjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 23:39:16 -0400
Date: Thu, 24 Jul 2003 23:54:08 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: Net device byte statistics
In-reply-to: <200307250437.50928.fredrik@dolda2000.cjb.net>
To: Fredrik Tolf <fredrik@dolda2000.cjb.net>,
       Bernd Eckenfels <ecki-lkm@lina.inka.de>, linux-kernel@vger.kernel.org
Message-id: <200307242354.17224.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <E19fqMF-0007me-00@calista.inka.de>
 <200307250437.50928.fredrik@dolda2000.cjb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 24 July 2003 22:37, Fredrik Tolf wrote:
> On Friday 25 July 2003 02.22, Bernd Eckenfels wrote:
> > it is for performance reasons. You can
>
> I almost thought that would be it. I do understand that that code needs to
> be really clean, but, correct me if I'm wrong, but isn't GCC's long long
> implementation efficient enough to only add minimal overhead to that? On
> IA32, it shouldn't take more than one or two more instructions (per
> counter),

That is the problem. Nobody can tell what is going to happen between those 
extra instructions. The worst case scenario would be statistics off by 4GB.

> and it seems to me that net_device_stats should still be small
> enough to avoid any more cache misses.
> I'm no expert, of course, so if I'm wrong, please tell me.
>
> > a) collect your numbers more often and asume wrap/reboot  if numbers
> > decrease
> > b) use iptables counters instead
>
> Currently, I'm sampling once a day, and although sampling more often could,
> of course, solve the problem, it's just that I don't think that it should
> be necessary.

There needs to be an implementation that is very friendly to the performance.

> Do the iptables counters take the whole packet into account, or do they
> ignore the ethernet header?

I have no idea.

> > BTW: it is a very often discussed topic, personally (as net tools
> > maintainer) I would love to see 64bit counters here, but this still means
> > you have to sample often enough, so you do not lose numbers on crash.
>
> While that is true in theory, I'm just using it to estimate my home net
> usage, and my router hasn't crashed this far, so I'm not very worried about
> that.
>
> Thank you very much for your input. For now, I'm just going to implement 64
> bit counters in my kernel.

May I ask how and which kernel version?

Jeff.

- -- 
A lot of my debugging happens in the shower.
		- Zwane Mwaikambo
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IKnowFP0+seVj/4RAp5xAJ48QIdsoo2uzZMoARh3pXeLa3ZgoACgnKSG
X9bSWvQu0u3s1jWYdN7+Dxk=
=PNeu
-----END PGP SIGNATURE-----

