Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263311AbTCNKQj>; Fri, 14 Mar 2003 05:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263312AbTCNKQj>; Fri, 14 Mar 2003 05:16:39 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:11175 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S263311AbTCNKQh>;
	Fri, 14 Mar 2003 05:16:37 -0500
Date: Fri, 14 Mar 2003 13:26:02 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, zubarev@us.ibm.com,
       gregkh@us.ibm.com
Subject: Re: [2.4] Multiple memleaks in IBM Hot Plug Controller Driver
Message-ID: <20030314102602.GA7985@linuxhacker.ru>
References: <20030313204556.GA3475@linuxhacker.ru> <200303140957.h2E9vfu08416@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303140957.h2E9vfu08416@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Mar 14, 2003 at 11:54:40AM +0200, Denis Vlasenko wrote:

> > +	if (!str)
> > +		return NULL;
> >  	memset (str, 0, 3);
> This was fun, right? "Lets add second memset just in case
> first failed" ;) ;)

Ah, I was half asleep when doing the change, so I missed
other obvious stuff it seems, like memset of three bytes to
two byte variabe :)
memset on wrong thing (second memset should be applied to str1 of course.)

But as Greg KH said already, whis stuff should be replaced by version from 2.5 instead ;)

> >  	bit = (int)(var / 10);
> >  	switch (bit) {
> > @@ -608,13 +608,20 @@
> >  		return str;
> >  	default:
> >  		//2 digits number
> > +		str1 = (char *) kmalloc (2, GFP_KERNEL);
> > +		if (!str1) {
> > +			break;
> > +		}
> > +		memset (str, 0, 3);
> > +             memset (str, 0, 3);
> >               *str1 = (char)(bit + 48);
> >               strncpy (str, str1, 1);
> >               memset (str1, 0, 3);
> Wow! *str1 is 2 bytes long, not 3!

yup.

> Anyway, here is the diff against some old 2.5 (sorry don't have latest
> tree here at the moment). Also here are old and new functions
> for easy visual diff. Completely untested:

New 2.5 code does not have this function at all.
I will look into porting 2.5 changes back to 2.4 tonight. This seems to be proper solution
in this case.

Bye,
    Oleg
