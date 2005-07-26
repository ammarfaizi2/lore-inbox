Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVGZClx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVGZClx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 22:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVGZClw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 22:41:52 -0400
Received: from opersys.com ([64.40.108.71]:48914 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261597AbVGZClw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 22:41:52 -0400
Message-ID: <42E5A168.4000600@opersys.com>
Date: Mon, 25 Jul 2005 22:35:20 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Tom Zanussi <zanussi@us.ibm.com>
CC: Roman Zippel <zippel@linux-m68k.org>, Steven Rostedt <rostedt@goodmis.org>,
       richardj_moore@uk.ibm.com, varap@us.ibm.com,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Merging relayfs?
References: <17107.6290.734560.231978@tut.ibm.com>	<20050712022537.GA26128@infradead.org>	<20050711193409.043ecb14.akpm@osdl.org>	<Pine.LNX.4.61.0507131809120.3743@scrub.home>	<17110.32325.532858.79690@tut.ibm.com>	<Pine.LNX.4.61.0507171551390.3728@scrub.home>	<17114.32450.420164.971783@tut.ibm.com>	<1121694275.12862.23.camel@localhost.localdomain>	<Pine.LNX.4.61.0507181607410.3743@scrub.home>	<42DBBD69.3030300@opersys.com>	<Pine.LNX.4.61.0507181706430.3728@scrub.home>	<17115.53671.326542.392470@tut.ibm.com>	<17121.23125.981162.389667@tut.ibm.com>	<42E17EEC.5070102@opersys.com> <17121.44053.855399.587966@tut.ibm.com>
In-Reply-To: <17121.44053.855399.587966@tut.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tom Zanussi wrote:
> In userspace, the sub-buffer reading loop looks at the commit value in
> the sub-buffer, and if it matches (sub-buffer size - padding), the
> buffer has been completely written and can be saved, otherwise it's
> not yet complete and is checked again the next time around.  This way,
> there's no need for a deliver() callback, the relay_commit() is
> replaced with the increment of the reserved commit value, the arrays
> aren't needed and you get the same result in the end in a much simpler
> way, IMHO.

Actually this has a much greater potential of loosing buffers because
we have to poll the buffer for completion. Seen another way, the kernel-
side has got to wait until the user-side has "figured out" that it needs
to commit content to disk. As it was originally, it was relatively
straightforward to dertermine why data was lost: ok, we've signaled it
from kernel space, but the daemon never flushed it out. Without commit/
deliver, things are much less clear, and I still miss what gain we
are making by removing them.

I would very much like to see the commit/deliver functionality back.
Such mechanisms are required for any sane producer-consumer model.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
