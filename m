Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263049AbTCSPDf>; Wed, 19 Mar 2003 10:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263050AbTCSPDf>; Wed, 19 Mar 2003 10:03:35 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:34980 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S263049AbTCSPDe>; Wed, 19 Mar 2003 10:03:34 -0500
Message-Id: <200303191513.h2JFDjGi022118@locutus.cmf.nrl.navy.mil>
To: Mitchell Blank Jr <mitch@sfgoth.com>
cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ATM] first pass at fixing atm spinlock 
In-reply-to: Your message of "Wed, 19 Mar 2003 02:57:34 PST."
             <20030319025734.C35024@sfgoth.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Wed, 19 Mar 2003 10:13:45 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030319025734.C35024@sfgoth.com>,Mitchell Blank Jr writes:
>> i dont know.  i believe all of the adapters do a synchronous close.
>I'm really not sure it's that safe.  At the very least the drivers all
>need to make sure that their ->close() excludes their interrupt/bh work

i suppose i could be he-centric.  when the rx and tx close complete you
know you wont be getting anymore traffic in the queues regarding that
vpi/vcc.  i suppose other cards might now have this feature.  some 
drivers just keep a pointer to vcc in a table.  so it they dont use
atm_vcc_lookup() each time they need a receieve then i guess the vcc's
will need some sort of ref counting.  i am generally against this 
scheme, but it could be made to work.

>Great - now we just have to do the same thing for vcc's :-)

actually i think the vcc related code is 'broken'.  since the vcc is
really attached to a struct sock, the vcc code should be more sock-centric.
sock provides ref counting, locks, linking, hash support.  at the time
the atm code was initially written, struct sock might not have been
generic enough.
