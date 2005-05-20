Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVETRis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVETRis (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 13:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVETRir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 13:38:47 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:18060 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261511AbVETRii
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 13:38:38 -0400
Date: Fri, 20 May 2005 13:38:28 -0400 (Eastern Daylight Time)
From: Reiner Sailer <sailer@us.ibm.com>
To: James Morris <jmorris@redhat.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>, emilyr@us.ibm.com, yoder1@us.ibm.com,
       kjhall@us.ltcfwd.linux.ibm.com, linux-kernel@vger.kernel.org,
       toml@us.ibm.com
Subject: Re: [PATCH 1 of 4] ima: related TPM device driver interal kernel
 interface
Message-ID: <Pine.WNT.4.63.0505201332400.4052@laptop>
X-Warning: UNAuthenticated Sender
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James Morris <jmorris@redhat.com> wrote on 05/20/2005 10:56:20 AM:

> Why are you using LSM for this?
> 
> LSM should be used for comprehensive access control frameworks which 
> significantly enhance or even replace existing Unix DAC security.

I see LSM is framework for security. IMA is an architecture that
enforces access control in a different way than SELinux. IMA guarantees 
that executable content is measured and accounted for before
it is loaded and can access (and possibly corrupt) system resources.

> We're going to end up with a proliferation of arbitrary security 
features 
> lacking an overall architectural view (I've written about this before, 
> see http://www.ussg.iu.edu/hypermail/linux/kernel/0503.1/0300.html).
>
> I think it would be better to implement this directly.

The reason IMA is implemented as a Linux security module is that the LSM
interface allows the least intrusive implementation with regard to existing
kernel code. IMA is non-intrusive (its hooks return always nicely) and 
implements security guarantees that are orthogonal to those of, e.g., 
SELinux. Interactions with other LSM users are not expected. Experience 
shows that maintining IMA as LSM is simple.

There is no reason though why IMA must use LSM; however, it seems not the
straightforward solution to replicate LSM hooks that are already 
available.

> 
> - James
> -- 
> James Morris
> <jmorris@redhat.com>
> 
> 

Thanks
Reiner

