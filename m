Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWFSPP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWFSPP2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWFSPP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:15:28 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:52201 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932084AbWFSPP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:15:27 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17: slow (as hell) tcp inbound transfers
Date: Tue, 20 Jun 2006 01:15:02 +1000
User-Agent: KMail/1.9.3
Cc: Brice Figureau <brice+lklm@daysofwonder.com>,
       Vincent Vanackere <vincent.vanackere@gmail.com>
References: <1150725598.4985.27.camel@localhost.localdomain> <65258a580606190717t2cc5b28eg10fb4d64fe5ec1f3@mail.gmail.com> <1150729187.4985.41.camel@localhost.localdomain>
In-Reply-To: <1150729187.4985.41.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606200115.02492.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 June 2006 00:59, Brice Figureau wrote:
> Hi,
>
> On Mon, 2006-06-19 at 16:17 +0200, Vincent Vanackere wrote:
> > On 6/19/06, Brice Figureau <brice+lklm@daysofwonder.com> wrote:
> > > Now to the problem: I just finished the installation of a brand new
> > > 2.6.17 on a Dell PowerEdge 2850 which was running 2.6.16.19 really
> > > fine, and I'm encountering a strange issue.
> > >
> > > It seems that TCP inbound transfers (using either curl, or scp) are
> > > really slow except when issued on our gigabit LAN.
> >
> > Could you try the following to see if it cures your problem ?
> >
> > echo 0 > /proc/sys/net/ipv4/tcp_window_scaling
>
> Yes, that fixed it:
> # curl http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.17.tar.gz
>
> > /dev/null
>
>   % Total    % Received % Xferd  Average Speed   Time    Time     Time
> Current
>                                  Dload  Upload   Total   Spent    Left
> Speed
>   0 49.3M    0  9856    0     0   2991      0  4:48:05  0:00:03  4:48:02
> 3680
>
> # echo 0 > /proc/sys/net/ipv4/tcp_window_scaling
>
> # curl http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.17.tar.gz
>
> > /dev/null
>
>   % Total    % Received % Xferd  Average Speed   Time    Time     Time
> Current
>                                  Dload  Upload   Total   Spent    Left
> Speed
>   1 49.3M    1  904k    0     0  86544      0  0:09:57  0:00:10  0:09:47
> 71173
>
> Did something has changed between 2.6.16 and 2.6.17 regarding TCP window
> scaling ?
>
> I remember a discussion on lklm aroung 2.6.7 or so that finally ended as
> a bug in a firewall that wasn't handling TCP window scaling gracefully.
> That's certainly my case, I'll will have a look to that.

See:

http://kerneltrap.org/node/6723

-- 
-ck
