Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161123AbVIPIHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbVIPIHJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 04:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbVIPIHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 04:07:09 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:13020 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161123AbVIPIHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 04:07:06 -0400
Subject: Re: [patch 2/7] s390: 3270 fullscreen view.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org, rbh00@utsglobal.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050915172432.GA9980@kroah.com>
References: <20050914155345.GA11478@skybase.boeblingen.de.ibm.com>
	 <20050914161022.GA4230@infradead.org>
	 <1126719107.4908.29.camel@localhost.localdomain>
	 <20050915172432.GA9980@kroah.com>
Content-Type: text/plain
Date: Fri, 16 Sep 2005 10:07:08 +0200
Message-Id: <1126858028.4923.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-15 at 10:24 -0700, Greg KH wrote:
> On Wed, Sep 14, 2005 at 07:31:46PM +0200, Martin Schwidefsky wrote:
> > +struct class *class3270;
> 
> Isn't this a tty driver already?  If so, you don't need to create your
> own class, your devices will just show up in the /sys/class/tty/ area
> just fine.
> 
> Or am I missing something here?

I don't think we can use the tty class for the 3270 driver. The reason
is that there are several ways to access the 3270 device. One of them is
the tty view. Another is the fullscreen view that has nothing to do with
ttys. It allows an application to create its own 3270 data stream
without the line discipline of the tty interfering. 3270 devices are
strange beasts when you compare them to you standard terminal. You don't
get an interrupt for every character you type, but only if special keys
are pressed. One of them is <enter>. The current implementation of the
tty view has an input line at the end of the 3270 screen and we get
complete lines as input. That halfway works for normal command input
although tab completion doesn't work. It completly breaks for editors,
e.g. if you try to use vi on a 3270 tty you are in for nasty surprises.
The only way to get an editor working on the 3270 is the fullscreen view
where the editor itself can setup the complete screen. If you ever used
an editor on an classic s390 operating system you know what I'm talking
about.

To cut the long story short, there is more to a 3270 device then the tty
view. In fact you can compile the 3270 driver without the tty view and
only with the fullscreen view. We still should have a class for the
devices, do we not ?

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


