Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263467AbRFFEFb>; Wed, 6 Jun 2001 00:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263469AbRFFEFV>; Wed, 6 Jun 2001 00:05:21 -0400
Received: from w146.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.146]:45524 "EHLO
	windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S263467AbRFFEFK>; Wed, 6 Jun 2001 00:05:10 -0400
Date: Tue, 5 Jun 2001 21:03:23 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@heat.gghcwest.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1D927E.1B2EBE76@uow.edu.au>
Message-ID: <Pine.LNX.4.33.0106052059350.23647-100000@heat.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Jun 2001, Andrew Morton wrote:

> "Jeffrey W. Baker" wrote:
> >
> > Because the 2.4 VM is so broken, and
> > because my machines are frequently deeply swapped,
>
> The swapoff algorithms in 2.2 and 2.4 are basically identical.
> The problem *appears* worse in 2.4 because it uses lots
> more swap.
>
> > they can sometimes take over 30 minutes to shutdown.
>
> Yes. The sys_swapoff() system call can take many minutes
> of CPU time.  It basically does:
>
> 	for (each page in swap device) {
> 		for (each process) {
> 			for (each page used by this process)
> 				stuff

Sure, and at shutdown time when swapoff is called, there is only 1
process, init, which isn't swapped out anymore.  So this should run like
lightning.

Repeat: something is horribly wrong with the VM's management of pages,
lists, swap, cache, etc.

-jwb

