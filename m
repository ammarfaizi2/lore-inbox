Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWJFN3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWJFN3a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 09:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWJFN3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 09:29:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:4202 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932322AbWJFN33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 09:29:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FpdlJEYU2lVTmwv2H/akDQZIHSqzhEwi31jY+JOjdEYz/f2xqRJfx9gtZ+GH+wFJS5Aryh1XAOUeTWLdPjTYiU6vWJnjeccJejVomh5RWkKS9axtamyZJ18h8sGiC2okZlOxlz0nEUMzi6I6nDTdExnb57YN/XO2LMTuOpdG0oU=
Message-ID: <d120d5000610060629t63905294u194b72a9ad8c74f2@mail.gmail.com>
Date: Fri, 6 Oct 2006 09:29:27 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>, "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.18-git21, possible recursive locking in kseriod ends up in DWARF2 unwinder stuck
Cc: "Jiri Kosina" <jikos@jikos.cz>,
       "Alessandro Suardi" <alessandro.suardi@gmail.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <1160134696.2792.102.camel@taijtu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a4c581d0610041417y113bb92cs10971308180980e5@mail.gmail.com>
	 <Pine.LNX.4.64.0610042317590.12556@twin.jikos.cz>
	 <d120d5000610051334o7604b1d4hd2f4c9a9b858f06e@mail.gmail.com>
	 <1160134696.2792.102.camel@taijtu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/06, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> > - how about adding lockdep_set_subclass() to avoid littering source
> > with struct lock_class_key when we only want to tweak subclass? For
> > that we might want export register_lock_class and hide it behind a
> > #define...
> >
>
> or something like this:
>
> #define concat_i(a)     #a
> #define concat(a,b)     concat_i(a ## b)
>
> #define lockdep_set_subclass(lock, subclass) \
>  ({ static struct lock_key_class __key; \
>     lockdep_init_map(&(lock)->dep_map, concat(lock, subclass), \
>                      &__key, subclass); })
>

That leaves unneeded __key (another one was already created by
mutex_init...) but it tucked away nicely in the define so it is fune
by me.

Ingo, do you want to send these changes on or you want me to push them
through my tree?

-- 
Dmitry
