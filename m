Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422934AbWKKAnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422934AbWKKAnt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 19:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424467AbWKKAnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 19:43:49 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:19632
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422934AbWKKAnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 19:43:49 -0500
Date: Fri, 10 Nov 2006 16:43:49 -0800 (PST)
Message-Id: <20061110.164349.35665774.davem@davemloft.net>
To: jeremy@goop.org
Cc: magnus.damm@gmail.com, horms@verge.net.au, ebiederm@xmission.com,
       magnus@valinux.co.jp, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com,
       ak@muc.de, fastboot@lists.osdl.org, anderson@redhat.com
Subject: Re: [PATCH 02/02] Elf: Align elf notes properly
From: David Miller <davem@davemloft.net>
In-Reply-To: <455518C6.8000905@goop.org>
References: <45550D2F.2070004@goop.org>
	<20061110.153930.23011358.davem@davemloft.net>
	<455518C6.8000905@goop.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Fitzhardinge <jeremy@goop.org>
Date: Fri, 10 Nov 2006 16:26:46 -0800

> David Miller wrote:
> > I think Elf64 notes very much would need 64-bit alignment, especially
> > if there are u64 objects in there.  Otherwise it would not be possible
> > to directly dereference such objects without taking unaligned faults
> > on several types of RISC cpus.
> >   
> 
> That doesn't appear to have been a problem.

We should be OK with the elf note header since n_namesz, n_descsz, and
n_type are 32-bit types even on Elf64.  But for the contents embedded
in the note, I am not convinced that there are no potential issues.

