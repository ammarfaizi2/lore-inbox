Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262779AbSJaSum>; Thu, 31 Oct 2002 13:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262813AbSJaSuj>; Thu, 31 Oct 2002 13:50:39 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:24775 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262779AbSJaSue>; Thu, 31 Oct 2002 13:50:34 -0500
Subject: Re: How to get a local IPv4 address from within a kernel module?
To: jt@hpl.hp.com
Cc: jbm@blessed.joshisanerd.com, jbm@joshisanerd.com,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OF2A57D796.6BC33C05-ON87256C63.0067D726@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Thu, 31 Oct 2002 10:56:53 -0800
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0|September 26, 2002) at
 10/31/2002 11:56:54
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





I think wht you propose below is exactly what I would like to have, my
problem is that implementing
gethostbyname(hostname()) within the kernel is not that easy as most of the
code that supports these calls is designed to be used from user-land
Let's hope some other people will also advise on this so I can combine
ideas and propose something that will likely be accepted.

Juan



|---------+---------------------------->
|         |           Jean Tourrilhes  |
|         |           <jt@bougret.hpl.h|
|         |           p.com>           |
|         |                            |
|         |           10/31/02 10:30 AM|
|         |           Please respond to|
|         |           jt               |
|         |                            |
|---------+---------------------------->
  >------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                  |
  |       To:       Juan Gomez/Almaden/IBM@IBMUS                                                                     |
  |       cc:       Josh Myer <jbm@joshisanerd.com>, jbm@blessed.joshisanerd.com, linux-kernel@vger.kernel.org       |
  |       Subject:  Re: How to get a local IPv4 address from within a kernel module?                                 |
  |                                                                                                                  |
  |                                                                                                                  |
  >------------------------------------------------------------------------------------------------------------------|



On Thu, Oct 31, 2002 at 10:09:54AM -0800, Juan Gomez wrote:
>
> Josh
>
> That is the purpose of my orignal message. In fact I have implemented
> somthing along the lines of what you suggest below and I just want to
test
> the waters on whether this will be accepted. My current implementation is
a
> little more specific as it only gets the interfaces with IPv4 enabled on
> them and skip lo but the idea is to get a consensus on what would be
> genrally useful and then introduce that.
>
> Regards, Juan

             I personally think it's a very bad idea, because it will lead
to confusion. You will define a concept of "the node IP address",
which doesn't exist and is a very dangerous assumption.
             Just take VPN, which is becoming very widespread. You have two
IP addresses, one on the interface, one on the tunnel. Which one do
you get ? Those two IP address will have widely different behaviour
and you can't exchange them.
             My fear is that people will start coding around this API and
flawed concept, and most of their programs will be immediately flawed,
because incapable to adapt to the reality of networking (it will work
in the simple case, but give bizarre behavior in non simple cases).
             Don't get me wrong, there is a small class of applications
where the IP address doesn't matter (and for those, 127.0.0.1 should
be fine). But, from my experience, the vast majority of people wanting
"the node IP address" have broken designs, i.e. it's not that they
want any one of them, it's that they assume that only one exist.

             Now, there is only one thing that could qualify as "the node
IP address", this is the IP address associated with the hostname :
                         gethostbyname(hostname());
             IMHO, if you define the interface you are proposing, it should
always return the result above, because this is a well defined
semantic and it is more useful.

             But, I'm only one of the little guy here, so what I say
doesn't matter much. Ask Alan or DaveM.
             Regards,

             Jean



