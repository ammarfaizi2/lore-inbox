Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267786AbRGZN2f>; Thu, 26 Jul 2001 09:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267951AbRGZN2W>; Thu, 26 Jul 2001 09:28:22 -0400
Received: from t2.redhat.com ([199.183.24.243]:10226 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S267786AbRGZN2D>; Thu, 26 Jul 2001 09:28:03 -0400
To: "Brian J. Watson" <Brian.J.Watson@compaq.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.4.7] enabling RWSEM_DEBUG 
In-Reply-To: Your message of "Wed, 25 Jul 2001 10:56:41 PDT."
             <3B5F0859.94557FF5@compaq.com> 
Date: Thu, 26 Jul 2001 14:28:09 +0100
Message-ID: <26413.996154089@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


> Unfortunately, I ran into a bug with enabling RWSEM_DEBUG. The bug still
> exists in 2.4.7.

It's because you've got CONFIG_MODVERSIONS=y set. This causes the following to
be emitted and automatically included:

	[include/linux/modules/rwsem.ver]
	#define __ver_rwsemtrace	smp_8447b3cd
	#define rwsemtrace	_set_ver(rwsemtrace)

This then causes the #ifndef rwsemtrace in fail, and thus not to include an
actual declaration of the rwsemtrace function.

David
