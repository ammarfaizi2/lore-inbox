Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWBFSMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWBFSMp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWBFSMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:12:45 -0500
Received: from mail.suse.de ([195.135.220.2]:13759 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932239AbWBFSMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:12:44 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes 2.6.16-rc1[2] on 2 node X86_64
Date: Mon, 6 Feb 2006 19:12:30 +0100
User-Agent: KMail/1.8.2
Cc: discuss@x86-64.org, bharata@in.ibm.com, linux-kernel@vger.kernel.org
References: <20060205163618.GB21972@in.ibm.com> <200602051803.59437.ak@suse.de> <Pine.LNX.4.62.0602060807530.15863@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602060807530.15863@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602061912.31508.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 17:11, Christoph Lameter wrote:
> On Sun, 5 Feb 2006, Andi Kleen wrote:
> 
> > > The kernel crashes when I run an application which does:
> > > 	- mmap (0, size, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS)
> > > 	- mbind the memory to the 1st node with policy MPOL_BIND
> > > 	- write to that memory
> 
> Tried the following code on rc1 and rc2 and it worked fine on ia64:

Perhaps it depends on if the node has enough memory free or not?
I assume if the zonelist has some issue but the first entry is ok
it will only cause problems when the allocation has to go off node
(it shouldn't actually go off node with that policy of course,
but with a full free local node that code path is never triggered)

-Andi

