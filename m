Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVAREjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVAREjb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 23:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVAREjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 23:39:31 -0500
Received: from opersys.com ([64.40.108.71]:33547 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261230AbVAREj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 23:39:28 -0500
Message-ID: <41EC94BF.2080105@opersys.com>
Date: Mon, 17 Jan 2005 23:46:55 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Aaron Cohen <remleduff@gmail.com>
CC: Roman Zippel <zippel@linux-m68k.org>,
       Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org>	 <41E899AC.3070705@opersys.com>	 <Pine.LNX.4.61.0501160245180.30794@scrub.home>	 <41EA0307.6020807@opersys.com>	 <Pine.LNX.4.61.0501161648310.30794@scrub.home>	 <41EADA11.70403@opersys.com>	 <Pine.LNX.4.61.0501171403490.30794@scrub.home>	 <41EC2DCA.50904@opersys.com>	 <Pine.LNX.4.61.0501172323310.30794@scrub.home>	 <41EC8AA2.1030000@opersys.com> <727e501505011720303ba4f2cd@mail.gmail.com>
In-Reply-To: <727e501505011720303ba4f2cd@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Aaron Cohen wrote:
>   I've got a quick question and I just want to be clear that it
> doesn't have a political agenda behind it.

:)

> Here goes, why can't LTT and/or relayfs, work similar to the way
> syslog does and just fill a buffer (aka ring-buffer or whatever is
> appropriate), while a userspace daemon of some kind periodically reads
> that buffer and massages it.  I'm probably being naive but if the
> difficulty is with huge several hundred-gig files, the daemon if it
> monitors the buffer often enough could stuff it into a database or
> whatever high-performance format you need.

Because of the bandwidth it is not possible to do any sort of live
processing of any kind. The only thing the daemon can possibly do
is write large blocks of tracing info to disk as rapidly as possible.

>  It also seems to me that Linus' nascent "splice and tee" work would
> be really useful for something like this to avoid a lot of unnecessary
> copying by the userspace daemon.

There is no copying by the userspace daemon. All it does is open(),
then mmap(), and then it sleeps until it is woken up by the ltt
kernel subsystem. When that happens, it only does a write() on the
mmaped area, tells the ltt subsystem that it commited X number of
sub-buffers and goes back asleep. This is all zero-copy.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
