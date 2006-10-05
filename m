Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWJEUeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWJEUeK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWJEUeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:34:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:10087 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751268AbWJEUeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:34:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eUc8qEk8p9jNf3YwoAFdpmj5uf52/GJPw71Nl61GrqhPeNEmUSY/Tfv14aw3zqRC9UZFEZAN686o/q/+pUlcoGbzlCeNMgPDRW3MJ/Nddo0f9AZeiSGXzWKlqeW9us3ARDUtRbfk+5mwoSu4BExONQUDikWljr3Qo9LBdNXr0lk=
Message-ID: <d120d5000610051334o7604b1d4hd2f4c9a9b858f06e@mail.gmail.com>
Date: Thu, 5 Oct 2006 16:34:02 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Jiri Kosina" <jikos@jikos.cz>
Subject: Re: 2.6.18-git21, possible recursive locking in kseriod ends up in DWARF2 unwinder stuck
Cc: "Alessandro Suardi" <alessandro.suardi@gmail.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>
In-Reply-To: <Pine.LNX.4.64.0610042317590.12556@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a4c581d0610041417y113bb92cs10971308180980e5@mail.gmail.com>
	 <Pine.LNX.4.64.0610042317590.12556@twin.jikos.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/06, Jiri Kosina <jikos@jikos.cz> wrote:
> On Wed, 4 Oct 2006, Alessandro Suardi wrote:
>
> > Non-fatal (box is still alive and apparently well) on boot,
> > FC5-uptodate on a Dell Latitude C640. From the dmesg ring:
>
> > [    8.680000] =============================================
> > [    8.680000] [ INFO: possible recursive locking detected ]
> > [    8.680000] 2.6.18-git21 #1
> > [    8.680000] ---------------------------------------------
> > [    8.680000] kseriod/163 is trying to acquire lock:
> > [    8.680000]  (&ps2dev->cmd_mutex/1){--..}, at: [<c03198c3>]
> > ps2_command+0x89/0x358
>
> Me and Peter Zijlstra have already submitted patches to fix this - read
> the thread at
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2006-09/msg07416.html
>
> I don't know the reason why these have not yet been merged into the input
> tree. Dmitry?
>

Sorry, was a little busy.

I tested the patches and they work. Couple of comments:

- register_lock_class is marked as inline but now has 2 call sites and
is relatively big - might want to remove "inline"
- how about adding lockdep_set_subclass() to avoid littering source
with struct lock_class_key when we only want to tweak subclass? For
that we might want export register_lock_class and hide it behind a
#define...

-- 
Dmitry
