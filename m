Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132589AbRDKOoK>; Wed, 11 Apr 2001 10:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132590AbRDKOoB>; Wed, 11 Apr 2001 10:44:01 -0400
Received: from t2.redhat.com ([199.183.24.243]:22267 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S132589AbRDKOnu>; Wed, 11 Apr 2001 10:43:50 -0400
To: Andreas Franck <afranck@gmx.de>
Cc: David Howells <dhowells@cambridge.redhat.com>, torvalds@transmeta.com,
        andrewm@uow.edu.au, bcrl@redhat.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2nd try: i386 rw_semaphores fix 
In-Reply-To: Your message of "Wed, 11 Apr 2001 16:32:25 +0200."
             <1098.986999545@www17.gmx.net> 
Date: Wed, 11 Apr 2001 15:43:48 +0100
Message-ID: <16847.987000228@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been discussing it with some other kernel and GCC people, and they think
that only "memory" is required.

> What are the reasons against mentioning sem->count directly as a "=m" 
> reference? This makes the whole thing less fragile and no more dependent
> on the memory layout of the structure.

Apart from the risk of breaking it, you mean? Well, "=m" seems to reserve an
extra register to hold a second copy of the semaphore address, probably since
it thinks EAX might get clobbered.

Also, as a minor point, it probably ought to be "+m" not "=m".

David
