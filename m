Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262457AbSJ1NLz>; Mon, 28 Oct 2002 08:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262474AbSJ1NLz>; Mon, 28 Oct 2002 08:11:55 -0500
Received: from infa.abo.fi ([130.232.208.126]:39698 "EHLO infa.abo.fi")
	by vger.kernel.org with ESMTP id <S262457AbSJ1NLy>;
	Mon, 28 Oct 2002 08:11:54 -0500
Date: Mon, 28 Oct 2002 15:18:07 +0200
From: Marcus Alanen <marcus@infa.abo.fi>
Message-Id: <200210281318.PAA19085@infa.abo.fi>
To: Nikita@Namesys.COM, Manfred Spraul <manfred@colorfullife.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFC] faster kmalloc lookup
In-Reply-To: <15805.13847.945978.673664@laputa.namesys.com>
References: <3DBBEA2F.6000404@colorfullife.com> <3DBAEB64.1090109@colorfullife.com> <1035671412.13032.125.camel@irongate.swansea.linux.org.uk> <3DBBBB30.20409@colorfullife.com> <3DBBEA2F.6000404@colorfullife.com> <15805.13847.945978.673664@laputa.namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Most kmalloc calls get constant size argument (usually
>sizeof(something)). So, if switch() is used in stead of loop (and
>kmalloc made inline), compiler would be able to optimize away
>cache_sizes[] selection completely. Attached (ugly) patch does this.

Perhaps a compile-time test to check if the argument is
a constant, and only in that case call your new kmalloc, otherwise
a non-inline kmalloc call? With your current patch, a non-constant
size argument to kmalloc means that the function is inlined anyway,
leading to unnecessary bloat in the resulting image.

Marcus

