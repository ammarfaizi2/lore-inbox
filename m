Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280153AbRLQQlv>; Mon, 17 Dec 2001 11:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281214AbRLQQlm>; Mon, 17 Dec 2001 11:41:42 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:49066 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S280814AbRLQQlg>; Mon, 17 Dec 2001 11:41:36 -0500
Date: Mon, 17 Dec 2001 09:41:23 -0700
Message-Id: <200112171641.fBHGfNQ08711@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill(-1,sig)
In-Reply-To: <01121709413305.01828@manta>
In-Reply-To: <200112170701.fBH71uW04275@vindaloo.ras.ucalgary.ca>
	<01121709413305.01828@manta>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda@port.imtp.ilyichevsk.odessa.ua writes:
> On Monday 17 December 2001 05:01, Richard Gooch wrote:
> >   Hi, all. To followup on the change in 2.5.1 which sends a signal to
> > the signalling process when send_pid==-1, I have a definate case where
> > the new behaviour is highly undesirable, and I would say broken.
> >
> > shutdown(8) from util-linux (*not* the version that comes with the
> > bloated monstrosity known as SysVInit) uses the sequence:
> 
> Hi Richard, I'm using your new init and happy with it (thanks!).
> I am very willing to discuss other side of a coin (i.e. shutdown sequence),
> let's do it off the list.
> 
> > 	kill (-1, SIGTERM);
> > 	sleep (2);
> > 	kill (-1, SIGKILL);
> >
> > to ensure that all processes not stuck in 'D' state are killed.
> >
> > With the new behaviour, shutdown(8) ends up killing itself. This is no
> > good, because the shutdown process doesn't complete (i.e. unmounting
> > of filesystems, calling sync(2) and good stuff like that).
> 
> I don't use your shutdown, I found it possible to spawn a shell
> script in a new process group and use killall5 to term/kill
> everything except this process group. It works. (But yesterday I saw
> fsck again... something did not get umounted?) I can mail my scripts
> to you for a little discussion. Mail me.

You're welcome to use killall to do this, but I don't think you should
*have to*. What if /proc isn't mounted? But more importantly, I don't
think shutdown(8) should be broken by such a change.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
