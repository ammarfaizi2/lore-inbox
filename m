Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUFBQig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUFBQig (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 12:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbUFBQig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 12:38:36 -0400
Received: from [209.101.250.228] ([209.101.250.228]:43913 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S263555AbUFBQic convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 12:38:32 -0400
Subject: Re: NFS client behavior on close
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Simon Kirby <sim@netnation.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040602154146.GA2481@netnation.com>
References: <20040531213820.GA32572@netnation.com>
	 <1086159327.10317.2.camel@lade.trondhjem.org>
	 <20040602154146.GA2481@netnation.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1086194307.17378.106.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 02 Jun 2004 09:38:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På on , 02/06/2004 klokka 08:41, skreiv Simon Kirby:

> In that case, is there any reason why we would ever want to wait
> before sending data to the server, except for a minimal time to allow
> merging into wsize blocks?  With no delay, avoiding the write to disk
> for temporary files can still happen on the server side (async). 

NO! async is a stupidity that was introduced in order to get round the
fact that NFSv2 had no server-side equivalent of the "fsync()" command.
Async breaks O_SYNC writes, fsync(), sync(), ... Most importantly, it
removes all the normal guarantees that clients can recover safely if the
server reboots or crashes.

<RANT>I find it hard to understand how people, who would normally scream
if you told them that "fsync()" on their desktop PC was broken and
didn't actually flush data to disk, can find it quite acceptable as long
as it's "only" their central storage units that are broken in the same
way.</RANT>

In any case, the performance benefit of using "async" should be very
small these days.

> Mass file writes from a single thread should be faster if the client
> write buffering is minimized.

Not necessarily. Consider the case of a random workload in which you
touch the same page more than once. Why then flush those same pages out
to disk more than once?

Cheers,
  Trond
