Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261541AbSJ2EZY>; Mon, 28 Oct 2002 23:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbSJ2EZY>; Mon, 28 Oct 2002 23:25:24 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:62603 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S261541AbSJ2EZX>;
	Mon, 28 Oct 2002 23:25:23 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200210290431.HAA20288@sex.inr.ac.ru>
Subject: Re: UPD: Frequent/consistent panics in 2.4.19 at ip_route_input_slow, in_dev_get(dev)
To: alain@cscoms.net (Alain Fauconnet)
Date: Tue, 29 Oct 2002 07:31:22 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org, lve@ns.aanet.ru
In-Reply-To: <20021029111330.C15782@cscoms.net> from "Alain Fauconnet" at Oct 29, 2 11:13:30 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> In  this  case,  would  they  be  packets  TO  or FROM the ppp device?

FROM, of course. When a packet reaches IP, the device is already destroyed.
This is impossible, unless driver is broken or we have an error
in reference counting. The second possibility is eliminated by the fact,
that you do not see "Freeing alive device". So, device was cleanly
unregistered.

> No such message in logs, but  "PPPIOCDETACH  file->f_count=3"

I will look. It sounds as an interesting hint.

> - pptp  (PoPToP). But pptp is only userland software, how could it cause
> such a problem?

In no way.

> thus re-injected to the stack later than  usual?  (I'm  probably  just
> talking nonsense here - sorry - trying to guess).

It is not a nonsense. However, iptables hold necessary reference counts.

> - assymetrical routing:

This is not essential.

> -a shows "duplicate" ppp devices e.g.:
....
> Is this "normal"?

Well, ifconfig can be racy. If some device sitting in the list before ppp96
was deleted while ifconfig scanned the list, you can see ppp96 twice.
If some device was added, ifconfig can lose some device. Awkward, of course.

Alexey
