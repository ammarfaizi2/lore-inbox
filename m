Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271329AbRHZQsk>; Sun, 26 Aug 2001 12:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271332AbRHZQsU>; Sun, 26 Aug 2001 12:48:20 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:8971 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271329AbRHZQsN>; Sun, 26 Aug 2001 12:48:13 -0400
Content-Type: text/plain;
  charset="utf-8"
From: Daniel Phillips <phillips@bonn-fries.net>
To: pcg@goof.com, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Sun, 26 Aug 2001 18:54:55 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010824201125Z16096-32383+1213@humbolt.nl.linux.org> <Pine.LNX.4.33L.0108241713420.31410-100000@duckman.distro.conectiva> <20010825012338.B547@cerebro.laendle>
In-Reply-To: <20010825012338.B547@cerebro.laendle>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010826164818Z16191-32383+1474@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 25, 2001 01:23 am, pcg@goof.com ( Marc) (A.) (Lehmann ) wrote:
> I could imagine that read() executes, returns to
> userspace and at the same time the kernel thinks "nothing to do, let's
> readahead". While, in the concurrent case, there is hardly a time when no
> read() is running. But read-ahead does not seem to work that way.

But it's a very interesting idea: instead of performing readahead in 
generic_file_read the user thread would calculate the readahead window
information and pass it off to a kernel thread dedicated to readahead.
This thread can make an informed, global decision on how much IO to
submit.  The user thread benefits by avoiding some stalls due to
readahead->readpage, as well as avoiding thrashing due to excessive
readahead.

--
Daniel
