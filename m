Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUIJBXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUIJBXg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 21:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266836AbUIJBXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 21:23:34 -0400
Received: from open.hands.com ([195.224.53.39]:29664 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S265395AbUIJBXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 21:23:30 -0400
Date: Fri, 10 Sep 2004 02:34:45 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] update: _working_ code to add device+inode check to ipt_owner.c
Message-ID: <20040910013445.GF11160@lkcl.net>
References: <20040909162200.GB9456@lkcl.net> <20040909091931.K1973@build.pdx.osdl.net> <20040909181034.GF10046@lkcl.net> <20040909114846.V1924@build.pdx.osdl.net> <20040909212514.GA10892@lkcl.net> <20040909160449.E1924@build.pdx.osdl.net> <20040910000819.GA7587@lkcl.net> <20040909172134.G1924@build.pdx.osdl.net> <20040910005932.GA11160@lkcl.net> <20040909180838.H1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909180838.H1924@build.pdx.osdl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 06:08:38PM -0700, Chris Wright wrote:
> * Luke Kenneth Casson Leighton (lkcl@lkcl.net) wrote:
> > On Thu, Sep 09, 2004 at 05:21:35PM -0700, Chris Wright wrote:
> > > >  under such circumstances [file descs passed between programs]...
> > > >  you would end up having to create _two_ program-specific rules, like
> > > >  above.
> > > > 
> > > >  one for each of the two programs.
> > > 
> > > Actually you wouldn't, just one.  It will match, then one of those
> > > processes will get woken up and receive the data, regardless of whether
> > > you meant to allow it.  
> > 
> >  blehhrrr....
> > 
> >  oh i get it.  
> >  
> >  is that like someone writing really poor quality code where
> >  you have two processes reading from the same socket, wot like
> >  you're not supposed to do?
> 
> I don't think it's behaviour many apps rely on.  But this is exactly the
> kind of behaviour which can break security models.
> 
> >  or are there real instances / times where you really _do_ want
> >  that sort of thing to happen (xinetd?)
> 
> Well, xinted won't really read from multiple processes simultaneously
> (if all is working properly).  The xinetd server will see the initial
> packet, then fork/exec and close off all extra fds.  Now, try and write
> a firewall ruleset that mandatorily enforces that.  See the trouble?
 
 hmmm... *thinks*...

 thought-experiment:

 it'd involve doing a userspace rule that caught the packet.


> >  [btw the sk_socket->file thing isn't filled in on input packets,
> >   but you still get the packet.  arg.  how the heck does ip_queue
> >   get enough info???]
> 
> Heh, right.  The sock is protocol specific.  The input happening on ip
> level is before sock lookup.
 
 *neck muscles tensing causing head to vibrate at about 8Hz*
 rrrrrr arg!  

 okay - chris, anyone - got any tips on triggering socket lookup?

 what sort of things should i be looking for in netfilter that does
 the socket lookup?

