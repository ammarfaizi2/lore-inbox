Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265080AbSJRLmL>; Fri, 18 Oct 2002 07:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265083AbSJRLmL>; Fri, 18 Oct 2002 07:42:11 -0400
Received: from gateway.ukaea.org.uk ([194.128.63.73]:14205 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S265080AbSJRLmK>; Fri, 18 Oct 2002 07:42:10 -0400
Message-ID: <3DAFF5C9.807BE885@ukaea.org.uk>
Date: Fri, 18 Oct 2002 12:51:37 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4: variable HZ
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya...  Nice patch, must try it when I find a few minutes - I think I
have a few apps that are limited by select/poll behaviour.

I was looking at your jiffies_to_clock_t() macro, and I notice that it
will screw up badly if the user chooses a HZ value that isn't a multiple
of the normal value (e.g. 1000 is OK, 512 isn't).

How about tweaking the macro a little?  Instead of:
x / (HZ/USER_HZ)
you could use:
(x/HZ*USER_HZ + x%HZ*USER_HZ/HZ)

which minimises roundoff error and also won't overflow (at least, it
won't overflow as long as HZ*USER_HZ doesn't overflow!).

You could even use both versions of the macro, choosing between them at
compile time depending on whether or not (HZ % USER_HZ == 0).

What do you think?

cheers
Neil
PS: I'm off-list.
