Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbTE1ACC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 20:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTE1ACC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 20:02:02 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:39687 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id S264455AbTE1ACB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 20:02:01 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Corey Minyard <minyard@acm.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Registering for notifier chains in modules (was Linux 2.4.21-rc3 - ipmi unresolved) 
In-reply-to: Your message of "Tue, 27 May 2003 12:09:12 EST."
             <3ED39BB8.9030306@acm.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 28 May 2003 10:15:02 +1000
Message-ID: <8261.1054080902@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 May 2003 12:09:12 -0500, 
Corey Minyard <minyard@acm.org> wrote:
>viro@parcelfarce.linux.theplanet.co.uk wrote:
viro>>How the devil would registration code figure out which module should
viro>>be used?

I am glad that somebody gets it.

minyard>You create a new call that also takes the module as a parameter, and
minyard>have the old call set the module owner to NULL.  You export the new
minyard>call, and modules use it.

Which brings us right back to where we started.

* Find all users of notifier_chain_register() and change them to the
  new API.

* If any of the calls to notifier_chain_register() are in service
  routines then add a new parameter to the service routine to pass in
  the module owner.  There are several service routines that do this,
  especially in the network code.

* Find all callers of all the modified service routines and change them
  to use the new API for these service routines.

* Repeat until you have propagated the new API all the way out to the
  end points, to the only code that knows the module owner.

Not in 2.4 thanks.

