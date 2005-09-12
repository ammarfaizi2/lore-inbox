Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbVILRIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVILRIK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 13:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVILRIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:08:10 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:53207 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932103AbVILRIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:08:09 -0400
Date: Mon, 12 Sep 2005 19:07:42 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Paul Jackson <pj@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
In-Reply-To: <20050912075155.3854b6e3.pj@sgi.com>
Message-ID: <Pine.LNX.4.61.0509121821270.3743@scrub.home>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
 <20050912043943.5795d8f8.akpm@osdl.org> <20050912075155.3854b6e3.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 12 Sep 2005, Paul Jackson wrote:

> I've got paths in __alloc_pages() and below that acquire cpuset_sem,
> but only rarely.  I am not aware of any other global kernel lock
> that routinely shows up both _above_ and _below_ __alloc_pages on
> the stack.  Normally such would be a big problem for numa scaling.
> This one avoids the scaling problem by only being on rare paths when
> called within __alloc_pages.  But that means I can't test for bugs;
> I have to code so it is obviously right in the first place (not a
> bad idea in general ;).

Maybe I'm missing something, but why don't you use two locks?
One general management lock to create/insert/remove cpusets and a 
low-level lock (maybe even a spinlock) which manages the state of an 
active cpuset.
For that you have to figure out (and document) how the fields in the 
cpuset structure are used in various situations.

bye, Roman
