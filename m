Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbVIFM4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVIFM4H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 08:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVIFM4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 08:56:07 -0400
Received: from mail3.netbeat.de ([193.254.185.27]:45459 "HELO mail3.netbeat.de")
	by vger.kernel.org with SMTP id S932149AbVIFM4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 08:56:06 -0400
Message-ID: <005301c5b2e3$1890a4a0$6464a8c0@pc0001>
From: "Dirk Gerdes" <mail@dirk-gerdes.de>
To: <walking.to.remember@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
References: <6b5347dc0509060215128d477e@mail.gmail.com> <003a01c5b2d6$610d6360$6464a8c0@pc0001> <6b5347dc05090604596ac08cb6@mail.gmail.com>
Subject: Re: what will connect the fork() with its following code ? a simple example below:
Date: Tue, 6 Sep 2005 15:01:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fork returns 0 to the child and the pid of the child to the parent.

both child and parent get the same code, so the child gets true in the 
if-statement and the parent gets false.

it would be the same as

pid = fork();
if (pid == 0){
// child
}
else{
// parent
}


----- Original Message ----- 
From: "Sat." <walking.to.remember@gmail.com>
To: "Dirk Gerdes" <mail@dirk-gerdes.de>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, September 06, 2005 1:59 PM
Subject: Re: what will connect the fork() with its following code ? a simple 
example below:


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
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
> > in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>


-- 
Sat.

