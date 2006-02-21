Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbWBUSkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbWBUSkb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 13:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWBUSkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 13:40:31 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:16398 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932611AbWBUSka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 13:40:30 -0500
Message-ID: <43FB5E75.5010800@shadowen.org>
Date: Tue, 21 Feb 2006 18:39:49 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christopher Friesen <cfriesen@nortel.com>
CC: Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove ccache from top level Makefile and make configurable
References: <43F9B8A9.4000506@reub.net> <20060220193616.GA16407@shadowen.org> <43FA3706.5080401@nortel.com>
In-Reply-To: <43FA3706.5080401@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Friesen wrote:
> Andy Whitcroft wrote:
> 
>> remove ccache from top level Makefile and make configurable
> 
> Isn't it already configurable?

Yes and no.  You can specify CC, but you need to know the form of that
line.  Ok, we do now but will be in the future.  If it changes then the
semantics to use CCACHE would change.  This seem like something to avoid.

>> diff -upN reference/Makefile current/Makefile
>> --- reference/Makefile
>> +++ current/Makefile
>> @@ -171,9 +171,11 @@ SUBARCH := $(shell uname -m | sed -e s/i
>>  # Alternatively CROSS_COMPILE can be set in the environment.
>>  # Default value for CROSS_COMPILE is not to prefix executables
>>  # Note: Some architectures assign CROSS_COMPILE in their arch/*/Makefile
>> +# CCACHE specifies the name of a ccache binary to use with gcc.
>>  
>>  ARCH        ?= $(SUBARCH)
>>  CROSS_COMPILE    ?=
>> +CCACHE        ?=
> 
> 
> This sets it to nothing if it isn't already set--seems like you should
> be able to set it on the commandline or else it has no effect.

Yes this would really allow a subarch to set it if it wanted to, which
isn't likely to.  It can probabally be killed.

-apw
