Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWDSMOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWDSMOo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 08:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWDSMOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 08:14:43 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:38308 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750718AbWDSMOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 08:14:43 -0400
Date: Wed, 19 Apr 2006 16:14:24 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Libor Vanek <libor.vanek@gmail.com>
Cc: Matt Helsley <matthltc@us.ibm.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Connector - how to start?
Message-ID: <20060419121423.GA6057@2ka.mipt.ru>
References: <20060414192634.697cd2e3.rdunlap@xenotime.net> <1145070437.28705.73.camel@stark> <20060415091801.GA4782@2ka.mipt.ru> <369a7ef40604160426s301dcd52r4c9826698d3d2f79@mail.gmail.com> <20060416114017.GA30180@2ka.mipt.ru> <369a7ef40604160509xcf2caadi782b90da956639d5@mail.gmail.com> <20060416132515.GA25602@2ka.mipt.ru> <369a7ef40604160632t16f6aab9u687a6b359997d7ea@mail.gmail.com> <20060418060744.GA20715@2ka.mipt.ru> <369a7ef40604190439v6e8f1bf6lf52cfab5af3a93af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <369a7ef40604190439v6e8f1bf6lf52cfab5af3a93af@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 19 Apr 2006 16:14:33 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 01:39:08PM +0200, Libor Vanek (libor.vanek@gmail.com) wrote:
> Ok, thanks. And is there some way how to sign to simply some group
> number? (not through this bit mask but directly through group number -
> yes, I know I can "convert" the number)

bind() to zero and then subscribe can work.

> And what about my other issue I had in my simple example
> module/userspace SW - that cn_netlink_send returned 0 even when there
> was no listener - have you found something wrong in connector or (more
> probable) in my example?

With the latest 2.6 git tree I get following:

w1_netlink_send: cn_netlink_send() returned -3.

when there are no users.

Can you check if there is 
return netlink_broadcast(); string in the cn_netlink_send() in your
tree?

> Thanks,
> Libor Vanek
> 
> On 4/18/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > bind() nladdr value is a bitmask of groups, not a single group number,
> > it was done for backward compatibility, so bind(5) is equal to
> > subscribe(1) and subscribe(3). That is why you saw messages without
> > subscription.
> >
> > --
> >         Evgeniy Polyakov
> >

-- 
	Evgeniy Polyakov
