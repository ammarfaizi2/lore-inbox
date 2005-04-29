Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbVD2QL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbVD2QL0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 12:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVD2QL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 12:11:26 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:14217
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262811AbVD2QGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 12:06:16 -0400
Date: Fri, 29 Apr 2005 08:56:30 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Andrew Morton <akpm@osdl.org>
Cc: hubert.tonneau@fullpliant.org, linux-kernel@vger.kernel.org,
       Eric.Moore@lsil.com, jgarzik@pobox.com
Subject: Re: 2.6 upgrade overall failure report
Message-Id: <20050429085630.7290e0da.davem@davemloft.net>
In-Reply-To: <20050429021756.7bd5535f.akpm@osdl.org>
References: <055FPDS12@server5.heliogroup.fr>
	<20050429021756.7bd5535f.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2005 02:17:56 -0700
Andrew Morton <akpm@osdl.org> wrote:

> >  . There is still a memory leak trouble (probably in tigon3 driver since others
> >    reported so on kernel mailing list, and tigon3 is not a geek hardware since
> >    most nowdays lowend servers use either tigon3 or pro1000)
> 
> Please send a report to David Miller and Jeff Garzik and cc netdev@oss.sgi.com

This is the first I've ever heard of any such leak, more likely
the leak is in the networking code somewhere.

> >  . Since 2.6.10, the TCP task does not work anymore with OSX (2 Mbps instead
> >    of 60 Mbps on a 100 Mbps wire)
> 
> Please send a full report to David Miller and cc netdev@oss.sgi.com.
> 
> Also please describe a simple way of reproducing this - I'll see if it
> happens here.

It only happens with OS-X and it has to do with how they handle the fast
path of TCP input.  It's a known problem but no satisfatory solution
exists yet.  When the fast path in OS-X TCP input is hit, they always
delay ACKs by a full 500ms, there isn't much Linux can do about broken
behavior like that.

We are thinking of possible workarounds, but this bug is very low priority
since it is really a MAC OS-X issue.

Anyways, I'm in Chicago until Monday so won't be able to look into anything
in detail until then.
