Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263952AbTE0Q4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 12:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbTE0Q4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 12:56:00 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:24054 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP id S263952AbTE0Qz7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 12:55:59 -0400
Message-ID: <3ED39BB8.9030306@acm.org>
Date: Tue, 27 May 2003 12:09:12 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: Keith Owens <kaos@ocs.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Registering for notifier chains in modules (was Linux 2.4.21-rc3
 - ipmi unresolved)
References: <20707.1054013443@kao2.melbourne.sgi.com> <3ED37AD5.7020607@acm.org> <20030527160247.GA27916@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030527160247.GA27916@parcelfarce.linux.theplanet.co.uk>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Tue, May 27, 2003 at 09:48:53AM -0500, Corey Minyard wrote:
>
>  
>
>>>The user does have to do something.  Every piece of code that calls
>>>notify_register has to set the new field to __THIS_MODULE.  WIthout
>>>that field being set, you are no better off, the race still exists.
>>>
>>>      
>>>
>>Why?  The user doesn't have to set the field, you can let the
>>registration code do that.  I have attached a patch as an example.
>>    
>>
>
>How the devil would registration code figure out which module should
>be used?
>  
>
You create a new call that also takes the module as a parameter, and
have the old call set the module owner to NULL.  You export the new
call, and modules use it.

-Corey

