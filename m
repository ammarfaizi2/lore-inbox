Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263700AbTEJJ1D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 05:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263704AbTEJJ1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 05:27:03 -0400
Received: from almesberger.net ([63.105.73.239]:38922 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S263700AbTEJJ1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 05:27:02 -0400
Date: Sat, 10 May 2003 06:39:36 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anyone ever implemented a reparent(pid) syscall?
Message-ID: <20030510063936.D13069@almesberger.net>
References: <3EBBF965.4060001@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBBF965.4060001@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Fri, May 09, 2003 at 02:54:29PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> I would like some way for the main one to restart, read the 
> list of pids out of a file that it conveniently stashed away,
[...]

And until it has done this, any child death will still only be seen
by init. So you either didn't have a problem with this in the first
place, or you can make sure your children don't die while their
parents are changing, or you've just designed yourself a race
condition.

A design where the parent simply doesn't die would be much better.

> Has anyone ever done this?

You could use ptrace to pretty much this effect. Of course, this
only works if the child processes don't already use ptrace for
some other purpose, and your parent now needs to respond whenever
a child gets a non-terminal signal (in addition to the terminal
ones).

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
