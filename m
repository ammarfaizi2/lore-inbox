Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312535AbSCYUIe>; Mon, 25 Mar 2002 15:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312536AbSCYUIY>; Mon, 25 Mar 2002 15:08:24 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:39596 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S312535AbSCYUIP>; Mon, 25 Mar 2002 15:08:15 -0500
Message-ID: <3C9F838C.4030101@antefacto.com>
Date: Mon, 25 Mar 2002 20:07:40 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOPs in do_select()
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happened on an embedded system so
I haven't got a standard OOPs, but anyway
the message was:

"Unable to handle kernel NULL pointer dereference at 00000000"

looking at the trace and doing a little poking around
the error was definitely in do_select, and maybe on the
following line:

if (!(bit & BITS(fds, off)))

The cause was there was a client talking to a server
over a socket and the server SEGFAULTED. The OOPs was
associated with the client process.

Note the client was often seen to crash when the server
did, suggesting it received bad data from the kernel?

cheers,
Padraig.

