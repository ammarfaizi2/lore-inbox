Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbTDVCh7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 22:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbTDVCh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 22:37:59 -0400
Received: from fmr01.intel.com ([192.55.52.18]:46318 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262853AbTDVCh5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 22:37:57 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C263836@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Tom Zanussi'" <zanussi@us.ibm.com>
Cc: "'karim@opersys.com'" <karim@opersys.com>,
       "'Martin Hicks'" <mort@wildopensource.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>, "'hpa@zytor.com'" <hpa@zytor.com>,
       "'pavel@ucw.cz'" <pavel@ucw.cz>,
       "'jes@wildopensource.com'" <jes@wildopensource.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'wildos@sgi.com'" <wildos@sgi.com>
Subject: RE: [patch] printk subsystems
Date: Mon, 21 Apr 2003 19:49:55 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> From: Tom Zanussi
>
> relayfs actually uses 2 mutually-exclusive schemes internally -
> 'lockless' and 'locking', depending on the availability of a cmpxchg
> instruction (lockless needs cmpxchg).  If the lockless scheme is being
> used, relay_lock_channel() does no locking or irq disabling of any
> kind i.e. it's basically a no-op in that case.  

So that means you are using cmpxchg to do the locking. I mean, not the
"locking" itself, but a similar process to that of locking. I see. 

However, isn't it the almost the same as spinlocking? You are basically
trying to "allocate" a channel idx with atomic cmpxchg; if it fails, you
are retrying, spinning on the retry code until successful.

Not meaning to be an smartass here, but I don't buy the "lockless" tag,
I would agree it is an optimized-lock scheme [assuming it works better
than the spinlock case, that I am sure it does because if not you guys
would have not gone through the process of implementing it], but it is
not lockless.

Although it is not that important, no need to make a fuss out of that :)

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
