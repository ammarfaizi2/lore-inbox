Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310204AbSCKXy6>; Mon, 11 Mar 2002 18:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310205AbSCKXys>; Mon, 11 Mar 2002 18:54:48 -0500
Received: from mail.rttinc.com ([139.142.30.71]:43274 "HELO mail.rttinc.com")
	by vger.kernel.org with SMTP id <S310204AbSCKXyg>;
	Mon, 11 Mar 2002 18:54:36 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Brad Pepers <brad@linuxcanada.com>
Organization: Linux Canada Inc.
To: dipankar@in.ibm.com
Subject: Re: Multi-threading
Date: Mon, 11 Mar 2002 16:53:45 -0700
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020312010618.A32259@in.ibm.com>
In-Reply-To: <20020312010618.A32259@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020311235442Z310204-890+125062@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 March 2002 12:36, Dipankar Sarma wrote:
> In article <20020311182111Z310364-889+120750@vger.kernel.org> Brad Pepers 
wrote:
> > There was a message posted by Jim Starkey about his experiences using
> > threads on Linux and the problems debugging them.  It came down to two
> > things:
> >
> > 2. Linux is missing an atomic use-count mechanism which returns values
> > like the Microsoft InterlockedIncrement/Decrement functions do.
>
> Can't this be done using atomic_dec_and_test() and the likes ?
> Google tells me that windoze InterlockedIncrement/Decrement stuff
> does the almost same thing. Why can't refcounting be
> implemented using just atomic_inc/dec and/or atomic_inc/dec_and_test ?

The atomic_dec_and_test certainly handles the most often used case and is 
good enough.  Apparently it would be nice to have the value back sometimes 
too though.

The atomic_inc_and_test is not much good though since the case you most often 
want to track is the 0 to 1 transition and not -1 to 0!

-- 
Brad Pepers
brad@linuxcanada.com
