Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316393AbSEOPDG>; Wed, 15 May 2002 11:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316394AbSEOPDF>; Wed, 15 May 2002 11:03:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61964 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id <S316393AbSEOPDE>;
	Wed, 15 May 2002 11:03:04 -0400
Subject: Re: Device driver question
From: Joe deBlaquiere <jadb@redhat.com>
To: Tommy Reynolds <reynolds@redhat.com>
Cc: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020515083645.7320aefa.reynolds@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 (1.0.2-0.7x) 
Date: 15 May 2002 10:03:09 -0500
Message-Id: <1021474990.1450.56.camel@uberdog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about just write a driver that responds to the interrupt, and write
a program that does a blocking read from the driver. The driver read
routine stuff the program on a wait queue... until... interrupt occurs,
wake up the program, program does exec(/sbin/halt) ?

This could actually be made into a good demonstration of driver
programming in that you could hook the parport interrupt and do it with
any PC.... 

On Wed, 2002-05-15 at 08:36, Tommy Reynolds wrote:
> Uttered "Bloch, Jack" <Jack.Bloch@icn.siemens.com>, spoke thus:
> 
> > I have a specific case where our HW can generate a
> >  special interrupt. In this case I simply want the ISR to halt the system
> >  (i.e. take the same action as if I typed halt from the command line). How
> >  can I from within my device driver cause a halt? Please CC me specifically
> >  on any replies.
> 
> Check out the code for "sys_reboot" in "kernel/sys.c" for ideas on how to do
> this.  I don't think you can invoke "sys_reboot" from inside an interrupt
> handler, but you could probably do the same thing by calling the service
> routines "sys_reboot" does.
> 
> If that doesn't shut your machine down gracefully, then you might resort to
> "call_usermodehelper" in "kernel/kmod.c" to run "/sbin/shutdown -h now".  You
> can't invoke "call_usermodehelper" from an interrupt top half, but it should
> work find from a tasklett.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Joe deBlaquiere
Red Hat, Inc.
voice : 256-217-0123
mobile: 256-527-5633
fax   : 256-837-3839
jadb@redhat.com

