Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTETBZr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 21:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263449AbTETBZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 21:25:47 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:60121 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP id S263448AbTETBZq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 21:25:46 -0400
Message-ID: <3EC98D9D.1080309@kegel.com>
Date: Mon, 19 May 2003 19:06:21 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Davide Libenzi <davidel@xmailserver.org>,
       John Myers <jgmyers@netscape.com>, linux-aio@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Comparing the aio and epoll event frameworks.
References: <200305192333.QAA12018@pagarcia.nscp.aoltw.net> <Pine.LNX.4.55.0305191657540.6565@bigblue.dev.mcafeelabs.com> <3EC9807D.3080804@kegel.com> <Pine.LNX.4.55.0305191743230.6565@bigblue.dev.mcafeelabs.com> <20030520010258.GQ2444@holomorphy.com> <3EC986ED.80604@kegel.com> <20030520011541.GR2444@holomorphy.com>
In-Reply-To: <20030520011541.GR2444@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>I think this would be useful for network daemons that would like to
>>>fairly schedule responses (i.e. not re-arm until a client on a given fd
>>>deserves a turn again). IRC daemons would appear to be a perfect
>>>candidate for such.  ...
> 
> 
> On Mon, May 19, 2003 at 06:37:49PM -0700, Dan Kegel wrote:
> 
>>No need.  The plain old edge triggered behavior can handle this
>>nicely.
> 
> 
> AIUI after the iospace on an fd is exhausted the event will be re-armed.
> It could probably be taken and then ignored until the client deserves a
> response again. Is that what you had in mind?

In edge-triggered mode, epoll will deliver an event only when events warrant it (sic).
If you decide to starve a client for a while, that client's fd
will only get an event or two as the last bits of I/O to it
occur; after that, no more events will come in unless you do
some I/O.

So I guess I'm saying "remember the fact that you got the event, but
don't do anything about it until you feel like it".
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

