Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310430AbSCGR76>; Thu, 7 Mar 2002 12:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310433AbSCGR7s>; Thu, 7 Mar 2002 12:59:48 -0500
Received: from dsl-213-023-043-059.arcor-ip.net ([213.23.43.59]:48053 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S310430AbSCGR7h>;
	Thu, 7 Mar 2002 12:59:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] Arch option to touch newly allocated pages
Date: Thu, 7 Mar 2002 18:54:05 +0100
X-Mailer: KMail [version 1.3.2]
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), yodaiken@fsmlabs.com,
        jdike@karaya.com (Jeff Dike), bcrl@redhat.com (Benjamin LaHaise),
        hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <E16j0by-0002lS-00@the-village.bc.nu>
In-Reply-To: <E16j0by-0002lS-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16j25d-00039y-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 7, 2002 05:19 pm, Alan Cox wrote:
> > Higher order allocation - imho we can fix that too, eventually, however it's a lot
> > more work.  First we have to have reliable physical defragmentation.
> > 
> > > And if we are OOM - we want to return NULL
> > 
> > What good does that do?
> 
> It allows us to continue. It avoids the deadlocks.

Could you describe the deadlock, please?

> It lets the caller make an intelligent decision.

I maintain it's the wrong interface, we're mixing two concepts together there:

  - VM can't find blocks that are freeable, so fails and dumps the problem
    on the caller, which has to busy wait.  This sucks.

  - The VM is under heavy load and the caller doesn't really need the memory
    that badly because it has a fallback, the VM somehow knows this, so fails
    the allocation and everybody is happy.

These should be separated, and we should fix the former.

-- 
Daniel
