Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbVIMNvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVIMNvW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 09:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbVIMNvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 09:51:22 -0400
Received: from web8509.mail.in.yahoo.com ([202.43.219.171]:56670 "HELO
	web8509.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S964780AbVIMNvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 09:51:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=M5yYzSKTLblHQNqE7jB4FNa0eQ4xlcZ8F1RR6L2aGFPB+q59/e8Nhoyg41zK3R74iNrmDcMfck7WfRCVqIy2CS8Z3Jj+py+rg9Z7MEO9W9WJZfGLwK83vNk1+770ddu9f7neryUi5tuDnZtUZyDBAEbVHwbvay+K2Wl8/4g9J78=  ;
Message-ID: <20050913135107.93471.qmail@web8509.mail.in.yahoo.com>
Date: Tue, 13 Sep 2005 14:51:07 +0100 (BST)
From: manomugdha biswas <manomugdhab@yahoo.co.in>
Subject: wait_event_interruptible_timeout problem
To: linux-kernel@vger.kernel.org
Cc: gaurav4lkg@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi,
 I have a kernel module (kernel 2.6) where I have
 opened multiple tcp connections. when there is no
 data
 i want my process to sleep. For that i have added
 the
 following code.
  
 /* Initialise the wait q head */
   init_waitqueue_head(&VNICClientWQHead);
 
 init_waitqueue_entry(&(currentMap->waitQ), current);
 add_wait_queue(currentMap->sock->sk->sk_sleep,
 &(currentMap->waitQ));
 
 /* here currentMap is a structure containing tcp
 conenction info for my module. There is a currentMap
 for each tcp connection */
 
 wait_event_interruptible_timeout(VNICClientWQHead,
                                  0, HZ * 100000);
 
 I am not sure about the condition argument, 0. 
 
 It is not working. How the condition is to be set
 here
 so that whenever data is available on any socket
 (tcp
 connection) the sleeping process gets waken up?
 
 Could anyone please give some light on this?
 
 Regards,
 Mano
 
> 
> 
> 
> 
> --- Gaurav Dhiman <gaurav4lkg@gmail.com> wrote:
> 
> > On 9/13/05, manomugdha biswas
> > <manomugdhab@yahoo.co.in> wrote:
> > > Hi,
> > > I am using the this function in the following
> way:
> > 
> > you are using it wrong way ....
> > 
> > > 
> > > wait_queue_head_t     VNICClientWQHead;
> > > 
> > > /* Initialise the wait q head */
> > > init_waitqueue_head(&VNICClientWQHead);
> > > 
> > > init_waitqueue_entry(&waitQ, current);
> > > add_wait_queue(sock->sk->sk_sleep, waitQ));
> > 
> > need not to do this at all, as all this is done by
> > wait_event_interruptible_timepout() function. Just
> > here you initialize
> > the head of the list.
> > 
> > > 
> > > /*
> > >  my code, it reads data from socket
> > > */
> > > 
> > >
> wait_event_interruptible_timeout(VNICClientWQHead,
> > 0,
> > > HZ * 100000);
> > > 
> > > if no activity is to be done then this process
> > sleeps.
> > > When some data comes in socket i.e socket
> becomes
> > > readable this process should wake up. In kernel
> > 2.4 it
> > > was working fine using
> > interruptible_sleep_on_time().
> > > But it is not working in kernel 2.6 even if data
> > > arrives in socket! The sleeping process never
> wake
> > up.
> > > Could you please tell me what is the problem?
> > > 
> > > Regards,
> > > Mano
> > > 
> > > 
> > > --- Gaurav Dhiman <gaurav4lkg@gmail.com> wrote:
> > > 
> > > > On 9/13/05, manomugdha biswas
> > > > <manomugdhab@yahoo.co.in> wrote:
> > > > > Hi,
> > > > > I was using interruptible_sleep_on_timeout()
> > in
> > > > kernel
> > > > > 2.4. In kernel 2.6 I have use
> > > > > wait_event_interruptible_timeout. But it is
> > now
> > > > > working!!. interruptible_sleep_on_timeout()
> > was
> > > > > working fine. Could anyone please help me in
> > this
> > > > > regard.
> > > >
> > > > What problem are you facing with
> > > > wait_event_interruptible_timeout() in 2.6
> > > > Elaborate more on it.
> > > >
> > > > -Gaurav
> > > >
> > > > > Regards,
> > > > > Mano
> > > > >
> > > > > Manomugdha Biswas
> > > > >
> > > > >
> > > > >
> > > > >
> > > >
> > >
> >
>
__________________________________________________________
> > > > > Yahoo! India Matrimony: Find your partner
> now.
> > Go
> > > > to http://yahoo.shaadi.com
> > > > > -
> > > > > To unsubscribe from this list: send the line
> > > > "unsubscribe linux-kernel" in
> > > > > the body of a message to
> > majordomo@vger.kernel.org
> > > > > More majordomo info at
> > > > http://vger.kernel.org/majordomo-info.html
> > > > > Please read the FAQ at 
> > http://www.tux.org/lkml/
> > > > >
> > > >
> > > >
> > > > --
> > > > - Gaurav
> > > > my blog: http://lkdp.blogspot.com/
> > > > --
> > > > -
> > > > To unsubscribe from this list: send the line
> > > > "unsubscribe linux-kernel" in
> > > > the body of a message to
> > majordomo@vger.kernel.org
> > > > More majordomo info at
> > > > http://vger.kernel.org/majordomo-info.html
> > > > Please read the FAQ at 
> http://www.tux.org/lkml/
> > > >
> > > 
> > > 
> > > Manomugdha Biswas
> > > 
> > > 
> > > 
> > >
> >
>
__________________________________________________________
> > > Yahoo! India Matrimony: Find your partner now.
> Go
> > to http://yahoo.shaadi.com
> > > 
> > 
> > 
> > -- 
> > - Gaurav
> > my blog: http://lkdp.blogspot.com/
> > --
> > 
> 
> 
> Manomugdha Biswas
> 
> 
> 		
>
__________________________________________________________
> 
> Yahoo! India Matrimony: Find your partner now. Go to
> http://yahoo.shaadi.com
> 


Manomugdha Biswas


		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
