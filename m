Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265289AbSKFBXv>; Tue, 5 Nov 2002 20:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265290AbSKFBXv>; Tue, 5 Nov 2002 20:23:51 -0500
Received: from almesberger.net ([63.105.73.239]:52745 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265289AbSKFBXu>; Tue, 5 Nov 2002 20:23:50 -0500
Date: Tue, 5 Nov 2002 22:29:40 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, jw@pegasys.ws,
       rml@tech9.net, andersen@codepoet.org, woofwoof@hathway.com
Subject: Re: ps performance sucks
Message-ID: <20021105222940.C10679@almesberger.net>
References: <20021105203704.K1408@almesberger.net> <200211060010.gA60ALY387457@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211060010.gA60ALY387457@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Tue, Nov 05, 2002 at 07:10:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan wrote:
> I was thinking "80basic" would ask for the first 0x80 words
> of basic info. If there's less, zero-fill. If there's more,
> truncate the struct. Then "20pids" asks for the first 0x20
> words of pid info (pid, ppid, sess, pgid...) and so on.

Argl, this has "silent failure" written all over it. No, I think
single-field granularity wouldn't incur excessive overhead: at
run time, you can trivially handle adjacent fields with a single
copy, and I don't think there are really that many practically
useful fields that setup cost (CPU or memory) would be terrible.

[ Various change horrors ]

Hmm yes, about as bad as I remember it from my psmisc days :-(

> That's nice, until you exceed the amount of memory available.

That would the the least of my concerns. If you really run out
of memory, you can always fall back to an iterative process.

> Hey, if reiserfs can have a database query syscall... >:-)
> open("/proc/SELECT PID,TTY,TIME,CMD FROM PS WHERE RUID=42",O_RDONLY)

Cute ;-) But it might be faster just to dump the whole data,
and let user space worry about picking the right entries.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
