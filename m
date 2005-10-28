Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbVJ1HbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbVJ1HbQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbVJ1HbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:31:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14269 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965172AbVJ1HbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:31:15 -0400
Date: Fri, 28 Oct 2005 03:30:50 -0400
From: Dave Jones <davej@redhat.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 assorted warnings
Message-ID: <20051028073049.GA27389@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
References: <5455.1130484079@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5455.1130484079@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 05:21:19PM +1000, Keith Owens wrote:
 > gcc 4.0.1 on i386, 2.6.14 assorted warnings.
 > 
 > arch/i386/kernel/cpu/transmeta.c: In function 'init_transmeta':
 > arch/i386/kernel/cpu/transmeta.c:11: warning: 'cpu_freq' may be used uninitialized in this function
 > 
 > fs/bio.c: In function 'bio_alloc_bioset':
 > fs/bio.c:167: warning: 'idx' may be used uninitialized in this function

gcc is dumb, it doesn't realise that the variable will be filled by another
function if its passed thus..

	unsigned long foo
	bar(&foo)
	if (foo==1)
		...

With bar() filling in content of foo.
I believe there's at least once instance of this in gcc bugzilla.

		Dave

