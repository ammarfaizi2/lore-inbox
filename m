Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbTA0WGY>; Mon, 27 Jan 2003 17:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbTA0WGY>; Mon, 27 Jan 2003 17:06:24 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:10653 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S263491AbTA0WGV>; Mon, 27 Jan 2003 17:06:21 -0500
Date: Mon, 27 Jan 2003 14:15:24 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Christian Zander <zander@minion.de>, Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030127221523.GP20972@ca-server1.us.oracle.com>
References: <20030127175917.GO20972@ca-server1.us.oracle.com> <Pine.LNX.4.44.0301271208580.18686-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301271208580.18686-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 12:31:07PM -0600, Kai Germaschewski wrote:
> Well, if you're doing things in your module which break with the command 
> line options the rest of the kernel is using, I'd claim you're playing 
> tricks in your module which you shouldn't. The only place I'm aware of 

	I'm not so sure about that.  Some gcc things tweak us, and the
some code has had to deal with it.  This isn't something that happens
often, but it still can.  In addition, CFLAGS_filename.o does not allow
removal of options, merely the addition if I am not mistaken.

> Basically, yes. The build process needs to be able to write, e.g. to 
> compile its helper code in scripts/, so init/vermagic.o is just another
> file being written.

	If my distribution has installed /usr/src/linux-x.y, I can't
compile against it.  Even though the 200MB of a kernel tree is already
taking up space on my system, I have to download *another* 30MB and
install it as *another* 200MB and build it to an eventual *another*
260MB of kernel tree.  So, for every kernel I want to support, I have to
have 260MB of built tree.  And that's just for my userid.  Anyone else
on the box has to have their own n_kernels * 260MB of space waste.

> fact, these checksums are generated as part of the compiled objects, so
> recording checksums needs all other compiled objects to be around. If you 

	But, once the checksums are recorded, the compiled objects are
no longer needed, no?  It still remains that a kernel header package
with associated correct autoconf.h and checksums is at least an order of
magnitude smaller than a built kernel tree.

> As I said, I am sure interested in working with people and distros to get 
> something which everybody can live with. I'm wondering how RedHat manages 
> to have one tree for different configurations, since in that case, at 
> least .config/autoconf.h, EXTRAVERSION and the module version files 
> (*.ver) need to differ, so that kinda seems not possible in one 
> (read-only) tree.

	Red Hat plays tricks.  They add a <rhconfig.h> to the top of
autoconf.h and have some extra defines so that chunks of autoconf.h look
like:

#ifdef UP_FLAG
... some UP CONFIG_* options
#else
#ifdef SMP_FLAG
... some SMP CONFIG_* options

and so on.

	This does indeed track modversions as well (I don't recall which
files do the switching).  This actually works pretty well, but it depends
on the fact that their kernel flavours (up, smp, large ram) are known
at the time they build this setup.  This isn't necessarily the proper
solution for the generic kernel.  
	It still remains that in 2.4 you need the headers for the kernel
plus the proper bits created by config/modversions.  You don't need
anything else, and you don't need any writability after the initial
generation.  This takes significantly less space than an entire built
tree, and is usable from /usr/src as a readonly entity.  Requiring that
*each user* have the kernels they wish to build installed and fully
built is a step back, IMHO.

Joel


-- 

"I always thought the hardest questions were those I could not answer.
 Now I know they are the ones I can never ask."
			- Charlie Watkins

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
