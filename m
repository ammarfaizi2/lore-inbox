Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265290AbSJaS2K>; Thu, 31 Oct 2002 13:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265291AbSJaS2J>; Thu, 31 Oct 2002 13:28:09 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:7817 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265290AbSJaS2G>; Thu, 31 Oct 2002 13:28:06 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 31 Oct 2002 10:42:28 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Suparna Bhattacharya <suparna@in.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: and nicer too - Re: [PATCH] epoll more scalable
 than poll
In-Reply-To: <20021031164035.A3178@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0210311026080.1562-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Suparna Bhattacharya wrote:

> I think what John means, and what Jamie has also brought up in a
> separate note is that now when an event happens on an fd, in some cases
> there are tests for 3 kinds of callbacks that get triggered -- the wait
> queue for poll type registrations, the fasync list for sigio, and the
> new epoll file send notify type callbacks. There is a little overhead
> (not sure if significant) for each kind of test ...

The poll hooks is not where an edge triggered event notification API wants
to hook. For the way notification are sent and for the registration
method, that is not the most efficent thing. Hooking inside the fasync
list is worth to be investigated and I'll look into it as soon as I
finished the patch for 2.5.45 for Linus. It does have certain limits IMHO,
like the single lock protection. I'll look into it, even if the famous
cost for the extra callback check cannot even be measured IMHO.



- Davide


