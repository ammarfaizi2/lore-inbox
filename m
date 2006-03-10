Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752033AbWCJTS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbWCJTS6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 14:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbWCJTS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 14:18:58 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38600 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1752033AbWCJTS5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 14:18:57 -0500
Date: Fri, 10 Mar 2006 19:18:42 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Carlos Munoz <carlos@kenati.com>
Cc: Denis Vlasenko <vda@ilport.com.ua>, Lee Revell <rlrevell@joe-job.com>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
       alsa-devel <alsa-devel@lists.sourceforge.net>
Subject: Re: How can I link the kernel with libgcc ?
Message-ID: <20060310191842.GY27946@ftp.linux.org.uk>
References: <4410D9F0.6010707@kenati.com> <1141961152.13319.118.camel@mindpipe> <4410F6CB.8070907@kenati.com> <200603101237.35687.vda@ilport.com.ua> <4411BF8E.4080306@kenati.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4411BF8E.4080306@kenati.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 10:03:58AM -0800, Carlos Munoz wrote:
> >               ydef[22] = (u_int32_t)(log10((double)(over & 0x0000003f)) /
> >                                      log10(2));

You've got to be kidding.  Let's take a good look at that expression:
log10(x)/log10(2) is what?  Right, base-2 logarithm of x.  Then you cast
it to unsigned, i.e. round it down.  In other words, you want to know the
highest bit in (over & 0x3f).  Which is to say, (fls(over & 0x3f) - 1).
Sigh...
