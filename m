Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316650AbSEaTG3>; Fri, 31 May 2002 15:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316653AbSEaTG2>; Fri, 31 May 2002 15:06:28 -0400
Received: from THANK.THUNK.ORG ([216.175.175.163]:19074 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S316650AbSEaTG1>;
	Fri, 31 May 2002 15:06:27 -0400
Date: Fri, 31 May 2002 15:05:39 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@redhat.com>,
        jw schultz <jw@pegasys.ws>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: wait queue process state
Message-ID: <20020531190539.GA3965@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	David Woodhouse <dwmw2@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Benjamin LaHaise <bcrl@redhat.com>, jw schultz <jw@pegasys.ws>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1022676201.9255.160.camel@irongate.swansea.linux.org.uk> <1022631707.4123.151.camel@irongate.swansea.linux.org.uk> <3CF2A0FB.8090507@um.edu.mt> <1022572663.12203.127.camel@pc-16.office.scali.no> <20020528160143.G885@pegasys.ws> <20020528190518.E21009@redhat.com> <2338.1022669938@redhat.com> <9160.1022673363@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 12:56:03PM +0100, David Woodhouse wrote:
> 
> alan@lxorguk.ukuu.org.uk said:
> >  Given an infinite number of monkeys yes. The 'disk I/O is not
> > interruptible' assumption is buried in vast amounts of software. This
> > isnt a case of sorting out a few misbehaving applications, you can
> > start with some of the most basic unix programs like 'ed' and work
> > outwards.
> 
> Still probably worth doing in the long term. In the short term, we could 
> possibly have a sysctl or personality flag to disable it for the benefit of 
> broken software. I'm in favour of just letting it break though, to be 
> honest - it's _already_ possible to trigger the breakage in some 
> circumstances and making it more reproducible is a _good_ thing.

If you really think this is important thing to do, I suggest you
create a kernel patch which returns a partial read/write whenever the
the size is even (and return an odd number of bytes), thus
guaranteeing that 50% of the time, any I/O appears to have been
interrupted.

Then run it on a system, and see what breaks.  I wouldn't suggest
doing this on any system that you care about, though!

							- Ted
