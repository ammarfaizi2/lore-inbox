Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTDQRuw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 13:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbTDQRuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 13:50:51 -0400
Received: from opersys.com ([64.40.108.71]:33028 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261743AbTDQRut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 13:50:49 -0400
Message-ID: <3E9EB30B.511F93DD@opersys.com>
Date: Thu, 17 Apr 2003 13:58:35 +0000
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Hicks <mort@wildopensource.com>
CC: Daniel Stekloff <dsteklof@us.ibm.com>, Patrick Mochel <mochel@osdl.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>, hpa@zytor.com, pavel@ucw.cz,
       jes@wildopensource.com, linux-kernel@vger.kernel.org, wildos@sgi.com,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: [patch] printk subsystems
References: <200304141533.18779.dsteklof@us.ibm.com> <Pine.LNX.4.44.0304161140160.912-100000@cherise> <20030416191619.GA3413@bork.org> <200304161243.58291.dsteklof@us.ibm.com> <20030417155604.GC543@bork.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin Hicks wrote:
> I don't think relayfs solves the problem either.  This just adds an
> extra dependency for yet another pseudo-filesystem.  printk is something
> that needs to "just work" even if the kernel is in the midst of
> crashing.  Adding the extra complexity of all printk going out through a
> filesystem/buffer layer is not desirable, IMHO.

I beg to differ. There's a point where we've got to stop saying "oh,
this buffering mechanism is special and it requires its own code."
relayfs is there to provide a unified light-weight mechanism for
transfering large amounts of data from the kernel to user space.

> It seems that the relayfs solution for buffer overflows in the printk
> buffer is to just make lots of buffers.  I really want to be able to
> turn off prink logging for stuff I don't care about, without the
> complexity of having fifteen different logs to look in and changing
> how get get log info from the kernel to syslog.

Again, as I said earlier, relayfs doesn't care about filtering. That's
to the upper layers to take care of. It so happens that relayfs simplifies
filtering by allowing the upper layers to mux their data using separate
channels. In no way is anyone forced to do that, though. It's there if
you need it, and if you need to simply have a is_this_message_logged()
function, then so be it, but that's yours to implement.

As for buffer overflows and printk, automatically resizeable log buffers
using a water-mark scheme are on the relayfs to-do list.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
