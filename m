Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbVIFL7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbVIFL7w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 07:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbVIFL7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 07:59:52 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:26895 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964831AbVIFL7v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 07:59:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ffnp2Wuv8VDMcsIL6mOX5H+rcmTOFSGVtSgM+Fqw0rZG9RvO79f563fbCwxPuHodSEWqkeb1T5pV2LIN9UW5kYleEtmG8i40aQ/pNObXsoU2+FJitkQ+73GZuRM5d9JCIrxYF18iqCYedjW6+jv9AjAEez6ptZwv8St8rsAsoHo=
Message-ID: <6b5347dc05090604596ac08cb6@mail.gmail.com>
Date: Tue, 6 Sep 2005 19:59:47 +0800
From: "Sat." <walking.to.remember@gmail.com>
Reply-To: walking.to.remember@gmail.com
To: Dirk Gerdes <mail@dirk-gerdes.de>
Subject: Re: what will connect the fork() with its following code ? a simple example below:
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <003a01c5b2d6$610d6360$6464a8c0@pc0001>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6b5347dc0509060215128d477e@mail.gmail.com>
	 <003a01c5b2d6$610d6360$6464a8c0@pc0001>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

here is a snip in 0.11 version linux , 
in linux/init/main.c


179 if (!(pid=fork())) {
180 close(0);
181 if (open( "/etc/rc",O_RDONLY,0))
182 _exit(1);
183 execve( "/bin/sh",argv_rc,envp_rc); 
184 _exit(2);
185 }

natually, the code from 180 to 184 is runned by the new process, what
I can understand is why the new process know that the next code will
run is close(0) and why it know It will end at line 184 ?

so ,I feel that there should be some connection between  them . but
what the relationship in depth is ?

thanks your help :) 


2005/9/6, Dirk Gerdes <mail@dirk-gerdes.de>:
> There is no connection between a child an its parent.
> The child only gets a copy of the code.
> If there were a pointer to a child or to the parent, you wouldn't need any
> signals.
> The processes could communicate directly.
> 
> regards
> 
> ----- Original Message -----
> From: "Sat." <walking.to.remember@gmail.com>
> To: <linux-kernel@vger.kernel.org>
> Sent: Tuesday, September 06, 2005 11:15 AM
> Subject: what will connect the fork() with its following code ? a simple
> example below:
> 
> 
> > if(!(pid=fork())){
> >     ......
> >     printk("in child process");
> >     ......
> > }else{
> >     .....
> >     printk("in father process");
> >     .....
> > }
> >
> > this is a classical example, when the fork() system call runs, it will
> > build a new process and active it . while the schedule() select the
> > new process it will run. this is rather normal.
> >
> > but there is always a confusion in my minds.
> > because , sys_fork() only copies father process and configure some new
> > values., and do nothing . so the bridge  between the new process and
> > its following code, printk("in child process"), seems disappear . so I
> > always believe that the new process should have a pointer which point
> > the code "printk("in child process");". except this , there are not
> > any connection between them ?
> >
> > very confused :(
> >
> > any help will  appreciate  !
> >
> >
> >
> > --
> > Sat.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> 


-- 
Sat.
