Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130222AbRBBXb1>; Fri, 2 Feb 2001 18:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130443AbRBBXbR>; Fri, 2 Feb 2001 18:31:17 -0500
Received: from chiara.elte.hu ([157.181.150.200]:38407 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130222AbRBBXbD>;
	Fri, 2 Feb 2001 18:31:03 -0500
Date: Sat, 3 Feb 2001 00:30:24 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Rajagopal Ananthanarayanan <ananth@sgi.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <linux-aio@kvack.org>, <kiobuf-io-devel@lists.sourceforge.net>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [Kiobuf-io-devel] Re: 1st glance at kiobuf overhead in kernelaio
 vs  pread vs user aio
In-Reply-To: <3A7B409E.F63CA509@sgi.com>
Message-ID: <Pine.LNX.4.30.0102030023530.8627-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Feb 2001, Rajagopal Ananthanarayanan wrote:

> Do you really have worker threads? In my reading of the patch it seems
> that the wtd is serviced by keventd. [...]

i think worker threads (or any 'helper' threads) should be avoided. It can
be done without any extra process context, and it should be done that way.
Why all the trouble with async IO requests if requests are going to end up
in a worker thread's context anyway? (which will be a serializing point,
otherwise why does it end up there?)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
