Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbUL3MNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbUL3MNR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 07:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbUL3MNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 07:13:17 -0500
Received: from web60605.mail.yahoo.com ([216.109.118.243]:26551 "HELO
	web60605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261622AbUL3MNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 07:13:11 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=F0b2ARCJYBRDjz5h2CcQ7dPU/CnQ4wyrBT36F0Ahs1nFj4vUaJ37BniUc530/n7xtHI1wZhQLfYcJEeamUkhZLO2orvwPd+3lCP4rOInWzt+oB7C357j1mnJ6iHtCMXCHzcTpppo73XB1oD7AAVZFW/TprBXkSnP/bYDPs7RjjI=  ;
Message-ID: <20041230121310.41867.qmail@web60605.mail.yahoo.com>
Date: Thu, 30 Dec 2004 04:13:10 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Bug_reply : Out of range ptr error in module indicates bug in slab.c
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1104405521.4170.10.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello,
     Thanks for ur help. The user will be changing
this using system calls like dup,dup2 etc. If I keep
track of all these modifications by intercepting all
those syscalls and use inode number for identifying
the structure uniquely, will it break?

Thanks,
selva

> nagendran wrote:
> > 		else	{
> > 			new -> pipe_read_end = fdes[0];
> > 			new -> pipe_write_end = fdes[1];
> 
> this is a bug; fdes is a USERSPACE pointer, you
> cannot directly access
> that from kernel space, you need to use
> copy_from_user() for that.
> 
> And note, what you are doing is unreliable, since
> the user is capable of
> changing that information before you log it in your
> structure, so if you
> want to use the data you log for anything security
> related or for
> something that has to be accurate, it's broken...
> 
> > 	while(temp != NULL)
> > 	{
> > 		kfree(temp);
> > 		temp = temp -> next;
> > 	}
> 
> that is of course wrong; you free temp and THEN you
> access it!!
> 
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
__________________________________ 
Do you Yahoo!? 
Read only the mail you want - Yahoo! Mail SpamGuard. 
http://promotions.yahoo.com/new_mail 
