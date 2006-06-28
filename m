Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWF1UQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWF1UQb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 16:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWF1UQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 16:16:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43959 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751240AbWF1UQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 16:16:30 -0400
Subject: Re: 2.6.17-mm3 -- BUG: trying to register non-static key!
From: Arjan van de Ven <arjan@infradead.org>
To: Miles Lane <miles.lane@gmail.com>
Cc: Davem@davemloft.net, jgarzik@pobox.com, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <a44ae5cd0606281109u5cc25038n67b086f0d4f6426e@mail.gmail.com>
References: <a44ae5cd0606271447j58ad9cdchc4728c010245df5b@mail.gmail.com>
	 <20060628153403.GA32131@elte.hu>
	 <a44ae5cd0606281109u5cc25038n67b086f0d4f6426e@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 22:16:13 +0200
Message-Id: <1151525773.3153.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-28 at 11:09 -0700, Miles Lane wrote:
> After rebuilding with your patch, the stack trace shows up,
> but now there is a warning of a possible circular locking dependency:
> 
> [ INFO: possible circular locking dependency detected ]
> -------------------------------------------------------
> S13gdm/2088 is trying to acquire lock:
>  (&dev->queue_lock){-+..}, at: [<c11a1fbc>] dev_queue_xmit+0x120/0x248
> 
> but task is already holding lock:
>  (&dev->_xmit_lock){-+..}, at: [<c11a201f>] dev_queue_xmit+0x183/0x248
> 
> which lock already depends on the new lock.
> 

ok this driver calls dev_queue_xmit() inside a ->hard_start_xmit
handler... that smells fishy.

Jeff/DaveM: is that legal ?

