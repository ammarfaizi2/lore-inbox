Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVAWH5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVAWH5K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 02:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVAWH5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 02:57:10 -0500
Received: from opersys.com ([64.40.108.71]:49930 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261250AbVAWH5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 02:57:04 -0500
Message-ID: <41F35B4D.5090409@opersys.com>
Date: Sun, 23 Jan 2005 03:07:41 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>
Subject: Re: [PATCH] relayfs redux for 2.6.10: lean and mean
References: <41EF4E74.2000304@opersys.com> <20050120145046.GF13036@kroah.com> <41F05D11.5020109@opersys.com> <20050121064341.GC19288@kroah.com>
In-Reply-To: <20050121064341.GC19288@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH wrote:
> Are they willing to trade off the performance of LTT to get this?  I
> thought this was being touted as a "when you need to test" type of
> thing, not a "run it all the time" type of feature.

The problem is that you never know beforehand when you're going to
get that weird glitch on your server, or how much time you're going
to need to reproduce it. People who manage thousands of servers
will want to be able to fire this off at will without having to
reboot/recompile their kernel. What has to be done is make the cost
of the tracing infrastructure as minimal as possible when it is
indeed built into the kernel (of course if it's disabled it should
cost the same thing as if it wasn't there to boot: nothing.) This,
though, is a separate topic which is being addressed in other threads.
Have a look at Werner's resent postings if you're interested on the
"[RFC] instrumentation" thread.

> And a driver will never want to have both a relay channel, and a simple
> debug output at the same time?  You are now requiring them to look for
> that data in two different points in the fs.
[snip]
> So, since you are proposing that relayfs be mounted all the time, where
> do you want to mount it at?  I had to provide a "standard" location for
> debugfs for people to be happy with it, and the same issue comes up
> here.
> 
> Also, why not export your relayfs ops so that someone useing debugfs can
> create a relay channel in it, or in any other type of fs they might
> create?

Ok, there are a couple of things in there:

- First I don't object to having the relayfs ops being exported so that
they could be used in conjunction with other filesystems, in addition
to having relayfs live as an independent fs. So as in the case above, we
should be able to accomodate the device driver writer who wants to have
all his files in the same fs. However, for the first case relayfs was
built for, I think there is merit for having it live as a separate fs.
Is this a good compromise for you?

- As for where relayfs should be mounted, then this is a very good
question. We've taken to the habit of having a /relayfs. If this is
too problematic, I don't see any problem with /mnt/relayfs also. In
either case, I have to admit frankly that I'm not familiar with the
exact formal rules for introducing something like this. Of course
I'm aware of the FHS and LSB, but let me know what you think is the
best way to proceed here.

Thanks,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
