Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVDKXLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVDKXLe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 19:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVDKXLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 19:11:34 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:26116 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S261961AbVDKXLc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 19:11:32 -0400
Date: Mon, 11 Apr 2005 16:11:55 -0700
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Joe Korty <joe.korty@ccur.com>
Subject: Re: [PATCH] Priority Lists for the RT mutex
Message-ID: <20050411231155.GC11685@nietzsche.lynx.com>
References: <F989B1573A3A644BAB3920FBECA4D25A02FA3AF6@orsmsx407>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A02FA3AF6@orsmsx407>
User-Agent: Mutt/1.5.8i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 03:31:41PM -0700, Perez-Gonzalez, Inaky wrote:
> If you are exposing the kernel locks to userspace to implement
> mutexes (eg POSIX mutexes), deadlock checking is a feature you want
> to have to complain with POSIX. According to some off the record
> requirements I've been given, some applications badly need it (I have 
> a hard time believing that they are so broken, but heck...).

I'd like to read about those requirements, but, IMO a lot of the value
of various priority protocols varies greatly on the context and size (N
threads) of the application using it. If user/kernel space have to be
coupled via some thread of execution, (IMO) then it's better to seperate
them with some event notification queues like signals (wake a thread
via an queue event) than to mix locks across the user/kernel space
boundary. There's tons of abuse that can be opened up with various
priority protocols with regard to RT apps and giving it a first class
entry way without consideration is kind of scary.

It's important to outline the requirements of the applications and then
see what you can do using minimal synchronization objects before
exploding that divide.

Also, Posix isn't always politically neutral nor complete regarding
various things. You have to consider the context of these things.
I'll have to think about this a bit more and review your patch more
carefully.

I'm all ears if you think I'm wrong.

bill

