Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263618AbVAFP3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbVAFP3A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbVAFP3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:29:00 -0500
Received: from sommereik.ii.uib.no ([129.177.16.236]:45014 "EHLO
	sommereik.ii.uib.no") by vger.kernel.org with ESMTP id S262883AbVAFP1g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:27:36 -0500
Date: Thu, 6 Jan 2005 16:17:26 +0100
From: Jan-Frode Myklebust <Jan-Frode.Myklebust@bccs.uib.no>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com, Eirik Thorsnes <eithor@ii.uib.no>,
       smfrench@austin.rr.com, matthew@wil.cx
Subject: Re: panic - Attempting to free lock with active block list
Message-ID: <20050106151726.GB24796@ii.uib.no>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
	linux-xfs@oss.sgi.com, Eirik Thorsnes <eithor@ii.uib.no>,
	smfrench@austin.rr.com, matthew@wil.cx
References: <20050105195736.GA26989@ii.uib.no> <20050105123207.J469@build.pdx.osdl.net> <1104962043.5717.28.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104962043.5717.28.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 10:54:03PM +0100, Trond Myklebust wrote:
> 
> Looking at the NFS code, I can attempt a wild guess about what may be
> happening: there may be a race when pressing ^C in the middle of a
> blocking NFS lock RPC call, and if so, the following patch will fix it.


A whopping 9 hours of uptime now :) So the one-liner patch seems to have 
fixed it.

Thanks!

> -			posix_lock_file(filp, fl);
> +			posix_lock_file_wait(filp, fl);


  -jf
