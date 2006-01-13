Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423014AbWAMWNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423014AbWAMWNd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423015AbWAMWNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:13:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53478 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1423014AbWAMWNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:13:31 -0500
Subject: Re: [patch 00/62] sem2mutex: -V1
From: Arjan van de Ven <arjan@infradead.org>
To: Junio C Hamano <junkio@cox.net>
Cc: Ingo Molnar <mingo@elte.hu>, Ingo Oeser <ioe-lkml@rameria.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Jes Sorensen <jes@trained-monkey.org>, Greg KH <greg@kroah.com>,
       chaosite@gmail.com
In-Reply-To: <7v64on3hlb.fsf@assigned-by-dhcp.cox.net>
References: <20060113124402.GA7351@elte.hu>
	 <200601131400.00279.baldrick@free.fr> <20060113134412.GA20339@elte.hu>
	 <200601131925.34971.ioe-lkml@rameria.de> <20060113195658.GA3780@elte.hu>
	 <43C815E3.10005@gmail.com> <1137187555.2975.13.camel@laptopd505.fenrus.org>
	 <7v64on3hlb.fsf@assigned-by-dhcp.cox.net>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 23:13:24 +0100
Message-Id: <1137190404.2975.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 14:09 -0800, Junio C Hamano wrote:
> Arjan van de Ven <arjan@infradead.org> writes:
> 
> > On Fri, 2006-01-13 at 23:04 +0200, Matan Peled wrote:
> >> Ingo Molnar wrote:
> >> > Ingo Oeser wrote:
> >> >> Could we get for each of these and a mutex:
> >> >>
> >> >>  - description 
> >> >>  - common use case
> >> >>  - small argument why this and nothing else should be used there
> >> > 
> >> > like ... Documentation/mutex-design.txt?
> >> 
> >> I think what he wanted was an explanation for the change of each and every 
> >> sem... Which is kind of hard with automated tools.
> > `
> > it's also HIGHLY repetitive.
> > 1) The process is : Look at semaphore and it's uses.
> > 2) Decide it's a mutex
> > 3) Run script to convert to mutex
> > 4) Run script to validate the conversion
> > 5) build+boot test
> >
> > I can't think of a way to describe that uniquely different for each
> > one ;0
> 
> I do not read Ingo Oeser's request as such, but if somebody does
> 1) and 2), ideally, the knowledge obtained during that process,
> i.e. what is being protected and what the invariants are, and
> the reasoning why it is a mutex, could serve as a good
> documentation for people who want to further work on that code
> being converted to use mutex.

Again that is almost a generic answer, the *vast* majority of
mutex-semaphores is used in such a way that the down() and up() are
always in the same function, eg the pattern is 

down(semaphore);
do_stuff();
up(semaphore);


all the time. That's then a mutex... and the most basic use pattern.
Sure this isn't always the case but it's very common.

(there have been 2 cases that accidentally did

up(semaphore);
do_stuff();
down(semaphore);

.. which is legal with semaphores but not what was intended ;)



