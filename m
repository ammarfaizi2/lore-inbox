Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbSJaBdg>; Wed, 30 Oct 2002 20:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbSJaBdg>; Wed, 30 Oct 2002 20:33:36 -0500
Received: from AMarseille-201-1-6-98.abo.wanadoo.fr ([80.11.137.98]:9840 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S265096AbSJaBdf>;
	Wed, 30 Oct 2002 20:33:35 -0500
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linus Torvalds" <torvalds@transmeta.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: prevent swsusp from eating disks
Date: Thu, 31 Oct 2002 02:39:42 +0100
Message-Id: <20021031013942.25199@192.168.4.1>
In-Reply-To: <1036006956.5141.117.camel@irongate.swansea.linux.org.uk>
References: <1036006956.5141.117.camel@irongate.swansea.linux.org.uk>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Another is that I feel (and I know Pavel doesn't agree here) that
>> the disk driver should also block further incoming requests (that
>> is leave them in the queue) instead of panic'ing. That is the
>> driver should not rely on not beeing fed any more request, but
>> rather make sure it will leave them in the queue and deal with
>> them when resumed.
>
>It is cleaner if the ordering of power off is right. If the model is
>right then the first suspend would be the drives. Part of drive suspend
>ought to be corking the queue.

Yup.

My point here is that while Pavel approach is to kill/suspend anything
that may trigger new IO requests (thus topping all userland, stopping
selected kernel threads, etc...), I tend to think we leave all that
alive, and just block requests going to suspended devices until those
get alive again. That used to work well on pmac and leads to very
fast suspend/resume cycles.

Ben.


