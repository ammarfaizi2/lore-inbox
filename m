Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265015AbTFRABn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 20:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265019AbTFRABm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 20:01:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43157 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265015AbTFRABl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 20:01:41 -0400
Date: Wed, 18 Jun 2003 01:15:34 +0100
From: Joel Becker <jlbec@evilplan.org>
To: John Myers <jgmyers@netscape.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: [PATCH 2.5.71-mm1] aio process hang on EINVAL
Message-ID: <20030618001534.GJ7895@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	John Myers <jgmyers@netscape.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-aio@kvack.org" <linux-aio@kvack.org>
References: <1055810609.1250.1466.camel@dell_ss5.pdx.osdl.net> <3EEE6FD9.2050908@netscape.com> <20030617085408.A1934@in.ibm.com> <1055884008.1250.1479.camel@dell_ss5.pdx.osdl.net> <3EEFAC58.905@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EEFAC58.905@netscape.com>
User-Agent: Mutt/1.4.1i
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 05:03:36PM -0700, John Myers wrote:
> >I prefer getting the error on io_submit.
> > 
> >
> I prefer getting the error on io_getevents().  The code that handles the 

POSIX 1003.1 says this about aio_read() and aio_write():

	If an error condition is encountered during queuing, the function
	call shall return without having initiated or queued the request.

If you intend to ever allow a POSIX wrapper to these interfaces (I have
one, for instance), you need to return EINVAL, EBADF, and the like from
io_submit().  Note that io_submit() has read-like semantics, so an
additional call may be necessary if some iocbs were successfully queued.

A user has to handle EAGAIN, so io_submit() cannot return void, and you
already have error handling logic here.

Joel


-- 

"Born under a bad sign.
 I been down since I began to crawl.
 If it wasn't for bad luck,
 I wouldn't have no luck at all."

			http://www.jlbec.org/
			jlbec@evilplan.org
