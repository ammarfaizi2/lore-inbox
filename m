Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261790AbSIXUtz>; Tue, 24 Sep 2002 16:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261793AbSIXUtz>; Tue, 24 Sep 2002 16:49:55 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:23226 "EHLO
	e33.esmtp.ibm.com") by vger.kernel.org with ESMTP
	id <S261790AbSIXUtw>; Tue, 24 Sep 2002 16:49:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Daniel E. F. Stekloff" <dsteklof@us.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [evlog-dev] alternate event logging proposal
Date: Tue, 24 Sep 2002 13:54:38 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
References: <20020924073051.363D92C1A7@lists.samba.org> <3D90C183.5020806@pobox.com>
In-Reply-To: <3D90C183.5020806@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209241354.38013.dsteklof@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 September 2002 12:48 pm, Jeff Garzik wrote:

[snip)

> Now, turning to a tangent topic that relates to either scheme...
>
> With either your proposal or mine, event logging is far more useful if
> similar drivers spit out similar diagnostics.  i.e. it's less useful if
> 8139too net driver spits out 'status16' in one interrupt event, and
> 8139cp net driver spits out 'status32' in another.  Though they are
> different hardware and the values mean different things, my point is the
> concepts are similar, and thus better diagnostics are achieved with
> subsystem diagnostic standards.
>
> Such standards are in actuality independent of event logging per se, but
> if IBM wants to push this thing, I would like to see some proposals as
> to what IBM actually wants drivers to log.  I have not seen that at all,
> and think that such proposals should be an integral part of an event
> logging system.  Otherwise the diagnostics are less useful, and IBM
> would have failed to demonstrate an adequate grasp of the problem domain
> [which then leads to other, typical software engineering problems...]
>
> "What do you want to log?" is as important to me as "how do you want to
> log it?"  And the answers to the two questions are very much intertwined.
>
> Comments?


I agree with you that there needs to be a strategy for what is logged by a 
driver and how it is logged. We believe log analysis is an essential part of 
diagnosing errors. Log messages, when generated consistently, could indicate 
what drivers were loaded, when they were loaded, what their current version 
is, and what errors they have encountered. How the messages are formatted, 
whether they follow certain rules, can greatly aid User Space diagnostic 
applications. 

We propose standardizing what should be logged and how those log messages 
should look.

What:

- Drivers should log initialization and uninitialization information for both 
drivers and devices. Knowning when a driver is loaded or unloaded is useful 
information. 

- Initialization information should include name of the device, name of the 
driver, and the current version or release levels. Any errors encountered 
during initialization - e.g.  from running self tests - should be properly 
logged. 

- Errors during operation should be logged. 

How:

- Messages should be human readable.

- Messages should  be succinct.

- Messages should uniquely identify the driver and the device, such as many 
drivers already do by prefixing messages with the driver name.

- Beware of log pollution - log only relevant information. Avoid frequently 
recurring messages. 

- Use defined severity levels. 

- Make sure that consitent logging and terminology is used throughout the 
driver. 

Most of what I just outlined is common sense, but it's worth stating. 

Any comments?


Dan



> 	Jeff
>
>
>
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> evlog-developers mailing list
> evlog-developers@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/evlog-developers

