Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267508AbSLSAjN>; Wed, 18 Dec 2002 19:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267512AbSLSAjM>; Wed, 18 Dec 2002 19:39:12 -0500
Received: from fmr06.intel.com ([134.134.136.7]:33530 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S267508AbSLSAjH>; Wed, 18 Dec 2002 19:39:07 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CACA2A@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Robert Love'" <rml@tech9.net>
Cc: torvalds@transmeta.org, linux-kernel@vger.kernel.org
Subject: RE: [PATCH 2.5.52] Use __set_current_state() instead of current->
	state = (take 1)
Date: Wed, 18 Dec 2002 16:46:00 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > In fs/*.c, many functions manually set the task state directly
> > accessing current->state, or with a macro, kind of
> > inconsistently. This patch changes all of them to use
> > [__]set_current_state().
> 
> Some of these should probably be set_current_state().  I 
> realize the current code is equivalent to __set_current_state()
> but it might as well be done right.

Agreed; however, I also don't want to introduce unnecessary
bloat, so I need to understand first what cases need it - it
is kind of hard for me. Care to let me know some gotchas?

> > -	current->state = TASK_INTERRUPTIBLE;
> > +	__set_current_state (TASK_INTERRUPTIBLE);
> >  	add_wait_queue(fl_wait, &wait);
> >  	if (timeout == 0)
> 
> At least this guy should be set_current_state(), on quick glance.

Is that because it is called lockless? ... grunt, in some areas
is kind of very obscure to guess if it is or not.

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]

