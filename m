Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVBDGDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVBDGDw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 01:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbVBDGDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 01:03:51 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:27664 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263207AbVBDGDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 01:03:37 -0500
Date: Fri, 4 Feb 2005 07:03:28 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Ethan Weinstein <lists@stinkfoot.org>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: e1000, sshd, and the infamous "Corrupted MAC on input"
Message-ID: <20050204060328.GB1850@alpha.home.local>
References: <42019E0E.1020205@stinkfoot.org> <20050203070415.GC17460@waste.org> <4202F725.8040509@stinkfoot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4202F725.8040509@stinkfoot.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 03, 2005 at 11:16:37PM -0500, Ethan Weinstein wrote:
(...) 
> Excellent tip, thanks.  I was able to reprodce the problem several times 
> using this technique with nc, however the problem was intermittent (as 
> nasty problems like this often are).  I used a 1.3G gzipped tarball and 
>  experienced several botched transfers along with a few good ones.  To 
> be fair, I also switched back to 100Fdx and repeated; I didn't get a 
> single failure at this speed over 25 or so runs.
> 
> The results of two cmp's are here:
> 
> http://www.stinkfoot.org/e1000tests.out
> 
> What next?

I would disable rx/tx checksums on the cards to ensure that's not a bug
in this part. Because one reason to see what you encounter would be that
some frames are corrupted at gigabit speed (possibly on one of the cards
themselves), and they don't correctly compute the checksum on the receive
side, or they ignore when it's bad.

IIRC, you can do this with ethtool :

  # ethtool -K rx off tx off

Willy

