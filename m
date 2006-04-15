Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWDOLOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWDOLOw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 07:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWDOLOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 07:14:52 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:54719 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932484AbWDOLOv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 07:14:51 -0400
Date: Sat, 15 Apr 2006 15:14:43 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Libor Vanek <libor.vanek@gmail.com>
Cc: Matt Helsley <matthltc@us.ibm.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Connector - how to start?
Message-ID: <20060415111443.GA4079@2ka.mipt.ru>
References: <369a7ef40604141809u45b7b37ay27dfb74778a91893@mail.gmail.com> <20060414192634.697cd2e3.rdunlap@xenotime.net> <1145070437.28705.73.camel@stark> <20060415091801.GA4782@2ka.mipt.ru> <369a7ef40604150350x8e7dea1sbf1f83cb800dd1c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <369a7ef40604150350x8e7dea1sbf1f83cb800dd1c3@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 15 Apr 2006 15:14:44 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2006 at 12:50:46PM +0200, Libor Vanek (libor.vanek@gmail.com) wrote:
> Hi

Hello.

> > Why do you want to send big messages over netlink?
> > Netlink is fast but not faster than char device for example, or read
> > from mapped area, although it is much more convenient to use.
> >
> > Well, I can increase CONNECTOR_MAX_MSG_SIZE to maximum allowed 64k, if
> > there is really strong justification.
> 
> I need to send messages containing several (1 to 3) file names. And
> "MAXPATHLEN" is 1024b (usually it's much less but I can't rely on
> that).

$ touch `perl -e 'print "A"x1024'`
touch: cannot touch
`AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA':
File name too long

Only 255 is allowed in my system.

> I got working solution using procfs but my (diploma thesis) project
> manager want's me to use netlink/connector solution...

Well, it is strong justification, since connector does not use
CONNECTOR_MAX_MSG_SIZE except for checking that message size is less
that this value, but as pointed above, filename can not be that long,
although it can exceed above value when concatenated with directory
names. But in this case it can exceed any other limits, and it can be
impossible to allocate such a big buffer to store the whole path.

So you will need to create some kind of tree strucuture to store your 
names there, since it is wrong thing to allocate a buffer to store the
whole path as is. But in this case you do not need to
increase CONNECTOR_MAX_MSG_SIZE.

> Thanks for help,
> Libor Vanek

-- 
	Evgeniy Polyakov
