Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbVDAH1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbVDAH1b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 02:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbVDAH1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 02:27:31 -0500
Received: from fire.osdl.org ([65.172.181.4]:24240 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262651AbVDAH13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 02:27:29 -0500
Date: Thu, 31 Mar 2005 23:26:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       jlan@engr.sgi.com, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [1/1] CBUS: new very fast (for insert operations) message bus
 based on kenel connector.
Message-Id: <20050331232625.09057712.akpm@osdl.org>
In-Reply-To: <1112337814.9334.42.camel@uganda>
References: <20050320112336.2b082e27@zanzibar.2ka.mipt.ru>
	<20050331162758.44aeaf44.akpm@osdl.org>
	<1112337814.9334.42.camel@uganda>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> > > +static int cbus_event_thread(void *data)
>  > > +{
>  > > +	int i, non_empty = 0, empty = 0;
>  > > +	struct cbus_event_container *c;
>  > > +
>  > > +	daemonize(cbus_name);
>  > > +	allow_signal(SIGTERM);
>  > > +	set_user_nice(current, 19);
>  > 
>  > Please use the kthread api for managing this thread.
>  > 
>  > Is a new kernel thread needed?
> 
>  Logic behind cbus is following: 
>  1. make insert operation return as soon as possible,
>  2. deferring actual message delivering to the safe time
> 
>  That thread does second point.

But does it need a new thread rather than using the existing keventd?
