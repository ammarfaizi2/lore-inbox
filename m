Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUJNPtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUJNPtR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 11:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUJNPtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 11:49:17 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3712 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266333AbUJNPtO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 11:49:14 -0400
Date: Thu, 14 Oct 2004 11:49:05 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Davide Rossetti <davide.rossetti@roma1.infn.it>
cc: Martijn Sipkema <martijn@entmoot.nl>, linux-kernel@vger.kernel.org
Subject: Re: waiting on a condition
In-Reply-To: <416E9D1E.8090203@roma1.infn.it>
Message-ID: <Pine.LNX.4.53.0410141143100.7357@chaos.analogic.com>
References: <02bb01c4b138$8a786f10$161b14ac@boromir>  <416D49FF.10003@radiantdata.com>
 <1097701123.4648.13.camel@localhost.localdomain> <416E9D1E.8090203@roma1.infn.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004, Davide Rossetti wrote:

> Martijn Sipkema wrote:
>
> >On Wed, 2004-10-13 at 17:30, Peter W. Morreale wrote:
> >
> >
> >>Have you looked at the wait_event() family yet?       Adapting that
> >>methodolgy might
> >>suit your needs.
> >>
> >>
> >
> >wait_event() seems to be what I was looking for; I don't really like the
> >condition being an argument.
> >
> >
> >
> you may have a look at http://lwn.net/Articles/22913/
> it's interesting :)
> regards


You could always do:

	while(whatever)
        {
             set_current_state(TASK_INTERRUPTIBLE);
             schedule_timeout(0);
             if(signal_pending(current))
                 break;        // Or do something else
        }
        set_current_state(TASK_RUNNING); // Probably redundant

You could also set a specific HZ for the timeout, and count
them for a "never happened" timeout.




Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

