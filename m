Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWA0M3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWA0M3J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 07:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWA0M3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 07:29:09 -0500
Received: from smtpout.mac.com ([17.250.248.97]:62692 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964993AbWA0M3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 07:29:07 -0500
In-Reply-To: <m1d5ieghyi.fsf@ebiederm.dsl.xmission.com>
References: <1137518714.5526.8.camel@localhost.localdomain> <20060118045518.GB7292@kroah.com> <1137601395.7850.9.camel@localhost.localdomain> <m1fyniomw2.fsf@ebiederm.dsl.xmission.com> <43D14578.6060801@watson.ibm.com> <m1hd7xmylo.fsf@ebiederm.dsl.xmission.com> <CC5052ED-FEC1-4B0C-A8A7-3CD190ADF0D3@mac.com> <m18xt8mffq.fsf@ebiederm.dsl.xmission.com> <1137945325.3328.17.camel@laptopd505.fenrus.org> <m14q3wmds4.fsf@ebiederm.dsl.xmission.com> <20060126200142.GB20473@MAIL.13thfloor.at> <m1d5ieghyi.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <64FD72B7-91BF-4FEF-A595-0978F361A581@mac.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>,
       Arjan van de Ven <arjan@infradead.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
Date: Fri, 27 Jan 2006 07:27:43 -0500
To: "Eric W. Biederman" <ebiederm@xmission.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 27, 2006, at 04:04, Eric W. Biederman wrote:
> Basically my concern is that by using task structs internally the  
> kernel will start collecting invisible zombies.

So come up with a task_struct weakref system.  Maintain an (RCU?)  
linked list of struct task_weakref in the struct task_struct, and  
when the task struct is about to go away, run around all of the  
weakrefs and change their pointers to NULL.  The user of the weakref  
should check if the pointer is NULL and handle accordingly.  Sure, it  
would be tricky to get the locking right, but a couple extra bytes  
for a struct task_weakref would be a lot better than a whole pinned  
struct task_struct.

Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/ 
philosophy/) software stuff and not get a real job. Charles Schulz  
had the best answer:

"Why do musicians compose symphonies and poets write poems? They do  
it because life wouldn't have any meaning for them if they didn't.  
That's why I draw cartoons. It's my life."
   -- Charles Schulz


