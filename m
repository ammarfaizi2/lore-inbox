Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSGYNQN>; Thu, 25 Jul 2002 09:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSGYNQN>; Thu, 25 Jul 2002 09:16:13 -0400
Received: from babyruth.hotpop.com ([204.57.55.14]:31677 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP
	id <S312973AbSGYNQM> convert rfc822-to-8bit; Thu, 25 Jul 2002 09:16:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mike Insch <vofka@hotpop.com>
Reply-To: vofka@hotpop.com
To: Andre Hedrick <andre@linux-ide.org>
Subject: Re: Oddities with HighPoint HPT374, 2.4.19-pre10-ac2
Date: Thu, 25 Jul 2002 14:10:57 +0100
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10207250507480.4719-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10207250507480.4719-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207251410.57227.vofka@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK - Thanks for the Info.

For the moment, the machine in question will be simply running as a SAMBA 
Server, and then only for one or two clients at a time (it's storing disk 
images from PowerQuest's Drive Image Pro Software), and it (so far) seems to 
be stable enough when data is coming in from the network.

If there is any detailed info. I can give you from the system, I'll be happy 
to pop them over to you - similarly, if I can help test any revised versions 
in the future, I'd be happy to do so.

Thanks again... :)

On Thursday 25 July 2002 13:25, Andre Hedrick wrote:
> The oddities are the fact I have not finished creating the channel and
> drive set inner-lock sequence code :-/  If you run it in master mode only
> one drive per channel, it is perfectly safe.  The problem happens the
> instant you pair drives on the channels.  I have not figured out the
> correct interrupt sequence ordering and blocking recipe.
>
> The issue stands to deal with double hwgroups locking and having more than
> two channels to the effective HBA.
>
> Instead of
>
> HPT374
>   ide4
>   ide5
> HPT374
>   ide6
>   ide7
>
> It has to evlolve to
>
> HPT374
>   ide4p
>   ide4s
>   ide5p
>   ide5s
>
> This means extened minor on the second half of each major must be created.
> There is not enough sane bandwith in the driver, nor would anybody take
> such an exotic solution.
>
> Sorry,
>
> Andre Hedrick
> LAD Storage Consulting Group
>


