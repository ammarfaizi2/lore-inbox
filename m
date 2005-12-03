Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVLCCLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVLCCLz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 21:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVLCCLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 21:11:55 -0500
Received: from web32113.mail.mud.yahoo.com ([68.142.207.127]:26225 "HELO
	web32113.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751122AbVLCCLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 21:11:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=5BeUSXfLE1gY1p2/3pSHtuOIgfXEQerHqzmdTkvhTZd6+gLSL+QTYKJlqxkoLHniQs7Y5n60YBIWR07SggEVhK3P8Zbo1k/YLjUles2XlyYKKm8OvvGH2AXW/53i2gXoqnYWxqRGl6QpL4uu7Q3KwQsCk5+9yhHWfyuYzgcspNU=  ;
Message-ID: <20051203021154.30862.qmail@web32113.mail.mud.yahoo.com>
Date: Fri, 2 Dec 2005 18:11:54 -0800 (PST)
From: Vinay Venkataraghavan <raghavanvinay@yahoo.com>
Subject: Re: copy_from_user/copy_to_user question
To: Steven Rostedt <rostedt@goodmis.org>, Al Viro <viro@ftp.linux.org.uk>
Cc: Vinay Venkataraghavan <raghavanvinay@yahoo.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1133575346.4894.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > > > Secondly, they seem to use memcpy as opposed
> to using
> > > > copy_to_user/copy_from_user which is also very
> > > > dangerous.
> > > 
> > > If they are grabbing data from user context into
> kernel (or vise versa)
> > > that could easily cause an oops.  Not to mention
> it is a security risk.
> > 
> > Not to mention it simply won't work on a many
> platforms, no matter what...
> 
> Hmm, I've only worked with a few platforms (i386,
> x86_64, ppc, mips, and
> a little arm but I don't remember that much).  I
> believe that a memcpy
> could work on all these platforms (error prone of
> course, but if the
> memory is mapped its OK).  

When entering a system
> call, the kernel still
> has access to the memory locations assigned to the
> user.
> 

But this is not always the case right. The point that
you mention above is specifically why I posted this
question. It could well be the case that the   user
space page could be swapped out when the user space
process is blocked. So when the ioctl is serviced in
kernel space, there is no guarantee that the page is
still mapped. This could cause a page fault. 
I think this is why we need to do a
copy_to_user/copy_from_user.

The piece of code that I am talking about is part of a
driver code. Unfortunately I am not at liberty to
divulge the name of the company. So in the driver then
are not using copy_to_user and copy_from_user. That is
what puzzles me. Moreover, where they are using these
functions they use memcpy which is a big security
risk.

Thanks once again.
Vinay



		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 

