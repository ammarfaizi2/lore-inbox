Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262595AbVAPTpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbVAPTpE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 14:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVAPTpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 14:45:03 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:21910 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262595AbVAPToU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 14:44:20 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16874.52969.835525.775553@tut.ibm.com>
Date: Sun, 16 Jan 2005 14:30:33 -0600
To: Christoph Hellwig <hch@infradead.org>
Cc: Karim Yaghmour <karim@opersys.com>, Roman Zippel <zippel@linux-m68k.org>,
       Andi Kleen <ak@muc.de>, Nikita Danilov <nikita@clusterfs.com>,
       linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <20050116161437.GA26144@infradead.org>
References: <20050114002352.5a038710.akpm@osdl.org>
	<m1zmzcpfca.fsf@muc.de>
	<m17jmg2tm8.fsf@clusterfs.com>
	<20050114103836.GA71397@muc.de>
	<41E7A7A6.3060502@opersys.com>
	<Pine.LNX.4.61.0501141626310.6118@scrub.home>
	<41E8358A.4030908@opersys.com>
	<20050116161437.GA26144@infradead.org>
X-Mailer: VM 7.18 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
 > On Fri, Jan 14, 2005 at 04:11:38PM -0500, Karim Yaghmour wrote:
 > > 	Where does this appear in relayfs and what rights do
 > > 	user-space apps have over it (rwx).
 > 
 > Why would you want anything but read access?

This would allow an application to write trace events of its own to a
trace stream for instance.  Also, I added a user-requested 'feature'
whereby write()s on a relayfs channel would be sent to a callback that
could be used to interpret 'out-of-band' commands sent from the
userspace application.  And if lockless logging were being used, this
could provide a cheaper way for applications to write to the trace
buffer than having to do it via syscall.

 > 
 > > bufsize, nbufs:
 > > 	Usually things have to be subdivided in sub-buffers to make
 > > 	both writing and reading simple. LTT uses this to allow,
 > > 	among other things, random trace access.
 > 
 > I think random access is overkill.  Keeping the code simple is more
 > important and user-space can post-process it.
 > 
 > > resize_min, resize_max:
 > > 	Allow for dynamic resizing of buffer.
 > 
 > Auto-resizing sounds like a really bad idea.

It also doesn't seem to be really useful to anyone, so we should
probably remove it.

Tom

 > 
 > > init_buf, init_buf_size:
 > > 	Is there an initial buffer containing some data that should
 > > 	be used to initialize the channel's content. If you're doing
 > > 	init-time tracing, for example, you need to have a pre-allocated
 > > 	static buffer that is copied to relayfs once relayfs is mounted.
 > 
 > And why can't you do this from that code?  It just needs an initcall-like
 > thing that runs after mounting of relayfs.
 > 

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

