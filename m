Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbULGIzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbULGIzq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 03:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbULGIzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 03:55:45 -0500
Received: from blackhole.kfki.hu ([148.6.0.114]:31165 "EHLO blackhole.kfki.hu")
	by vger.kernel.org with ESMTP id S261442AbULGIzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 03:55:38 -0500
Date: Tue, 7 Dec 2004 09:56:01 +0100 (CET)
From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>, coreteam@netfilter.org
Subject: Re: [netfilter-core] ip contrack problem, not strictly followed RFC,
 DoS very much possible
In-Reply-To: <41B464B3.8020807@pointblue.com.pl>
Message-ID: <Pine.LNX.4.58.0412070835200.7860@blackhole.kfki.hu>
References: <41B464B3.8020807@pointblue.com.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 6 Dec 2004, Grzegorz Piotr Jaskiewicz wrote:

> Making it 5 days, makes linux router vournable to (D)DoS attacks. You
> can fill out conntrack hash tables very quickly, making it virtually
> dead. This computer will only respond to direct action, from keyboard,
> com port. This is insane, it just blocks it self, and does nothing, no
> fallback scenario, nothing.

The default hash size is computed very modestly from the size of the
available physical RAM of the machine. If the table fills up too fast,
then increase the hashsize when loading in the ip_conntrack module.
And/or add more RAM to the machine.  And/or setup rate-limiting in the raw
table, before packets hit conntrack itself.

But you are right, we should give more help to overcome disasters. For
example we could search more aggressively for unreplied (i.e droppable)
connections when the table is full, so releasing resources for new
connections (jenkins hash is too good :-). We could also introduce
"reserved conntrack entries", which could be occupied by specific
connections only, to make possible the remote management even when
otherwise the table is full. Just some coding is required :-).

Best regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlec@sunserv.kfki.hu
PGP key : http://www.kfki.hu/~kadlec/pgp_public_key.txt
Address : KFKI Research Institute for Particle and Nuclear Physics
          H-1525 Budapest 114, POB. 49, Hungary
