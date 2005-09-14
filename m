Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbVINGOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbVINGOp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 02:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbVINGOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 02:14:45 -0400
Received: from web8503.mail.in.yahoo.com ([202.43.219.165]:27824 "HELO
	web8503.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S965035AbVINGOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 02:14:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=MEhYyiKwjwVaxtstM/rC/rfY8lncAiESOTlSVGkjTmRKzxm1ldyGpm+b/JGkW9kFvUsStK1UnOPb1+k3xBKPKGtUoSVv/vvlatOofwAlkDFzl/AYPtRIDUrEnhZ5DLu5PdppNBK1rP1w39PVBOhQHElajX8PLwrJXrQlCyxb5ak=  ;
Message-ID: <20050914061419.84771.qmail@web8503.mail.in.yahoo.com>
Date: Wed, 14 Sep 2005 07:14:19 +0100 (BST)
From: manomugdha biswas <manomugdhab@yahoo.co.in>
Subject: Re: wait_event_interruptible_timeout problem
To: manomugdha biswas <manomugdhab@yahoo.co.in>, linux-kernel@vger.kernel.org
Cc: gaurav4lkg@gmail.com
In-Reply-To: <20050913135107.93471.qmail@web8509.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  wait_event_interruptible_timeout(VNICClientWQHead,
                                   <condition>, HZ *
100000);

I want to use this function to sleep my process when
there is no activity. But when some data arrives on
socket this function should wake up. I have declared a
wait queue as VNICClientWQHead. So what will be the
condtion here to wake up the process when data is
available on sockets? I have multiple sockets.

Regards,
Mano


  Regards,
  Mano
>  
> > 
> > 
> > 
> > 
> > --- Gaurav Dhiman <gaurav4lkg@gmail.com> wrote:
> > 
> > > On 9/13/05, manomugdha biswas
> > > <manomugdhab@yahoo.co.in> wrote:
> > > > Hi,
> > > > I am using the this function in the following
> > way:
> > > 
> > > you are using it wrong way ....
> > > 
> > > > 
> > > > wait_queue_head_t     VNICClientWQHead;
> > > > 
> > > > /* Initialise the wait q head */
> > > > init_waitqueue_head(&VNICClientWQHead);
> > > > 
> > > > init_waitqueue_entry(&waitQ, current);
> > > > add_wait_queue(sock->sk->sk_sleep, waitQ));
> > > 
> > > need not to do this at all, as all this is done
> by
> > > wait_event_interruptible_timepout() function.
> Just
> > > here you initialize
> > > the head of the list.
> > > 
> > > > 
> > > > /*
> > > >  my code, it reads data from socket
> > > > */
> > > > 
> > > >
> > wait_event_interruptible_timeout(VNICClientWQHead,
> > > 0,
> > > > HZ * 100000);
> > > > 
> > > > if no activity is to be done then this process
> > > sleeps.
> > > > When some data comes in socket i.e socket
> > becomes
> > > > readable this process should wake up. In
> kernel
> > > 2.4 it
> > > > was working fine using
> > > interruptible_sleep_on_time().
> > > > But it is not working in kernel 2.6 even if
> data
> > > > arrives in socket! The sleeping process never
> > wake
> > > up.
> > > > Could you please tell me what is the problem?
> > > > 
> > > > Regards,
> > > > Mano
> > > > 
> > > > 
> > > > --- Gaurav Dhiman <gaurav4lkg@gmail.com>
> wrote:
> > > > 
> > > > > On 9/13/05, manomugdha biswas
> > > > > <manomugdhab@yahoo.co.in> wrote:
> > > > > > Hi,
> > > > > > I was using
> interruptible_sleep_on_timeout()
> > > in
> > > > > kernel
> > > > > > 2.4. In kernel 2.6 I have use
> > > > > > wait_event_interruptible_timeout. But it
> is
> > > now
> > > > > > working!!.
> interruptible_sleep_on_timeout()
> > > was
> > > > > > working fine. Could anyone please help me
> in
> > > this
> > > > > > regard.
> > > > >
> > > > > What problem are you facing with
> > > > > wait_event_interruptible_timeout() in 2.6
> > > > > Elaborate more on it.
> > > > >
> > > > > -Gaurav
> > > > >
> > > > > > Regards,
> > > > > > Mano
> > > > > >
> > > > > > Manomugdha Biswas
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>
__________________________________________________________
> > > > > > Yahoo! India Matrimony: Find your partner
> > now.
> > > Go
> > > > > to http://yahoo.shaadi.com
> > > > > > -
> > > > > > To unsubscribe from this list: send the
> line
> > > > > "unsubscribe linux-kernel" in
> > > > > > the body of a message to
> > > majordomo@vger.kernel.org
> > > > > > More majordomo info at
> > > > > http://vger.kernel.org/majordomo-info.html
> > > > > > Please read the FAQ at 
> > > http://www.tux.org/lkml/
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > > - Gaurav
> > > > > my blog: http://lkdp.blogspot.com/
> > > > > --
> > > > > -
> > > > > To unsubscribe from this list: send the line
> > > > > "unsubscribe linux-kernel" in
> > > > > the body of a message to
> > > majordomo@vger.kernel.org
> > > > > More majordomo info at
> > > > > http://vger.kernel.org/majordomo-info.html
> > > > > Please read the FAQ at 
> > http://www.tux.org/lkml/
> > > > >
> > > > 
> > > > 
> > > > Manomugdha Biswas
> > > > 
> > > > 
> > > > 
> > > >
> > >
> >
>
__________________________________________________________
> > > > Yahoo! India Matrimony: Find your partner now.
> > Go
> > > to http://yahoo.shaadi.com
> > > > 
> > > 
> > > 
> > > -- 
> > > - Gaurav
> > > my blog: http://lkdp.blogspot.com/
> > > --
> > > 
> > 
> > 
> > Manomugdha Biswas
> > 
> > 
> > 		
> >
>
__________________________________________________________
> > 
> > Yahoo! India Matrimony: Find your partner now. Go
> to
> 
=== message truncated ===


Manomugdha Biswas


		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
