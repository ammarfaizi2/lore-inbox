Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278273AbRJMFzz>; Sat, 13 Oct 2001 01:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278274AbRJMFzp>; Sat, 13 Oct 2001 01:55:45 -0400
Received: from mailgw.netvision.net.il ([194.90.1.14]:65451 "EHLO
	mailgw1.netvision.net.il") by vger.kernel.org with ESMTP
	id <S278273AbRJMFzb>; Sat, 13 Oct 2001 01:55:31 -0400
Date: Sat, 13 Oct 2001 07:58:53 +0200
From: Etay Meiri <cl1@netvision.net.il>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: exporting open_namei to modules
Message-ID: <20011013075853.C1069@amber.rog.net>
In-Reply-To: <20011013011841.B1069@amber.rog.net> <Pine.GSO.4.21.0110121955470.76-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0110121955470.76-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Oct 12, 2001 at 08:03:33PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 08:03:33PM -0400, Alexander Viro wrote:
> 
> 
> On Sat, 13 Oct 2001, Etay Meiri wrote:
> 
> > Hi,
> > 
> > Is there a particular reason why open_namei() is
> > not exported to modules?
> 
> 	Is there any reason for exporting it?  By default, stuff is _NOT_
> exported.  Think for a moment and you'll see why.  Exported functions are
> public API.  Protection is weaker than for syscalls, but it's there and
> exporting a function makes harder to do changes in core kernel.  Unless
> there are damn serious reasons for exporting something, it isn't done.
> 
> 	In particular, open_namei() is a helper function of filp_open(),
> which _is_ exported.  What use of open_namei() do you have in mind?

I'm writing a kernel file server. Unlike NFS, clients send me full paths
so I need to translate them to their respective inodes before calling
->open(...).
The reason I didn't use filp_open() in the first place is because it calls 
get_empty_filp() and, when I started writing this thing, didn't really understand
and so I thought it was better for me to call open_namei() directly and duplicate
some of the stuff that was going on in filp_open(). Now I see that there is a better
solution. 

Thanks Alexander.

> 
> 

-- 
************************************************
"When in doubt, use brute force."
									Ken Thompson
Etay Meiri
cl1@netvision.net.il
************************************************
