Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267117AbTCEPSq>; Wed, 5 Mar 2003 10:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267126AbTCEPSq>; Wed, 5 Mar 2003 10:18:46 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:17301 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S267117AbTCEPSp>; Wed, 5 Mar 2003 10:18:45 -0500
Message-Id: <200303051528.h25FSqGi006413@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: wa@almesberger.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] make atm (and clip) modular + try_module_get() 
In-reply-to: Your message of "Wed, 05 Mar 2003 06:53:41 PST."
             <20030305.065341.35361286.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Wed, 05 Mar 2003 10:28:52 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030305.065341.35361286.davem@redhat.com>,"David S. Miller" writes
:
>I understand why you think you have to lock, that isn't the issue.
>I'm telling you that you should be locking this crap at a much
>higher level.

ok, i see what you are saying now.  since this is used to move the
stuff queued from the old connection to the new connection i suppose
clip might want something like?

	spin_lock_bh(&vcc->recvq.lock)
        skb_migrate(&vcc->recvq,&copy);
	spin_unlock_bh(&vcc->recvq.lock);

that would block any more additions to the recvq (which should be
sk->receieve_queue i suspect -- more on that later) while the skb are
moved to copy.  i am afraid i dont know much about how the clip driver
operates.
