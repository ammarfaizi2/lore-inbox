Return-Path: <linux-kernel-owner+w=401wt.eu-S1422723AbWLUE4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422723AbWLUE4c (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 23:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422720AbWLUE4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 23:56:32 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:35412 "HELO
	smtp111.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1422723AbWLUE4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 23:56:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=DASepSHDJc09meUPffXExpDSv6DJYMOG9KgtSjuxmHarAioo/TS7RRzqr6s8ETpDNiFB3+iKmBT6PHwLvimlsFh24UDv6NwWwhGzRBMBZ3dH+0KQnmt+wD+EeMezvv8ngFUuuxHNreLxnJ5jlpHIsdI/2cm3Jg0hvbmMIid5kBE=  ;
X-YMail-OSG: ELQmttEVM1kyF2fJ31Xd9no5_qrPH6L24hl0jvbMX0hnXMaeINl6J2ipKaEv9DqeoJYVvuf4Dx7xoY8Ed6e_AVODq9d7U7e8Y2R_qHC4uhnDFdpsKlZ5dC.thLdgfIILnWaPCz0Ve9JWgIjW7uGfjzuzyuJhGh2FRzHv1E4r0PbdI5dLJJs.f4tLfXPc
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Changes to sysfs PM layer break userspace
Date: Wed, 20 Dec 2006 20:56:27 -0800
User-Agent: KMail/1.7.1
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
References: <20061219185223.GA13256@srcf.ucam.org> <200612191929.14524.david-b@pacbell.net> <20061220195117.4d12dee7.akpm@osdl.org>
In-Reply-To: <20061220195117.4d12dee7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612202056.28177.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 December 2006 7:51 pm, Andrew Morton wrote:

> > +	if (!warned) {
> > +		printk(KERN_WARNING
> > +			"*** WARNING *** sysfs devices/.../power/state files "
> > +			"are only for testing, and will be removed\n");
> > +		warned = error;
> > +	}
> > +
> >  	/* disallow incomplete suspend sequences */
> >  	if (dev->bus && (dev->bus->suspend_late || dev->bus->resume_early))
> >  		return error;
> 
> Well that's not much use.  It tells people "hey, we broke it".  They
> already knew that.

No, it only does what you asked for:  warning people that they're using
something that's going away.  It says nothing about "broke".


> What we should do is to revert 047bda36150d11422b2c7bacca1df324c909c0b3 and

Bad answer ... see my original reply in this thread.  If "the answer" is
to involve making PCI devices work again, better solutions include reverting
the patch I mentioned (adding the suspend_late/resume_early support to PCI)
or a version of what Matthew has produced (poking through bus layers so
that test can be made to fail when the bus supports those methods but the
specific device's driver doesn't use them).

- Dave

