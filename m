Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266069AbTBXT25>; Mon, 24 Feb 2003 14:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266292AbTBXT24>; Mon, 24 Feb 2003 14:28:56 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:5788 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S266069AbTBXT2z>; Mon, 24 Feb 2003 14:28:55 -0500
Message-Id: <5.1.0.14.2.20030224112723.05a5e640@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 24 Feb 2003 11:35:03 -0800
To: Rusty Russell <rusty@rustcorp.com.au>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family 
Cc: "David S. Miller" <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, linux-kernel@vger.kernel.org,
       jgarzik@redhat.com
In-Reply-To: <20030224025907.A238F2C091@lists.samba.org>
References: <Your message of "Thu, 20 Feb 2003 17:17:52 -0800." <5.1.0.14.2.20030220165016.0d47c688@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:01 PM 2/23/2003, Rusty Russell wrote:
>> >better know *exactly* what you are doing", even though the "try" is a
>> >bit of a misnomer.
>> Yeah, I think 'try' is definitely a misnomer in this case.
>> How about something like this ?
>
>No, I definitely want the name __try_module_get.  Sure, it's a
>misnomer in one sense, which will hopefully scare off people looking
>for an easy way out.  OTOH, it accurately reflects "you should be
>using try_module_get but you have special circumstances" more
>eloquently than any comment ever would.  Especially since there are
>only a handful of places where it is appropriate.
>
>I think a CONFIG option for checking is overkill: better is to grep
>each kernel for __try_module_get() being added and make sure the damn
>thing doesn't spread 8)
Ok.

>+/* Sometimes we know we already have a refcount, and it's easier not
>+   to handle the error case (which only happens with rmmod --wait). */
>+static inline void __try_module_get(struct module *module)
>+{
>+       local_inc(&module->ref[get_cpu()].count);
>+       put_cpu();
>+}

I still think that __try is confusing and __module_get() would be more 
appropriate name for that function. But I can live with __try_module_get() :)
I'll make new patch for net/socket.c as soon as yours goes in.

Thanks
Max

