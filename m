Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318114AbSHIBpc>; Thu, 8 Aug 2002 21:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318116AbSHIBpc>; Thu, 8 Aug 2002 21:45:32 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:62101 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S318114AbSHIBpb>;
	Thu, 8 Aug 2002 21:45:31 -0400
Date: Fri, 9 Aug 2002 03:49:04 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Hubertus Franke <frankeh@us.ibm.com>, Andrew Morton <akpm@zip.com.au>,
       <andrea@suse.de>, <davej@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Paul Larson <plars@austin.ibm.com>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
Message-ID: <20020809014904.GA909@win.tue.nl>
References: <Pine.LNX.4.44.0208081500550.9114-100000@home.transmeta.com> <Pine.LNX.4.44L.0208081936170.2589-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0208081936170.2589-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 07:37:08PM -0300, Rik van Riel wrote:

> Hmmm, I wonder how badly the system will behave when
> we need to reset last_pid and next_safe with 30000
> pids in use ...

On average very well, that is, the time spent in finding
the next pid is very small on average, but once in a while
there is a small hiccup.
On a hard real time system it may be reasonable to choose
for an average that is ten times higher and avoid the hiccup.

For systems that really have lots of very short-lived
processes, one might do what I suggested a moment ago
for a MP context: have the processes live in several lists,
that each only use part of the pid-space.

(One wants for_each_task to take a limited amount of time.
With N tasks, and sqrt(N) list heads one first picks the
shortest list, then loops over the list, all in time of order
sqrt(N). That works well, certainly up to a million processes.)

Andries
