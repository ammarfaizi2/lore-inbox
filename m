Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbUJ0LhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbUJ0LhO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 07:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbUJ0LhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 07:37:13 -0400
Received: from dslsmtp.struer.net ([62.242.36.21]:32520 "EHLO
	dslsmtp.struer.net") by vger.kernel.org with ESMTP id S262383AbUJ0LhF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 07:37:05 -0400
Message-ID: <61303.194.237.142.5.1098877021.squirrel@194.237.142.5>
In-Reply-To: <20041027083857.GK10638@michonline.com>
References: <1098254970.3223.6.camel@gaston>
    <1098256951.26595.4296.camel@d845pe>
    <Pine.LNX.4.58.0410200728040.2317@ppc970.osdl.org>
    <20041025234736.GF10638@michonline.com> <417E39AE.5020209@arcom.com>
    <20041026122632.GH10638@michonline.com>
    <20041026190815.GA8338@mars.ravnborg.org>
    <20041027083857.GK10638@michonline.com>
Date: Wed, 27 Oct 2004 13:37:01 +0200 (CEST)
Subject: Re: Versioning of tree
From: "Sam Ravnborg" <sam@ravnborg.org>
To: "Ryan Anderson" <ryan@michonline.com>
Cc: "David Vrabel" <dvrabel@arcom.com>, "Linus Torvalds" <torvalds@osdl.org>,
       "Len Brown" <len.brown@intel.com>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Sam Ravnborg" <sam@ravnborg.org>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Oct 26, 2004 at 09:08:15PM +0200, Sam Ravnborg wrote:
>> On Tue, Oct 26, 2004 at 08:26:33AM -0400, Ryan Anderson wrote:
>> > > Surely there's no need for this?  Can't the script spit out an
>> > > appropriate localversion* file instead?
>> >
>> > It can, and yes, my first version used that method.
>> >
>> > Except it never worked.  I was able to generate the file before
>> > include/linux/version.h was rebuilt, but failed to get it picked up in
>> > that.  I'm not really sure why.
>>
>> The $(wildcard ...) function was executed before you created the file.
>
> Can you explain why?

GNU make distingush between ":=" and "=".
An assignment made using ":=" is done immediatly.
So when make first encounter ":=" is will execute the $(wildcard ...)
function, long
before you create the localversion-bk file.

If instead "=" is used the evaluation will be deferred until you actually
dereference the variable - so here the localversion-bk fiel may well be
created.

>
>> If we shall retreive the version from a SCM then as you already do
>> must hide it in a script.
>
>> I want the script only to be executed when we actually ask kbuild to
>> build a kernel - so it has to be part of the prepare rule set.
>
> As part of the prepare ruleset, should I simply add a prepare3 (and hook
> it in appropriately), or do you mean, just have it in the same section
The prepare part is more or less made to have full control on order of
the rules - so a make -j 50 goes well.
So just hooking it under prepare1 should do the trick.

>
> The patch below has both the Perl and shell script in it, as well as the
> added config option to disable this feature.

Will take a look when I'm on my Linux box.

   Sam


