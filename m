Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271278AbTHRGoH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 02:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271279AbTHRGoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 02:44:07 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:14066 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S271278AbTHRGoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 02:44:05 -0400
Date: Mon, 18 Aug 2003 00:43:13 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, tytso@mit.edu, jmorris@intercode.com.au,
       jamie@shareable.org, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030818004313.T3708@schatzie.adilger.int>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Andrew Morton <akpm@osdl.org>, tytso@mit.edu,
	jmorris@intercode.com.au, jamie@shareable.org,
	linux-kernel@vger.kernel.org, davem@redhat.com
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030815221211.GA4306@think> <20030815235501.GB325@waste.org> <20030815170532.06e14e89.akpm@osdl.org> <20030816043816.GC325@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030816043816.GC325@waste.org>; from mpm@selenic.com on Fri, Aug 15, 2003 at 11:38:16PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 15, 2003  23:38 -0500, Matt Mackall wrote:
> a) extract_entropy (pool->lock)
> 
>  For nitpickers, there remains a vanishingly small possibility that
>  two readers could get identical results from the pool by hitting a
>  window immediately after reseeding, after accounting, _and_ after
>  feedback mixing.

It wasn't even vanishingly small...  We had a problem in our code where
two readers got the same 64-bit value calling get_random_bytes(), and
we were depending on this 64-bit value being unique.  This problem was
fixed by putting a spinlock around the call to get_random_bytes().

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

