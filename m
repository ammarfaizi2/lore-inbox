Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVCWNF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVCWNF1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 08:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVCWNF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 08:05:27 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:4388 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261586AbVCWNEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 08:04:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Cu7PZtSVt5Yb/30iPchq9uEYjqPIj99aSBhnJCVG/nlL6FCs+Esl0GZGDFlIMzUbusyI4wT8LD13I6cecMvtDO32pcx1xCrOsORwxisomY4oIb/AhhO9tJB8JA0sj9nKBChOFD0IAA9baedJz8IlbqdVF62aUzsgsfZQAlOXPbM=
Message-ID: <9cde8bff05032305044f55acf3@mail.gmail.com>
Date: Wed, 23 Mar 2005 22:04:48 +0900
From: aq <aquynh@gmail.com>
Reply-To: aq <aquynh@gmail.com>
To: Natanael Copa <mlists@tanael.org>
Subject: Re: forkbombing Linux distributions
Cc: "Hikaru1@verizon.net" <Hikaru1@verizon.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1111581459.27969.36.camel@nc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
	 <20050322112628.GA18256@roll>
	 <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
	 <20050322124812.GB18256@roll> <20050322125025.GA9038@roll>
	 <9cde8bff050323025663637241@mail.gmail.com>
	 <1111581459.27969.36.camel@nc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005 13:37:38 +0100, Natanael Copa <mlists@tanael.org> wrote:
> > > This is an example of a program in C my friends gave me that forkbombs.
> > > My previous sysctl.conf hack can't stop this, but the /etc/limits solution
> > > enables the owner of the computer to do something about it as root.
> > >
> > > int main() { while(1) { fork(); } }
> 
> I guess that "fork twice and exit" is worse than this?

you meant code like this 

int main() { while(1) { fork(); fork(); exit(); } }

 is more harmful ? I dont see why (?)

> > I find that this forkbomb doesnt always kill the machine. Trying a
> > small forkbomb, I saw that either the forkbomb process, or the parent
> > process (of forkbomb) will be killed after a while (by the kernel)
> > because of "out of memory" error. The problem is that which process
> > would be chosen to kill? (I have no idea on how kernel choose the
> > would-be-kill process).
> 
> It kills the process that reaches the limit (max proc's / out of mem)?

If so, forkbomb doesnt cause much problem like they said, since
eventually it would be killed once it reach the limit of memory. the
system will recover automatically after awhile.

> Limit the default maximum of user processes. If someone needs more, let
> the sysadmin raise it (with ulimit -u, /etc/limits, sysctl.conf
> whatever)
> 
> This should do the trick:
> 
> --- kernel/fork.c.orig  2005-03-02 08:37:48.000000000 +0100
> +++ kernel/fork.c       2005-03-21 15:22:50.000000000 +0100
> @@ -119,7 +119,7 @@
>          * value: the thread structures can take up at most half
>          * of memory.
>          */
> -       max_threads = mempages / (8 * THREAD_SIZE / PAGE_SIZE);
> +       max_threads = mempages / (16 * THREAD_SIZE / PAGE_SIZE);

I dont see any advantages of halving the max_threads like this at all.
That doesnt solve the problem. You should focus elsewhere.

thank you,
aq
