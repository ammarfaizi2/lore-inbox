Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317860AbSGaItf>; Wed, 31 Jul 2002 04:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317861AbSGaItf>; Wed, 31 Jul 2002 04:49:35 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:13971 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317860AbSGaItf>; Wed, 31 Jul 2002 04:49:35 -0400
To: Jakub Jelinek <jakub@redhat.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sanitize TLS API
References: <20020730174336.A18385@lst.de> <Pine.LNX.4.44.0207302059060.22902-100000@localhost.localdomain> <20020730160631.R1596@devserv.devel.redhat.com>
From: Andi Kleen <ak@muc.de>
Date: 31 Jul 2002 10:52:38 +0200
In-Reply-To: Jakub Jelinek's message of "Tue, 30 Jul 2002 22:10:11 +0200"
Message-ID: <m33cu0l1nt.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek <jakub@redhat.com> writes:

> Actually, is the clear operation really necessary?
> IMHO the best clear is movw $0x03, %gs, then all accesses through %gs will
> trap. Calling set_thread_area (0, 1); will result in 0xb segment
> acting exactly like %ds or %es.

At least on x86-64 it is useful to have a clear operation, because setting the
thread descriptors adds some cost to the context switch for various reasons. 
This way processes you could disable it again when they don't need it anymore.

-Andi
