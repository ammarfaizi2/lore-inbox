Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268932AbTBZUsH>; Wed, 26 Feb 2003 15:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268936AbTBZUsH>; Wed, 26 Feb 2003 15:48:07 -0500
Received: from crack.them.org ([65.125.64.184]:22952 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S268932AbTBZUsE>;
	Wed, 26 Feb 2003 15:48:04 -0500
Date: Wed, 26 Feb 2003 15:57:54 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>, jt@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Invalid compilation without -fno-strict-aliasing
Message-ID: <20030226205754.GA29466@nevyn.them.org>
Mail-Followup-To: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>,
	jt@hpl.hp.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <873cmbghai.fsf@student.uni-tuebingen.de> <200302262047.h1QKlm0P001784@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302262047.h1QKlm0P001784@eeyore.valparaiso.cl>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 05:47:48PM -0300, Horst von Brand wrote:
> Falk Hueffner <falk.hueffner@student.uni-tuebingen.de> said:
> > Horst von Brand <vonbrand@inf.utfsm.cl> writes:
> > > Jean Tourrilhes <jt@bougret.hpl.hp.com> said:
> > > > 	if((stream + event_len) < ends) {
> > > > 		iwe->len = event_len;
> > > > 		memcpy(stream, (char *) iwe, event_len);
> > > > 		stream += event_len;
> > > > 	}
> > > > 	return stream;
> > > > }
> > > 
> > > The compiler is free to assume char *stream and struct iw_event *iwe
> > > point to separate areas of memory, due to strict aliasing.
> > 
> > The relevant paragraph of the C99 standard is:
> > 
> > An object shall have its stored value accessed only by an lvalue
> > expression that has one of the following types:
> [...]
> > -- a character type.
> 
> (char *) gives you a (pointer to) a character type.
> 
> > I can't really spot any lvalue here that might violate this rule.  It
> > would be nice if somebody could report a bug with a testcase.
> 
> stream and (char *) iwe

Stream is not the same storage as iwe, so this is hardly the issue. 
Writes to stream don't affect iwe.  The problem was the assignment to
iwe->len being moved after the access, according to the report.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
