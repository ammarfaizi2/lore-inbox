Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315372AbSG2Lja>; Mon, 29 Jul 2002 07:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSG2Lj3>; Mon, 29 Jul 2002 07:39:29 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:52491 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315372AbSG2Lj3>; Mon, 29 Jul 2002 07:39:29 -0400
Date: Mon, 29 Jul 2002 13:42:38 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@infradead.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Patch: linux-2.5.29 __downgrade_write() for CONFIG_RWSEM_GENERIC_SPINLOCK
In-Reply-To: <28550.1027934035@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.44.0207291336120.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 29 Jul 2002, David Howells wrote:

> It doesn't appear to make any difference which way it is done. The i386 code
> from both looks the same.

Then I vote for the simpler version. :)
BTW even if gcc had problems optimizing that, I'd rather make it explicit,
that the two variables contain the same information:

	activity = sem->activity = 0;
	if (!list_empty(&sem->wait_list))
		sem = __rwsem_do_wake(sem, activity);

IMO that's more readable and will still work if gcc had to flush the
cached information before using it.

bye, Roman

