Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262291AbSJJKzc>; Thu, 10 Oct 2002 06:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263345AbSJJKzc>; Thu, 10 Oct 2002 06:55:32 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:61188 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262291AbSJJKzc>; Thu, 10 Oct 2002 06:55:32 -0400
Message-ID: <3DA55E0C.24033BB5@aitel.hist.no>
Date: Thu, 10 Oct 2002 13:01:32 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.40mm1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Giuliano Pochini <pochini@shiny.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
References: <XFMail.20021010113849.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini wrote:

> Yes, it makes sense, but it's useless or harmful to discard caches
> if nobody else needs memory. You just lose data that may be
> requested in the future for no reason.

Sure, so the ideal is to not drop unconditionally, but
make sure that the "finished" O_STREAMING pages are
the very first ones to go whenever memory pressure happens.

The question then becomes "can you do that, with no more
overhead or code complexity than the existing stuff?"

It wouldn't necessarily make much difference, because
a linux machine is almost always under memory pressure.
Free memory is simply filled up with cache till there
is no more left.  From then on, all requests for memory
are handled by throwing something else out of cache
or into swap.  In that case the streaming pages
are evicted quickly anyway, and the ideal case
is no different from the implemented case.

Helge Hafting
