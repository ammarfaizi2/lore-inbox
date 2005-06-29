Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262654AbVF2U6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbVF2U6e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 16:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVF2U6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 16:58:34 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:32483 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262644AbVF2U5B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 16:57:01 -0400
X-ORBL: [63.202.173.158]
Date: Wed, 29 Jun 2005 13:56:41 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Steve Lord <lord@xfs.org>
Cc: Al Boldi <a1426z@gawab.com>, "'Nathan Scott'" <nathans@sgi.com>,
       linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: XFS corruption during power-blackout
Message-ID: <254889.27725ab660aa106eb6acc07307d71ef1fbd5b6fd366aebef9e2f611750fbcb467e46e8a4.IBX@taniwha.stupidest.org>
References: <20050629001847.GB850@frodo> <200506290453.HAA14576@raad.intranet> <556815.441dd7d1ebc32b4a80e049e0ddca5d18e872c6e8a722b2aefa7525e9504533049d801014.ANY@taniwha.stupidest.org> <42C2E0BC.8040508@xfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C2E0BC.8040508@xfs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 12:56:12PM -0500, Steve Lord wrote:

> There are also cool bits of technology which use the rotational
> energy of the spinning down drive to dump the cache out to a special
> track (or this may be an urban legend, not sure).

This seems only to be true for very small writes.  I suspect on power
loss a drive and finish writing the current sector.

Anyhow, I've tested power loss on drives with caching enabled and they
definatley do lose data.  Sometimes a couple of MBs worth.

I don't know if this is true for all drives but NONE of the ones I had
access to when testing did anything like save the cache --- pretty
much all data that was inflight got lost.

> I did spend a bunch of time once ensuring that when you typed sync
> on xfs you could pull the power right after that and everything from
> before the sync survived.

I think this is probably still true.  If I sync then drop power I
don't seem to have any problems provided caching is off.

If caching is enabled I still lose data.  Linux does have a concept of
write barriers but these are presently not implemented for XFS right
now.  Once they are I assume sunc + poweroff will be reliable with
caching enabled.
