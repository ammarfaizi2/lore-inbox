Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbVHYNNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbVHYNNv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 09:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVHYNNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 09:13:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:18368 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964970AbVHYNNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 09:13:49 -0400
To: Ray Fucillo <fucillo@intersystems.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: process creation time increases linearly with shmem
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au>
	<430DC285.7070104@intersystems.com>
From: Andi Kleen <ak@suse.de>
Date: 25 Aug 2005 15:13:45 +0200
In-Reply-To: <430DC285.7070104@intersystems.com>
Message-ID: <p73ll2qkvli.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Fucillo <fucillo@intersystems.com> writes:
> 
> The application is a database system called Caché.  We allocate a
> large shared memory segment for database cache, which in a large
> production environment may realistically be 1+GB on 32-bit platforms
> and much larger on 64-bit.  At these sizes fork() is taking hundreds
> of miliseconds, which can become a noticeable bottleneck for us.  This
> performance characteristic seems to be unique to Linux vs other Unix
> implementations.

You could set up hugetlbfs and use large pages for the SHM (with SHM_HUGETLB);
then the overhead of walking the pages of it at fork would be much lower.

-Andi
