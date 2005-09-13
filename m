Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVIMLMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVIMLMA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 07:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVIMLL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 07:11:59 -0400
Received: from xproxy.gmail.com ([66.249.82.198]:52158 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932308AbVIMLL7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 07:11:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MWkMs6I5bv3xgqt0MS7DDSFIBy4nGNZyYCNKeX8XXMke85toe4rI48evlT+mDph3Rc7O5zf8QQ5HNA0y+Judk1SEdomVwtyCfwi8Z1MfXI7WpR/Ch2ykF6yHYbqILTzKsdDnJY0eItWynVBoEUkGFMwMa5HwZ4mBh/QkpGg8Au0=
Message-ID: <1e33f5710509130411858a4ec@mail.gmail.com>
Date: Tue, 13 Sep 2005 16:41:56 +0530
From: Gaurav Dhiman <gaurav4lkg@gmail.com>
Reply-To: gaurav4lkg@gmail.com
To: manomugdha biswas <manomugdhab@yahoo.co.in>
Subject: Re: how to use wait_event_interruptible_timeout
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050913094437.3252.qmail@web8501.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1e33f571050913023042b4c109@mail.gmail.com>
	 <20050913094437.3252.qmail@web8501.mail.in.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/05, manomugdha biswas <manomugdhab@yahoo.co.in> wrote:
> Hi,
> I am using the this function in the following way:

you are using it wrong way ....

> 
> wait_queue_head_t     VNICClientWQHead;
> 
> /* Initialise the wait q head */
> init_waitqueue_head(&VNICClientWQHead);
> 
> init_waitqueue_entry(&waitQ, current);
> add_wait_queue(sock->sk->sk_sleep, waitQ));

need not to do this at all, as all this is done by
wait_event_interruptible_timepout() function. Just here you initialize
the head of the list.

> 
> /*
>  my code, it reads data from socket
> */
> 
> wait_event_interruptible_timeout(VNICClientWQHead, 0,
> HZ * 100000);
> 
> if no activity is to be done then this process sleeps.
> When some data comes in socket i.e socket becomes
> readable this process should wake up. In kernel 2.4 it
> was working fine using interruptible_sleep_on_time().
> But it is not working in kernel 2.6 even if data
> arrives in socket! The sleeping process never wake up.
> Could you please tell me what is the problem?
> 
> Regards,
> Mano
> 
> 
> --- Gaurav Dhiman <gaurav4lkg@gmail.com> wrote:
> 
> > On 9/13/05, manomugdha biswas
> > <manomugdhab@yahoo.co.in> wrote:
> > > Hi,
> > > I was using interruptible_sleep_on_timeout() in
> > kernel
> > > 2.4. In kernel 2.6 I have use
> > > wait_event_interruptible_timeout. But it is now
> > > working!!. interruptible_sleep_on_timeout() was
> > > working fine. Could anyone please help me in this
> > > regard.
> >
> > What problem are you facing with
> > wait_event_interruptible_timeout() in 2.6
> > Elaborate more on it.
> >
> > -Gaurav
> >
> > > Regards,
> > > Mano
> > >
> > > Manomugdha Biswas
> > >
> > >
> > >
> > >
> >
> __________________________________________________________
> > > Yahoo! India Matrimony: Find your partner now. Go
> > to http://yahoo.shaadi.com
> > > -
> > > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> >
> >
> > --
> > - Gaurav
> > my blog: http://lkdp.blogspot.com/
> > --
> > -
> > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> 
> Manomugdha Biswas
> 
> 
> 
> __________________________________________________________
> Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
> 


-- 
- Gaurav
my blog: http://lkdp.blogspot.com/
--
