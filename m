Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbTI3Xmr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 19:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbTI3Xmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 19:42:47 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:43470 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261817AbTI3Xmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 19:42:44 -0400
Message-ID: <3F795001.9020104@mvista.com>
Date: Tue, 30 Sep 2003 04:42:25 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test6: more __init bugs
References: <1064955628.5734.229.camel@dooby.cs.berkeley.edu>
In-Reply-To: <1064955628.5734.229.camel@dooby.cs.berkeley.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert T. Johnson wrote:

>Here are some cases where __init code or data is referenced by 
>non-__init code.
>
>Questions:
>- Is init_module allowed, required or forbidden to be __init?
>- Ditto for Scsi_Host_Template.detect()?
>- Ditto for net_device->set_config()?
>
>Thanks for looking at these potential bugs, and sorry if I've made 
>any mistakes.
>
>Best,
>Rob
>
>P.S. All these bugs were found with Cqual, the bug-finding tool
>developed by Jeff Foster, John Kodumal, and many others, and available
>at http://www.cs.umd.edu/~jfoster/cqual/, although the currently
>released version of cqual only has primitive support for 
>__init bug-finding.
>
>
>** Possible bug:
>** drivers/char/ipmi/ipmi_msghandler.c:ipmi_init_msghandler()         (__init)
>     called by numerous non-__init functions
>Note: ipmi_init_msghandler() is an alias for init_module
>Fix: declare ipmi_init_msghandler non-__init.
>
>  
>
This is not actually a bug, but it may be bad style (and thus could lead 
to a bug).  It is possible that something that uses IPMI can do some 
IPMI things before IPMI is initialized.  This can only happen during 
initialization, though.  Thus the check; once IPMI is initialized the 
function will never be called.

What's the opinion on this?  Should I just force IPMI users to 
initialize after IPMI?

Thanks,

-Corey

