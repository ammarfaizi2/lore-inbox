Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTE0FRp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 01:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbTE0FRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 01:17:45 -0400
Received: from zok.sgi.com ([204.94.215.101]:35717 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263487AbTE0FRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 01:17:44 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Registering for notifier chains in modules (was Linux 2.4.21-rc3 - ipmi unresolved) 
In-reply-to: Your message of "Mon, 26 May 2003 23:45:39 EST."
             <3ED2ED73.7090300@acm.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 May 2003 15:30:43 +1000
Message-ID: <20707.1054013443@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 May 2003 23:45:39 -0500, 
Corey Minyard <minyard@acm.org> wrote:
>Keith Owens wrote:
>>>Why can't you have a module id in the notifier chain, and use a boolean
>>>to tell if it is set, or something similar to that?  That way you could
>>>mix them, if the bool is set then do the try_in_module_count thing, if
>>>not then just call the function.  It does add some components to the
>>>register structure, but that shouldn't hurt anything besides taking a
>>>little more memory.
>>
>>It is a change of API in a 2.4 kernel.  Not a good idea.
>>
>Does adding a field to a structure (where the user does not have to do
>anything with the
>field) change the API?  That would be the only API change here.

The user does have to do something.  Every piece of code that calls
notify_register has to set the new field to __THIS_MODULE.  WIthout
that field being set, you are no better off, the race still exists.

