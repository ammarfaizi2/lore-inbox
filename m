Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWDOMZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWDOMZM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 08:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWDOMZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 08:25:12 -0400
Received: from jenny.ondioline.org ([66.220.1.122]:29967 "EHLO
	jenny.ondioline.org") by vger.kernel.org with ESMTP id S932500AbWDOMZK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 08:25:10 -0400
From: Paul Collins <paul@briny.ondioline.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Libor Vanek <libor.vanek@gmail.com>, Matt Helsley <matthltc@us.ibm.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Connector - how to start?
References: <369a7ef40604141809u45b7b37ay27dfb74778a91893@mail.gmail.com>
	<20060414192634.697cd2e3.rdunlap@xenotime.net>
	<1145070437.28705.73.camel@stark> <20060415091801.GA4782@2ka.mipt.ru>
	<369a7ef40604150350x8e7dea1sbf1f83cb800dd1c3@mail.gmail.com>
	<20060415111443.GA4079@2ka.mipt.ru>
Mail-Followup-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Libor Vanek
	<libor.vanek@gmail.com>, Matt Helsley <matthltc@us.ibm.com>,
	"Randy.Dunlap" <rdunlap@xenotime.net>, LKML
	<linux-kernel@vger.kernel.org>
Date: Sat, 15 Apr 2006 22:18:31 +1000
In-Reply-To: <20060415111443.GA4079@2ka.mipt.ru> (Evgeniy Polyakov's message
	of "Sat, 15 Apr 2006 15:14:43 +0400")
Message-ID: <87hd4vvxpk.fsf@briny.internal.ondioline.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> writes:

> On Sat, Apr 15, 2006 at 12:50:46PM +0200, Libor Vanek (libor.vanek@gmail.com) wrote:
>> Hi
>
> Hello.
>
>> > Why do you want to send big messages over netlink?
>> > Netlink is fast but not faster than char device for example, or read
>> > from mapped area, although it is much more convenient to use.
>> >
>> > Well, I can increase CONNECTOR_MAX_MSG_SIZE to maximum allowed 64k, if
>> > there is really strong justification.
>> 
>> I need to send messages containing several (1 to 3) file names. And
>> "MAXPATHLEN" is 1024b (usually it's much less but I can't rely on
>> that).
>
> $ touch `perl -e 'print "A"x1024'`
> touch: cannot touch
> `AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA':
> File name too long
>
> Only 255 is allowed in my system.

There are two limits though, the component length limit (NAME_MAX),
and the overall length limit (PATH_MAX).  For example:

$ mkdir -p `perl -e 'print "A"x255'`/`perl -e 'print "B"x255'`/`perl -e 'print "C"x255'`/`perl -e 'print "D"x255'`

works fine here.

However, with 256 I get "File name too long", as you did.

-- 
Dag vijandelijk luchtschip de huismeester is dood
