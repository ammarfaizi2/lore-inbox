Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267400AbUJGPyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267400AbUJGPyA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 11:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUJGPyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 11:54:00 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:15791 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267400AbUJGPxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 11:53:47 -0400
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martijn Sipkema <martijn@entmoot.nl>
Cc: Paul Jakma <paul@clubi.ie>, Chris Friesen <cfriesen@nortelnetworks.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       "David S. Miller" <davem@davemloft.net>, joris@eljakim.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <001f01c4ac8b$35849710$161b14ac@boromir>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
	 <20041006080104.76f862e6.davem@davemloft.net>
	 <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
	 <20041006082145.7b765385.davem@davemloft.net>
	 <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com>
	 <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org>
	 <4164EBF1.3000802@nortelnetworks.com>
	 <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org>
	 <001601c4ac72$19932760$161b14ac@boromir>
	 <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org>
	 <001c01c4ac76$fb9fd190$161b14ac@boromir>
	 <1097156727.31753.44.camel@localhost.localdomain>
	 <001f01c4ac8b$35849710$161b14ac@boromir>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097160628.31614.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 07 Oct 2004 15:50:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-07 at 17:32, Martijn Sipkema wrote:
> > For a strict posix system, but then if we were a strict posix/sus system
> > you wouldn't be able to use mmap. Also the kernel doesn't claim to
> > implement posix behaviour, it avoids those areas were posix is stupid.
> 
> mmap() _is_ in POSIX AFAIK. Also, there are other standards for things
> that aren't in POSIX, but these are supersets.

I'll quote SuSv3 to illustrate the danger of "specifications"

"The system shall always zero-fill any partial page at the end of an
object. Further, the system shall never write out any modified portions
of the last page of an object which are beyond its end. References
within the address range starting at pa and continuing for len bytes to
whole pages following the end of an object shall result in delivery of a
SIGBUS signal."

Its a mistake, its not apparent if its actually meant something entirely
different or someone forgot a "not", or what is going on.

It certainly isnt a useful definition of mmap.

> > POSIX_ME_HARDER was an environment variable GNU tools used when users
> > wanted them to do stupid but posix mandated things instead of sensible
> > things. It was later changed to POSIXLY_CORRECT, which lost the point
> > somewhat.
> 
> I actually also don't agree with this behaviour of the GNU tools..

Thankfully you seem to be in the minority

> > I doubt that. Sane applications are written to the BSD socket API not
> > POSIX 1003.1g draft 6.4 and relatives.
> 
> Perhaps... I get the idea that I just seem to value a standard operating
> system interface more than you do; it would be a loss IMHO if people
> were forced to write for Linux instead of being able to write portable
> applications.

Portable applications don't work if you get that close to the grey areas
of a standard. Also you'll find the SuS spec simply doesn't work sanely
for some applications. Bind() is instant connect can block for example.
Now try implementing netbios - bind blocks, connect is instant, and the
posix spec is toiler paper grade at this point.

Likewise we have an MS-DOS FS. Its not POSIX behaviour. Should we remove
it, require a different set of system calls or decide that religious
application of standards is not useful.

Linux applies standards pragmatically. A setsockopt for strict socket
compliance might make sense. It'll trash the app performance for UDP but
it would allow users to select useful v posix.

Alan

