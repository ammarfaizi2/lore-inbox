Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262671AbVDAIDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbVDAIDt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 03:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbVDAIBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 03:01:40 -0500
Received: from fire.osdl.org ([65.172.181.4]:19383 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262666AbVDAIAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 03:00:40 -0500
Date: Thu, 31 Mar 2005 23:59:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       jlan@engr.sgi.com, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [1/1] CBUS: new very fast (for insert operations) message bus
 based on kenel connector.
Message-Id: <20050331235927.6d104665.akpm@osdl.org>
In-Reply-To: <1112341514.9334.103.camel@uganda>
References: <20050320112336.2b082e27@zanzibar.2ka.mipt.ru>
	<20050331162758.44aeaf44.akpm@osdl.org>
	<1112337814.9334.42.camel@uganda>
	<20050331232625.09057712.akpm@osdl.org>
	<1112341514.9334.103.camel@uganda>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> On Thu, 2005-03-31 at 23:26 -0800, Andrew Morton wrote:
> > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > >
> > > > > +static int cbus_event_thread(void *data)
> > >  > > +{
> > >  > > +	int i, non_empty = 0, empty = 0;
> > >  > > +	struct cbus_event_container *c;
> > >  > > +
> > >  > > +	daemonize(cbus_name);
> > >  > > +	allow_signal(SIGTERM);
> > >  > > +	set_user_nice(current, 19);
> > >  > 
> > >  > Please use the kthread api for managing this thread.
> > >  > 
> > >  > Is a new kernel thread needed?
> > > 
> > >  Logic behind cbus is following: 
> > >  1. make insert operation return as soon as possible,
> > >  2. deferring actual message delivering to the safe time
> > > 
> > >  That thread does second point.
> > 
> > But does it need a new thread rather than using the existing keventd?
> 
> Yes, it is much cleaner [especially from performance tuning point] 
> to use own kernel thread than pospone all work to the queued work.
> 

Why?  Unless keventd is off doing something else (rare), it should be
exactly equivalent.  And if keventd _is_ off doing something else then that
will slow down this kernel thread too, of course.

Plus keventd is thread-per-cpu and quite possibly would be faster.
