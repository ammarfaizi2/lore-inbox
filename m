Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753788AbWKMBrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbWKMBrp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 20:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753789AbWKMBrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 20:47:45 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:39563
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1753788AbWKMBro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 20:47:44 -0500
Date: Sun, 12 Nov 2006 17:47:49 -0800 (PST)
Message-Id: <20061112.174749.30185202.davem@davemloft.net>
To: horms@verge.net.au
Cc: jeremy@goop.org, magnus.damm@gmail.com, ebiederm@xmission.com,
       magnus@valinux.co.jp, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com,
       ak@muc.de, fastboot@lists.osdl.org, anderson@redhat.com
Subject: Re: [PATCH 02/02] Elf: Align elf notes properly
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061113002301.GB3296@verge.net.au>
References: <455518C6.8000905@goop.org>
	<20061110.164349.35665774.davem@davemloft.net>
	<20061113002301.GB3296@verge.net.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horms <horms@verge.net.au>
Date: Mon, 13 Nov 2006 09:23:03 +0900

> On Fri, Nov 10, 2006 at 04:43:49PM -0800, David Miller wrote:
> > From: Jeremy Fitzhardinge <jeremy@goop.org>
> > Date: Fri, 10 Nov 2006 16:26:46 -0800
> > 
> > > David Miller wrote:
> > > > I think Elf64 notes very much would need 64-bit alignment, especially
> > > > if there are u64 objects in there.  Otherwise it would not be possible
> > > > to directly dereference such objects without taking unaligned faults
> > > > on several types of RISC cpus.
> > > >   
> > > 
> > > That doesn't appear to have been a problem.
> > 
> > We should be OK with the elf note header since n_namesz, n_descsz, and
> > n_type are 32-bit types even on Elf64.  But for the contents embedded
> > in the note, I am not convinced that there are no potential issues.
> 
> The interesting thing is that from my reading of the elf64 spec,
> name ends up being 32 bit alightned, and desc ends up being 64 bit
> aligned. Do you think the former could be a problem? I am thinking not
> as its always a string.

Right, it should be fine.
