Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030502AbWJLHVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbWJLHVJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030500AbWJLHVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:21:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33731 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030502AbWJLHVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:21:05 -0400
Date: Thu, 12 Oct 2006 00:21:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J R" <x-list-subscriptions@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bugs in (2.6.18) from static analysis tool
Message-Id: <20061012002101.2acca0dd.akpm@osdl.org>
In-Reply-To: <BAY24-F39D5E3A7E7B3E9B1F469AC5150@phx.gbl>
References: <BAY24-F39D5E3A7E7B3E9B1F469AC5150@phx.gbl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 22:06:22 -0700
"J R" <x-list-subscriptions@hotmail.com> wrote:

> Hi,
> 
> We are in the final stages of refining a new static analysis framework and 
> are testing it out on various large open source software projects (like 
> other ventures in this space).
> 
> Unlike other enterprises, we are making a linux intraprocedural analysis 
> tool openly available in binary form to allow our results to be reproduced 
> and validated. Ditto the bug lists.
> 
> Although this is commercial software, our team are all strong OS advocates 
> and contributors. We hope to release some components of this project on an 
> OS basis just as soon as we can trash out a solid plan which allows this 
> while also enabling us to purchase food.
> 
> I've only attached 1 or 2 bugs at the end here (the full list is about 10K 
> ascii text), there are at www.cqsat.com/linux.html#bugs. There's about 50 
> and I recon 20 or so are both real and not yet identified.
> 
> Any comments/issues/feedback is appreciated.
> 

useful, thanks.

> 
> ==============================================================================
> SEVERITY=[SERIOUS]
> ISSUE=[Tainted expression (tmp).kb_table used as an index in this context. 
> Expression bounds: [Upper bound unchecked]. Tracking "(tmp).kb_table": 
> unsigned, 8 bit(s)]
> SOURCE=[/p0/working/Downloads/linux-2.6.9/drivers/char/vt_ioctl.c, line 83]
> SINK=[/p0/working/Downloads/linux-2.6.9/drivers/char/vt_ioctl.c, line 88]
> ORIGINATOR=[cqsat]
> 
>       80:     struct kbentry tmp;
>       81:     ushort *key_map, val, ov;
>       82:
>       83:     if (copy_from_user(&tmp, user_kbe, sizeof(struct kbentry)))
>           	^^^---------^^^----------^^^
>           	START
>       84:         return -EFAULT;
>       86:     switch (cmd) {
>       87:     case KDGKBENT:
>       88:         key_map = key_maps[s];
>           	^^^---------^^^----------^^^
>           	ERROR
>       89:         if (key_map) {
>       90:             val = U(key_map[i]);
>       91:             if (kbd->kbdmode != VC_UNICODE && KTYP(val) >= 
> NR_TYPES)
>       92:             val = K_HOLE;

Yup, that's a bug.
