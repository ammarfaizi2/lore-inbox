Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292714AbSCDS7A>; Mon, 4 Mar 2002 13:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292774AbSCDS6w>; Mon, 4 Mar 2002 13:58:52 -0500
Received: from zero.tech9.net ([209.61.188.187]:31503 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292714AbSCDS6i>;
	Mon, 4 Mar 2002 13:58:38 -0500
Subject: Re: [PATCH] spinlock not locked when unlocking in atm_dev_register
From: Robert Love <rml@tech9.net>
To: Frode Isaksen <fisaksen@bewan.com>
Cc: mitch@sfgoth.com, linux-kernel@vger.kernel.org
In-Reply-To: <B8A8EEF6.E8B%fisaksen@bewan.com>
In-Reply-To: <B8A8EEF6.E8B%fisaksen@bewan.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Mar 2002 13:58:33 -0500
Message-Id: <1015268314.15479.32.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-03-04 at 03:29, Frode Isaksen wrote:

> The atm_dev_register function is calling functions that are using the same
> spinlock, so you cannot just lock the spinlock when entering the function..

Ah, OK -- my apologies.  Then, a few things need to be checked:

	- atm_dev_register (ignoring its callees) does not need a lock
	- every callee of atm_dev_register that does need the lock
	  acquires and releases it itself (this is good design, too)

I suspect the second point may be missing the releases in cases, since
those spin_unlocks were in the code.

	Robert Love

