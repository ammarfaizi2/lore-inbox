Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263438AbSJOSgS>; Tue, 15 Oct 2002 14:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264783AbSJOSgS>; Tue, 15 Oct 2002 14:36:18 -0400
Received: from relay1.pair.com ([209.68.1.20]:10767 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S263438AbSJOSgR>;
	Tue, 15 Oct 2002 14:36:17 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3DAC643C.86A016B4@kegel.com>
Date: Tue, 15 Oct 2002 11:53:48 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Benjamin LaHaise <bcrl@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
References: <3DAB46FD.9010405@watson.ibm.com> <20021015110501.B11395@redhat.com> <3DAC4B0E.EBB3A2AB@kegel.com> <3DAC59ED.2070405@watson.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> Are there any performance numbers for F_SETSIG/F_SETOWN/SIGIO on 2.5 ?

I don't recall any.  (I suppose I should get off my butt and start
running 2.5.)

> Does it scale with the number of active connections too ?

The overhead is probably mostly linear with activity, I don't know.
 
> Signal-per-fd seems to be a decent alternative (from the measurements on
> Davide's /dev/epoll page) but Vitaly Luban's patch for that isn't available
> for 2.5 so I'm not sure what other issues it might have.

Seems like the thing to do is to move /dev/epoll over to use
Ben's event system rather than worry about the old /dev/epoll interface.
But like signal-per-fd, we will want to collapse readiness events,
which is something Ben's event system might not do naturally.
(I wouldn't know -- I haven't actually looked at Ben's code.)

- Dan
