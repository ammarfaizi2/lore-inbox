Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268419AbRGXSPw>; Tue, 24 Jul 2001 14:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268420AbRGXSPn>; Tue, 24 Jul 2001 14:15:43 -0400
Received: from marine.sonic.net ([208.201.224.37]:32326 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S268419AbRGXSP0>;
	Tue, 24 Jul 2001 14:15:26 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Tue, 24 Jul 2001 11:15:30 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Optimization for use-once pages
Message-ID: <20010724111530.H5835@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0107241447440.20326-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24, 2001 at 02:51:03PM -0300, Rik van Riel wrote:
> Let me give you an example:
> 
> - sequential access of a file
> - script reads the file in 80-byte segments
>   (parsing some arcane data structure)
> - these segments are accessed in rapid succession
> - each 80-byte segment is accessed ONCE
> 
> In this case, even though the data is accessed only
> once, each page is touched PAGE_SIZE/80 times, with
> one 80-byte read() each time.

Of course, such a program is poorly written anyway.  That many individual
system calls!  At least rewrite to use fread().  ;->

Change the example to using mmap(), and one feels less likely throttle the
programmer.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
