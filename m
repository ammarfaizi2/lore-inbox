Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129804AbQKARrv>; Wed, 1 Nov 2000 12:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130417AbQKARrc>; Wed, 1 Nov 2000 12:47:32 -0500
Received: from mail-04-real.cdsnet.net ([63.163.68.109]:3087 "HELO
	mail-04-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S129804AbQKARr0>; Wed, 1 Nov 2000 12:47:26 -0500
Message-ID: <3A0057CA.90A29C0F@mvista.com>
Date: Wed, 01 Nov 2000 09:50:02 -0800
From: George Anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.14-VPN i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Anonymous <anonymos@micron.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 1.2.45 Linux Scheduler
In-Reply-To: <004d01c043b9$e9cfe2e0$53b613d1@micron.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anonymous wrote:
> 
> In the Linux scheduler they use a circular queue implementation with round
> robin. What is the advantage of this over just using a normal queue with a
> back and front. Also does anyone know what a test plan for such a design
> would even begin to look like. This is a project for a proposal going around
> in my neighborhood and I am wondering why in the world someone would want to
> modify the Linux scheduler to this extent.
> 
The advantages to the circular bi-directional list are:

1.) You can insert AND remove entries at any point in the list with
simple code that does not have to a:) test to see if it is dealing with
an end point or b:) know ANY thing about the rest of the list.
2.) You have access to each end of the queue without searching (great
for RR stuff).
3.) It is easy to get the compiler to do as good a job at insert and
delete as you can do in assembly (see 2.4.0-testX code).

In fact Linux uses this list structure for almost all of its lists, not
just the run list.

The problems with the scheduler list management are not so much circular
bi-directional issues as the fact that the actual dispatch priorities
are so dynamic that you (the scheduler) can not predict at list
insertion time the best task dispatch order.  A real-time scheduler with
fixed priorities has a much easier go of it in this regard.  See, for
example, the real-time scheduler at <www.mvista.com>.

George
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
