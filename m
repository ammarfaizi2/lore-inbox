Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422633AbWCIEeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422633AbWCIEeH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 23:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422632AbWCIEeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 23:34:06 -0500
Received: from detroit.securenet-server.net ([209.51.153.26]:38586 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S1422630AbWCIEeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 23:34:04 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
Date: Wed, 8 Mar 2006 20:34:00 -0800
User-Agent: KMail/1.9.1
Cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       mingo@redhat.com, Alan Cox <alan@redhat.com>, linuxppc64-dev@ozlabs.org
References: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org> <17423.32792.500628.226831@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0603081716400.32577@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603081716400.32577@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603082034.00238.jbarnes@virtuousgeek.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - detroit.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - virtuousgeek.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 08, 2006 5:27 pm, Linus Torvalds wrote:
> That said, when I heard of the NUMA IO issues on the SGI platform, I
> was initially pretty horrified. It seems to have worked out ok, and
> as long as we're talking about machines where you can concentrate on
> validating just a few drivers, it seems to be a good tradeoff.

It's actually not too bad.  We tried hard to make the arch code support 
the semantics that Linux drivers expect.  mmiowb() was an optimization 
we added (though it's much less of an optimization than read_relaxed() 
was) to make things a little faster.  Like you say, the alternative was 
to embed the same functionality into spin_unlock or something (IRIX 
actually had an io_spin_unlock that did that iirc), but that would mean 
an MMIO access on every unlock, which would be bad.

So ultimately mmiowb() is the only thing drivers really have to care 
about on Altix (assuming they do DMA mapping correctly), and the rules 
for that are fairly simple.  Then they can additionally use 
read_relaxed() to optimize performance a bit (quite a bit on big 
systems).

> Would I want the hard-to-think-about IO ordering on a regular desktop
> platform? No.

I guess you don't want anyone to send you an O2 then? :)

Jesse
