Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283056AbRLMCtl>; Wed, 12 Dec 2001 21:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283080AbRLMCtc>; Wed, 12 Dec 2001 21:49:32 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:25003 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S283056AbRLMCtX>;
	Wed, 12 Dec 2001 21:49:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Torrey Hoffman <torrey.hoffman@myrio.com>,
        "David C. Hansen" <haveblue@us.ibm.com>
Subject: Re: [RFC] Change locking in block_dev.c:do_open()
Date: Wed, 12 Dec 2001 18:49:20 -0800
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB01@mail0.myrio.com>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB01@mail0.myrio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16ELw0-0003Ch-00@phalynx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 12, 2001 18:40, Torrey Hoffman wrote:
> Ryan Cumming wrote:
> > Why not use a read-write semaphore? The sections that require
> > the module to
> > stay resident use a read lock, and module unloading aquires a
> > write lock. In
> > addition to containing the evil, evil BKL, you might actually
> > get a tangiable
> > scalability gain out of it.

<random sassing snipped>

> With some improvements in this area, massively parallel SMP systems
> could parallelize module loading, and achieve thousands of module
> load/unload operations per second (MLUOPS).

Ha, yes, I can imagine how what I said seemed rather amusing. In case it 
wasn't clear, I mean we should use a read write semaphore to prevent things 
that require the module to be loaded from being -serialized against each 
other-. So, think being able to parellelize the actual -usage- of the 
module's functions. Module unloads would still be serialized, unfortunately ;)

-Ryan
