Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264195AbUDGUrY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 16:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUDGUrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 16:47:24 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:49898 "EHLO kiwi.cs.ucla.edu")
	by vger.kernel.org with ESMTP id S264197AbUDGUrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 16:47:08 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Isaacson <adi@hexapodia.org>, bug-coreutils@gnu.org,
       linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct
References: <20040406220358.GE4828@hexapodia.org>
	<20040406173326.0fbb9d7a.akpm@osdl.org>
	<20040407173116.GB2814@hexapodia.org>
	<20040407111841.78ae0021.akpm@osdl.org>
From: Paul Eggert <eggert@CS.UCLA.EDU>
Date: Wed, 07 Apr 2004 13:46:31 -0700
In-Reply-To: <20040407111841.78ae0021.akpm@osdl.org> (Andrew Morton's
 message of "Wed, 7 Apr 2004 11:18:41 -0700")
Message-ID: <87vfkbms7s.fsf@penguin.cs.ucla.edu>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> In 2.6 we do the check at open() and fcntl() time.  In 2.4 we don't
> fail until the actual I/O attempt.

This raises the issue of what "dd conv=direct" should do in 2.4
kernels.  I propose that it should report an error and exit, when the
write fails, since conv=direct can't be implemented.  The basic idea
is that on systems that lack direct I/O, conv=direct should fail.

Another issue with this patch: in Solaris, direct I/O is done by
invoking directio(DIRECTIO_ON); see
<http://docs.sun.com/db/doc/816-0213/6m6ne37so?q=directio&a=view>.
Is Solaris direct I/O a direct analog to Linux direct I/O, or are
there subtle differences in semantics that should be made visible to
the users of GNU "dd"?
