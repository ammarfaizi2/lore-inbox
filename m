Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965260AbWIVWzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965260AbWIVWzN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 18:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965261AbWIVWzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 18:55:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:26056 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965260AbWIVWzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 18:55:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ngQwahqsTaxw/AXXzWsVG+6ef1m5KqI8LIMcxpU3Oz9L1QJjnLaFyqCyuJnBBtwCES2XetA8ymm51eWKFlSxpcz1tpDIOlblsriWTlOFn7ad2ITqiDazlGz7FMloZwXE8WCt5M9u79Pa82PzBeTGpPjv9bb6BFnvud/KjzOfqTA=
Message-ID: <6b4e42d10609221555i721bef48m847a4d85ec0a080c@mail.gmail.com>
Date: Fri, 22 Sep 2006 15:55:10 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [KJ] kmalloc to kzalloc patches for drivers/block [sane version]
Cc: "Paulo Marques" <pmarques@grupopie.com>,
       "Pekka Enberg" <penberg@cs.helsinki.fi>,
       "Jiri Slaby" <jirislaby@gmail.com>, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org
In-Reply-To: <d120d5000609220645h3bdd2941p711c7419b50c6ea4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6b4e42d10609202311t47038692x5627f51d69f28209@mail.gmail.com>
	 <20060921072017.GA27798@us.ibm.com>
	 <6b4e42d10609212240i3d02241djbdaa0176ab9bfb2b@mail.gmail.com>
	 <6b4e42d10609212304o52bbc9b4y434bbd7ef71281e3@mail.gmail.com>
	 <4513A21C.40704@gmail.com> <4513C9BF.7040706@grupopie.com>
	 <84144f020609220503n4c495542x2130165e371ec85c@mail.gmail.com>
	 <4513DF11.802@grupopie.com>
	 <d120d5000609220645h3bdd2941p711c7419b50c6ea4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think the we should follow a rule like this: when allocating several
> separate objects of the same type at the same time (like 10 "card"
> structures) kcalloc should be used. When allocating one object (even
> consisting of "several ints") kmalloc/kzalloc should be used. As far
> as I can see the code just tries to allocate longish bitmap and so
> kzalloc is better.
>
> Better yet, why don't you DECLARE_BITMAP(cmd_pool_bits) and embed it
> right into struct ctrl_info instead of dynamically allocating it?
hba is decalred as
static ctlr_info_t *hba[MAX_CTLR]
So if I change the cmd_pool_bits to embed the DECLARE_BITMAP
statement, while compiling this file as a module, is there not a
chance of cmd_pool_bits cross a page boundary and allocated in two non
contiguous (physical) pages? Would it cause a problem with
__find_fist_zero_bit() and friends?
Regards,
Om.
