Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbTJDHsh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 03:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTJDHsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 03:48:36 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:28058 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261931AbTJDHsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 03:48:35 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 2.6] input: do not suppress 0 value relative events
Date: Sat, 4 Oct 2003 02:48:27 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <200310040223.01664.dtor_core@ameritech.net> <20031004073656.GA3756@ucw.cz>
In-Reply-To: <20031004073656.GA3756@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310040248.27501.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 04 October 2003 02:36 am, Vojtech Pavlik wrote:
> On Sat, Oct 04, 2003 at 02:22:57AM -0500, Dmitry Torokhov wrote:
> >   Input: input susbsystem should not drop 0 value relative events,
> >          otherwise unsuspecting programs will loose transitions from
> >          non-zero to 0 deltas. We should not require userland authors
> >          to consult with kernel implementation details all the time,
> >          but follow the principle of least surprise and report
> >          everything.
>
> Certain devices will then generate an endless stream of zero-movement
> relative events, which is not good.
>
> Because 'relative' means that there is no movement when there is no
> event, where exactly lies the problem? What application has a problem
> with this? Many mice don't ever report zero values, so that application
> will probably not work even without the (value==0) check ...

But the problem is not only repetitive zeros are not reported but also that
transition from non-zero to zero delta is not reported either.

OK, since you telling me there are devices which never stop generating 
events we could go the way absolute events done and suppress repeated data.
Should I try that? 

As far as application goes it was my modified version of GPM - pretty much
every other event is not repeated unless changed so I did not reset the
internal state and expected get an event telling me the last delta. I am
OK with data not being repeated but I want to get event for transition
to 0.

Dmitry
