Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWCPR7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWCPR7L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbWCPR7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:59:11 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:56019
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932474AbWCPR7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:59:09 -0500
Date: Thu, 16 Mar 2006 09:58:58 -0800
From: Greg KH <greg@kroah.com>
To: "Artem B. Bityutskiy" <dedekind@yandex.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Bug? Report] kref problem
Message-ID: <20060316175858.GA7124@kroah.com>
References: <1142509279.3920.31.camel@sauron.oktetlabs.ru> <20060316165323.GA10197@kroah.com> <4419A426.9080908@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4419A426.9080908@yandex.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 08:45:10PM +0300, Artem B. Bityutskiy wrote:
> 
> Greg KH wrote:
> >Don't statically create kobjects, it's not nice.  But the real problem
> >is below...
> 
> Well, that was just an example...
> 
> But in real life I do use a static kobject in one case, so I'm very 
> interested what should I do instead. I have a subsystem, and I want it 
> to put all its stuff in a /sys/A directory. So I just define a static 
> kobject for A and assign a dummy release function to it. Why is this bad?

If you use decl_subsys(), you should be fine for this.  Use that instead
of trying to roll your own subsystem kobjects please.  That
infrastructure was written for a reason...

> And what should I do instead? kmalloc(sizeof(struct kobject), 
> GFP_KERNEL) ? I do not have a dynamic structure corresponding to my 
> module. I have many data structures corresponding to entities my object 
> handles and I have one static array which refers them. All is simple. I 
> do not want to introduce a dynamic data structure corresponding to the 
> subsystem as a whole just in order to not use static kobjects.

Data (kobjects) have a different lifespan than code (modules).
Seperating them is a good idea, and if not, your reference counting
issues can be quite nasty.  See the recent EDAC fiasco for a good
example of how easy it is to mess things up in this manner.

thanks,

greg k-h
