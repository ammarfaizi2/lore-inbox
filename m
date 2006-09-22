Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWIVNpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWIVNpf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 09:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWIVNpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 09:45:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:17344 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932356AbWIVNpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 09:45:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pz2m4NujP4BBLHsIdvWHUuWaSljHQRaVdrVb4qndjiVBMPGKW9A/qjCt1ky0aJc1i6R2UyvAUH1WBrvAQtOjbayLHJm5kOTc0VEcDtgD+fM/748orvgk7GXtUrQ0AVYM21H6VdGuo1P8t43wkGDo+zvQrYtE4UvJ8fDZ/26+pb8=
Message-ID: <d120d5000609220645h3bdd2941p711c7419b50c6ea4@mail.gmail.com>
Date: Fri, 22 Sep 2006 09:45:30 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Paulo Marques" <pmarques@grupopie.com>
Subject: Re: [KJ] kmalloc to kzalloc patches for drivers/block [sane version]
Cc: "Pekka Enberg" <penberg@cs.helsinki.fi>,
       "Jiri Slaby" <jirislaby@gmail.com>,
       "Om Narasimhan" <om.turyx@gmail.com>, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org
In-Reply-To: <4513DF11.802@grupopie.com>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/06, Paulo Marques <pmarques@grupopie.com> wrote:
> Pekka Enberg wrote:
> > On 9/22/06, Paulo Marques <pmarques@grupopie.com> wrote:
> >> Agreed on every comment except this one. That complex expression is
> >> really just a constant in the end, so there is no point in using kcalloc.
> >
> > The code is arguably easier to read with kcalloc.
>
> I was afraid the kcalloc call would have the added overhead of an extra
> parameter and a multiplication, but since it is actually declared as a
> static inline, gcc should optimize everything away (because both
> parameters are constants) and give the same result in the end.
>

I think the we should follow a rule like this: when allocating several
separate objects of the same type at the same time (like 10 "card"
structures) kcalloc should be used. When allocating one object (even
consisting of "several ints") kmalloc/kzalloc should be used. As far
as I can see the code just tries to allocate longish bitmap and so
kzalloc is better.

Better yet, why don't you DECLARE_BITMAP(cmd_pool_bits) and embed it
right into struct ctrl_info instead of dynamically allocating it?

-- 
Dmitry
