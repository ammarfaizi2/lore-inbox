Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268127AbUJMA64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268127AbUJMA64 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 20:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268136AbUJMA64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 20:58:56 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:2197 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268127AbUJMA6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 20:58:55 -0400
Date: Tue, 12 Oct 2004 19:58:56 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] lsm: add bsdjail module
Message-ID: <20041013005856.GA3364@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <1097094103.6939.5.camel@serge.austin.ibm.com> <1097094270.6939.9.camel@serge.austin.ibm.com> <20041006162620.4c378320.akpm@osdl.org> <20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com> <20041010104113.GC28456@infradead.org> <1097502444.31259.19.camel@localhost.localdomain> <20041012131124.GA2484@IBM-BWN8ZTBWA01.austin.ibm.com> <416C5C26.9020403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416C5C26.9020403@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +If a private IP was specified for the jail, then
> > +		cat /proc/$$/attr/current
> 
> How is this going to interact with SELinux?  Currently SELinux uses

The first problem is that to use jail with selinux you'll need to use
a stacking infrastructure (which is still being developed) anyway, in
order to get around the multiplexing of task->security, file->f_security,
and sk->sk_security.

But you're right, this is a problem I've had to address with the stacker:

> /proc/*/attr/current to report the current security context of the
> process.  libselinux expects the file to contain one string (not even a

...

>   selinux: user_u:user_r:user_t

This is exactly what my current stacker does, to the byte  :-)

-serge
