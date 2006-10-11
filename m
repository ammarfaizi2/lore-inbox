Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161170AbWJKRzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161170AbWJKRzX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 13:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161171AbWJKRzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 13:55:22 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:58598 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1161170AbWJKRzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 13:55:21 -0400
Subject: Re: [patch 0/2] Introduce round_jiffies() to save spurious wakeups
From: Arjan van de Ven <arjan@linux.intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
In-Reply-To: <20061011172331.GA13099@infradead.org>
References: <1160496165.3000.308.camel@laptopd505.fenrus.org>
	 <20061011172331.GA13099@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 11 Oct 2006 19:54:57 +0200
Message-Id: <1160589297.3000.389.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 18:23 +0100, Christoph Hellwig wrote:
> On Tue, Oct 10, 2006 at 06:02:45PM +0200, Arjan van de Ven wrote:
> > Hi,
> > 
> > the following 2 patches will introduce the round_jiffies() api and users
> > thereof. 
> > 
> > The general idea is that by rounding the jiffies for certain timers to
> > the next whole second will make those timers all happen at the same
> > time; and thus reduce the number of times the cpu has to wake up to
> > service timers (this assumes a tickless kernel)
> > 
> > Obviously only timers where the exact time of firing isn't so important
> > can do this; several of the recurring "always live" timers of the kernel
> > are of this kind, they want "about once a second" or "about once every 4
> > seconds" and such, and don't really care about the exact jiffy in which
> > they fire.
> > 
> > An alternative would have been to introduce mod_timer_rounded() or
> > somesuch APIs (but there's many variants that take jiffies); I feel that
> > an explicit caller based rounding actually is quite reasonable.
> 
> I think the API you proposed is horrible.  Having jiffies exposed in
> ani API is a mistake, and adding more makes this problem worse.  

and other people like Linus disagree with you.

> I'd suggest
> to start with Alan's patches that add a timer variant that takes a miliseconds
> argument instead of jiffies and add a _rounded varaint to it that has
> a new parameter that specifies the precision.

it's half a solution; there's many apis that currently take either
absolute or relative jiffies, and want rounding. Duplicating that lot
doesn't look like the best idea either...

