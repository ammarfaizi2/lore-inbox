Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291471AbSBHI10>; Fri, 8 Feb 2002 03:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291472AbSBHI1Q>; Fri, 8 Feb 2002 03:27:16 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:12043 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S291471AbSBHI1H>; Fri, 8 Feb 2002 03:27:07 -0500
Message-Id: <200202080824.g188ODt13531@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Christoph Hellwig <hch@ns.caldera.de>, Martin.Wirth@dlr.de (Martin Wirth)
Subject: Re: [RFC] New locking primitive for 2.5
Date: Fri, 8 Feb 2002 10:24:15 -0200
X-Mailer: KMail [version 1.3.2]
Cc: akpm@zip.com.au, mingo@elte.hu, rml@tech9.net, nigel@nrg.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <200202071822.g17IMgS14802@ns.caldera.de>
In-Reply-To: <200202071822.g17IMgS14802@ns.caldera.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 February 2002 16:22, Christoph Hellwig wrote:
> In article <3C629F91.2869CB1F@dlr.de> you wrote:
> > The new lock uses a combination of a spinlock and a (mutex-)semaphore.
> > You can lock it for short-term issues in a spin-lock mode:
> >
> >         combi_spin_lock(struct combilock *x)
> >         combi_spin_unlock(struct combilock *x)
> >
> > and for longer lasting tasks in a sleeping mode by:
> >
> >         combi_mutex_lock(struct combilock *x)
> >         combi_mutex_unlock(struct combilock *x)
>
> I think this API is really ugly.  If both pathes actually do the same,
> just with different defaults, one lock function with a flag would be
> much nicer.  Also why do we need two unlock functions?
>
> What about the following instead:
>
> 	combi_lock(struct combilock *x, int spin);
> 	combi_unlock(struct combilock *x);

What is easier to read:
	combi_lock(zzzt_clock, 1);	
	// go grepping .h to find out what this 1 means
or
	combi_spin_lock(zzzt_clock);
?

OTOH single unlock() looks good.
--
vda
