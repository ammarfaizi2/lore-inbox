Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261918AbRETNkw>; Sun, 20 May 2001 09:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261924AbRETNkc>; Sun, 20 May 2001 09:40:32 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52617 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261918AbRETNka>;
	Sun, 20 May 2001 09:40:30 -0400
Date: Sun, 20 May 2001 09:40:28 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Kai Henningsen <kaih@khms.westfalen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending Device
 Num
In-Reply-To: <81Cnv5o1w-B@khms.westfalen.de>
Message-ID: <Pine.GSO.4.21.0105200925370.8940-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 20 May 2001, Kai Henningsen wrote:

> I've seen this question several times in this thread. I haven't seen the  
> obvious answer, though.
> 
> Have a new system call:
> 
> ctlfd = open_device_control_fd(fd);
> 
> If fd is something that doesn't have a control interface (say, it already  
> is a control filehandle), this returns an appropriate error code.

It may have several. Which one?

FWIW, I think that mixing network and device ioctls is a bad idea. These
groups are very different and we'd be better off dealing with changes in
them separately.

For devices... I'd say that fpath(2) (same type as getcwd(2)) would be
a good way to deal with that. Or fpath(3) - implemented via readlink(2)
on /proc/self/fd/<n>.

