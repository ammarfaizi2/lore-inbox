Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268894AbTGOQrk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268898AbTGOQrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:47:40 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:48862 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268894AbTGOQri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:47:38 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16148.13163.8540.323403@gargle.gargle.HOWL>
Date: Tue, 15 Jul 2003 12:01:31 -0500
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Cc: Tom Zanussi <zanussi@us.ibm.com>, linux-kernel@vger.kernel.org,
       karim@opersys.com, bob@watson.ibm.com
Subject: Re: [RFC][PATCH 0/5] relayfs
In-Reply-To: <1058287227.377.17.camel@sherbert>
References: <16148.6807.578262.720332@gargle.gargle.HOWL>
	<1058282847.375.3.camel@sherbert>
	<16148.9560.602996.872584@gargle.gargle.HOWL>
	<1058287227.377.17.camel@sherbert>
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gianni Tedesco writes:
 > On Tue, 2003-07-15 at 17:01, Tom Zanussi wrote:
 > > Gianni Tedesco writes:
 > >  > 
 > >  > Could this be used to replace mmap() packet socket, how does it compare?
 > > 
 > > I think so - you could send high volumes of packet traffic to a bulk
 > > relayfs channel and read it from the mmap'ed relayfs file in user
 > > space.  The Linux Trace Toolkit does the same thing with large volumes
 > > of trace data - you could look at that code as an example
 > > (http://www.opersys.com/relayfs/ltt-on-relayfs.html).
 > 
 > What are the semantics of the mmap'ing the buffer? With mmaped packet
 > socket the userspace (read-side) requires no sys-calls apart from when
 > the buffer is empty, it then uses poll(2) to sleep until something new
 > is put in the buffer. Can relayfs do a similar thing? poll is not
 > mentioned in the docs...

You're right - I haven't implemented poll() in the relayfs VFS code
yet.  I plan on doing that next, but won't have much time for the next
couple of weeks.  Currently, you'd have to do something like LTT does,
which is have the kernel side signal the read-side when data is ready.

Tom

 > 
 > Thanks.
 > 
 > -- 
 > // Gianni Tedesco (gianni at scaramanga dot co dot uk)
 > lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
 > 8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D
 > 

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

