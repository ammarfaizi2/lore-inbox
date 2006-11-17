Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755511AbWKQIPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511AbWKQIPZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 03:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755539AbWKQIPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 03:15:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2989 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1755511AbWKQIPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 03:15:24 -0500
Date: Fri, 17 Nov 2006 00:15:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       uril@qumranet.com
Subject: Re: [PATCH 3/3] KVM: Expose MSRs to userspace
Message-Id: <20061117001510.58f01b3c.akpm@osdl.org>
In-Reply-To: <455D62D1.6040203@qumranet.com>
References: <455CA70C.9060307@qumranet.com>
	<20061116180422.0CC9325015E@cleopatra.q>
	<20061116170214.b7785bd0.akpm@osdl.org>
	<455D62D1.6040203@qumranet.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 09:20:49 +0200
Avi Kivity <avi@qumranet.com> wrote:

> >> +out_vcpu:
> >> +	vcpu_put(vcpu);
> >> +
> >> +	return rc;
> >> +}
> >>     
> >
> > This function returns no indication of how many msrs it actually did set. 
> > Should it?
> >   
> 
> It can't hurt.  Is returning the number of msrs set in the return code 
> (ala short write) acceptable, or do I need to make this a read/write ioctl?
> 

I'd have thought that you'd just copy the number written into msrs->nmsrs via

	msrs->nmsrs = num_entries;

like kvm_dev_ioctl_set_msrs() does.  Dunno...
