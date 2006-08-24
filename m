Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422648AbWHXUlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422648AbWHXUlj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 16:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422646AbWHXUlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 16:41:39 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:54707 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422636AbWHXUli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 16:41:38 -0400
In-Reply-To: <1156428917.3007.150.camel@localhost.localdomain>
Subject: Re: [PATCH 3/7] SLIM main patch
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin LaHaise <bcrl@kvack.org>, David Safford <safford@us.ibm.com>,
       kjhall@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Serge E Hallyn <sergeh@us.ibm.com>
X-Mailer: Lotus Notes Release 7.0.1 July 07, 2006
Message-ID: <OFBA8851BE.520FA69E-ON852571D4.006E9AA6-852571D4.005C4E99@us.ibm.com>
From: Mimi Zohar <zohar@us.ibm.com>
Date: Thu, 24 Aug 2006 16:41:34 -0400
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Release 7.0.1HF269 | June 22, 2006) at
 08/24/2006 16:41:37
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox <alan@lxorguk.ukuu.org.uk> wrote on 08/24/2006 10:15:17 AM:

> Ar Iau, 2006-08-24 am 08:32 -0500, ysgrifennodd Serge E. Hallyn:
> > > You also have to deal with existing mmap() mappings and
> > > outstanding I/O.
> >
> > That she does.
>
> I don't believe so from the patches.
>
> > >    SysV shared memory
> >
> > standard mmap controls should handle this, right?
>
> No its rather independant of mmap

Under the covers it seems to use shmem.  sys_shmget() calls newseg(),
which sets up the shared memory.

> > >    mmap
> >
> > She handles these.
>
> I must have missed where it handles that.

revoke_mmap_wperm() walks current->mm->mmap and removes
the file write permission using do_mprotect().

We have test shmem and mmap programs in the ltp framework that
show this actually works.

Mimi

