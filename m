Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbVHKOVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbVHKOVA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbVHKOVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:21:00 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:17839 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1750975AbVHKOU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:20:59 -0400
Date: Thu, 11 Aug 2005 10:20:47 -0400
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Michael Kerrisk <mtk-lkml@gmx.net>, peterc@gelato.unsw.edu.au,
       linux-kernel@vger.kernel.org, sfr@canb.auug.org.au, matthew@wil.cx,
       michael.kerrisk@gmx.net
Subject: Re: fcntl(F GETLEASE) semantics??
Message-ID: <20050811142047.GE10030@fieldses.org>
References: <1123764552.8251.43.camel@lade.trondhjem.org> <994.1123766559@www9.gmx.net> <1123769192.8251.75.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123769192.8251.75.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 10:06:31AM -0400, Trond Myklebust wrote:
> The NFSv4 spec explicitly states that
> 
>   When a client has a read open delegation, it may not make any changes
>   to the contents or attributes of the file but it is assured that no
>   other client may do so.

I don't understand the motivation for that requirement.  As long as the
server sends write opens to the server, and doesn't try to cache them
locally, I don't see why it shouldn't be left up to the server whether
to allow writes on a read-delegated file.

> so NFSv4 cannot currently support this behaviour. If CIFS supports it,
> then maybe we have a case for going to the IETF and asking for a
> clarification to implement the same behaviour in NFSv4.

I think we could implement the correct NFSv4 delegation behaviour using
either lease semantic.

In any case, I haven't seen a real argument for reverting to the old
behaviour.  I'd rather see an established standard, or a correct
real-world application that fails, not just some arbitrary test.

--b.
