Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbVGMANQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbVGMANQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 20:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVGMANL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 20:13:11 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:19363 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262331AbVGMAIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 20:08:20 -0400
Subject: Re: Merging relayfs?
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: zanussi@us.ibm.com, jbaron@redhat.com, richardj_moore@uk.ibm.com,
       varap@us.ibm.com, karim@opersys.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050712165510.7081c716.akpm@osdl.org>
References: <17107.6290.734560.231978@tut.ibm.com>
	 <Pine.LNX.4.61.0507121050390.25408@dhcp83-105.boston.redhat.com>
	 <1121183607.6917.47.camel@localhost.localdomain>
	 <17107.60140.948145.153144@tut.ibm.com>
	 <1121185393.6917.59.camel@localhost.localdomain>
	 <17107.61864.621401.440354@tut.ibm.com>
	 <1121186981.6917.67.camel@localhost.localdomain>
	 <17107.63309.475838.635711@tut.ibm.com>
	 <17108.14426.607378.262959@tut.ibm.com>
	 <1121211655.3548.28.camel@localhost.localdomain>
	 <20050712165510.7081c716.akpm@osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 12 Jul 2005 20:08:00 -0400
Message-Id: <1121213280.3548.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 16:55 -0700, Andrew Morton wrote:
> Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I will also admit that my ring buffers lost one byte per page.  Because
> >  I wanted to save on space with the accounting, and only had a start and
> >  end pointer per page.  So when start and end were equal, the buffer was
> >  considered empty and when end was one less than start, it was considered
> >  full. But since end always pointed to an empty spot, it would still be
> >  empty when the buffer was full, thus wasting one byte per page. But to
> >  solve this, I would either have to add another variable in the buffer
> >  page descriptor (adding at least one byte, but probably 4 bytes) which
> >  would just be more waste, or I would have to make a complex system even
> >  more complex (ie. adding a flag on the end pointer at the MSB to
> >  differentiate between end being empty or filled).
> 
> Nope.  Just make the indices 32-bit numbers and let them wrap.
> 
> Full:		(tail - head) == size
> Empty:		(tail - head) == 0
> Add item:	buf[head++ & (size-1)] = item;
> Remove item:	buf[tail++ & (size-1)]

You know I knew someone would have an answer.  Look for version 0.2.1
comming soon :-)

Thanks,

-- Steve


