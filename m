Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTKLFcz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 00:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTKLFcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 00:32:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:33230 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261771AbTKLFcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 00:32:48 -0500
Date: Tue, 11 Nov 2003 21:32:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
cc: Manfred Spraul <manfred@colorfullife.com>, Andrew Morton <akpm@osdl.org>,
       <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: RE: prepare_wait / finish_wait question
In-Reply-To: <A20D5638D741DD4DBAAB80A95012C0AED791DE@orsmsx409.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0311112130370.3288-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Nov 2003, Perez-Gonzalez, Inaky wrote:
> 
> What about some safe wake up mechanism like get_task_struct()/__wake_up()/
> put_task_struct()??

A better solution might be to just make the wakeup function take the 
required runqueue spinlock first, then remove the task from the list, drop 
the wakeup list spinlock, and _then_ do the actual wakeup.

It would require some surgery to the try_to_wake_up() function, though.. 

		Linus

