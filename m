Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbUJ0Gul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbUJ0Gul (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbUJ0Gul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:50:41 -0400
Received: from ozlabs.org ([203.10.76.45]:5837 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262317AbUJ0Gqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:46:51 -0400
Date: Wed, 27 Oct 2004 16:45:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linux-kernel@vger.kernel.org
Subject: MAP_SHARED bizarrely slow
Message-ID: <20041027064527.GJ1676@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.ozlabs.org/people/dgibson/maptest.tar.gz

has a small set of test programs which perform a naive matrix multiply
in memory obtained by several different methods:  one is
MAP_PRIVATE|MAP_ANONYMOUS, one is MAP_SHARED|MAP_ANONYMOUS and the
third attempts to map from hugetlbfs.

On a number of machines I've tested - both ppc64 and x86 - the SHARED
version is consistently and significantly (50-100%) slower than the
PRIVATE version.  Increasing the matrix size does not appear to make
the situation significantly better.  The routine that does the actual
multiply is identical (same .o) in each case, only a wrapper which
allocates memory is different.

I am at a complete loss to explain this behaviour, and I'm sure it
didn't use to happen (unfortunately I can't remember what kernel
version we were on at the time).  oprofile appears to show essentially
all the time is taken in userspace in both cases.  Can anyone explain
what's going on?

I've also seen anomolies with the hugepage version, but it seems to be
less consistent.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
