Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262197AbSJNVrZ>; Mon, 14 Oct 2002 17:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262193AbSJNVrZ>; Mon, 14 Oct 2002 17:47:25 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:9373 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262197AbSJNVrA>; Mon, 14 Oct 2002 17:47:00 -0400
Date: Mon, 14 Oct 2002 16:52:28 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Corey Minyard <cminyard@mvista.com>
cc: Arjan van de Ven <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IPMI driver for Linux, version 6
In-Reply-To: <3DAB2D7E.4000503@mvista.com>
Message-ID: <Pine.LNX.4.44.0210141649570.5992-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, Corey Minyard wrote:

> Arjan van de Ven wrote:
> 
> >On Mon, 2002-10-14 at 03:06, Corey Minyard wrote:
> >  
> >
> >>Yet one more update, mostly fixes for stylistic things that Randy Dunlap 
> >>pointed out, and a bug fix that lets the KCS state machine get out of 
> >>the "hosed" state on the next message (buggy hardware can sometimes be 
> >>useful :-).  As usual, on my home page at  http://home.attbi.com/~minyard.
> >>
> >>-Corey
> >>    
> >>
> >+static int ipmi_open(struct inode *inode, struct file *file)
> >..
> >+	priv = kmalloc(sizeof(*priv), GFP_KERNEL);
> >..
> >+	MOD_INC_USE_COUNT;
> >
> >hmm. Ok so you either need the MOD_INC_USE_COUNT or you don't, but if
> >you do it should go before the sleeping kmalloc ;)
> >
> Ok, it will be fixed in the next release.

Admittedly I haven't looked at this code at all, but most likely you want 
to set .owner = THIS_MODULE in your struct file_operations, no additional 
MOD_INC_USE_COUNT in ::open() is necessary, then.

--Kai


