Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWJHAjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWJHAjP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 20:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWJHAjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 20:39:15 -0400
Received: from gw.goop.org ([64.81.55.164]:52123 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750766AbWJHAjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 20:39:14 -0400
Message-ID: <452848B6.5060401@goop.org>
Date: Sat, 07 Oct 2006 17:39:18 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Andrew Morton <akpm@osdl.org>,
       "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       tim.c.chen@linux.intel.com, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
References: <B41635854730A14CA71C92B36EC22AAC3F3FAD@mssmsx411>	 <20061004102812.5f3b22d2.akpm@osdl.org> <1160267327.2368.12.camel@localhost.localdomain>
In-Reply-To: <1160267327.2368.12.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114935833125957&w=2
>
> That was different, since we were putting a likely condition in an
> unlikely(). But I still don't see why we would ever want to test
> __warn_once before the condition, since it doesn't save on anything and
> just adds extra work.  I don't see the savings.
>   

Also, in that thread you cite (__warn_once && (condition)) is flat-out 
wrong, because condition may have a side-effect.  There are plenty of 
places in the code which use BUG_ON or WARN_ON as a general error 
checking mechanism which expect the condition to be always evaluated 
once; WARN_ON_ONCE should be the same.

Personally I think it is poor style, but there you are.

    J
