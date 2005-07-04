Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVGDOdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVGDOdF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 10:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVGDOdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 10:33:05 -0400
Received: from web88012.mail.re2.yahoo.com ([206.190.37.231]:52094 "HELO
	web88012.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261183AbVGDOcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 10:32:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=v6eNVy31QVGo/xUASHkAlCEDBfuuFRHcQC5fAxnhMZJR9FYxTrbYNpIGWFhPOosNQ0wA99Ai1vJ1lx73epQ0At9/+vBoeaxuEOGkkj78Lpwj6YY+pP0+X9xZNZ6P/kxk/7aYODRvZTzkKZzjcTn9xpDLIDB5TsyTzCNuAJi8l3A=  ;
Message-ID: <20050704143217.41663.qmail@web88012.mail.re2.yahoo.com>
Date: Mon, 4 Jul 2005 10:32:17 -0400 (EDT)
From: Shawn Starr <shawn.starr@rogers.com>
Subject: Re: [Hdaps-devel] Re: IBM HDAPS things are looking up
To: Jens Axboe <axboe@suse.de>, Lenz Grimmer <lenz@grimmer.com>
Cc: hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050704132516.GO1444@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From what I'm told its not specific to hard disk, you
can put any laptop HD and it will work the same (?).

Shawn.

--- Jens Axboe <axboe@suse.de> wrote:

> On Mon, Jul 04 2005, Lenz Grimmer wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > Hi Jens!
> > 
> > Thanks for the sample code. I've trimmed the
> recipient list a bit...
> > 
> > Jens Axboe wrote:
> > 
> > > Perhaps the IDLE or IDLEIMMEDIATE commands imply
> a head parking, that
> > > would make sense. As you say, you can hear a
> drive parking its head.
> > > Here's a test case, it doesn't sound like it's
> parking the hard here.
> > 
> > Not here either, but let me check, if I understand
> this correctly:
> > 
> > > #include <stdio.h>
> > > #include <unistd.h>
> > > #include <fcntl.h>
> > > #include <sys/ioctl.h>
> > > #include <linux/hdreg.h>
> > > 
> > > int main(int argc, char *argv[])
> > > {
> > > 	char cmd[4] = { 0xe1, 0, 0, 0 };
> > 
> > The "0xe1" in here is what is defined as
> "WIN_IDLEIMMEDIATE" in hdreg.h,
> > correct?
> 
> Correct.
> 
> > > 	int fd;
> > > 
> > > 	if (argc < 2) {
> > > 		printf("%s <dev>\n", argv[0]);
> > > 		return 1;
> > > 	}
> > > 
> > > 	fd = open(argv[1], O_RDONLY);
> > 
> > Hmm, don't I need to actually have *write* access
> for sending an ioctl?
> 
> No, but you need CAP_SYS_RAWIO capability. So run it
> as root.
> 
> > > 	if (fd == -1) {
> > > 		perror("open");
> > > 		return 1;
> > > 	}
> > > 
> > > 	if (ioctl(fd, HDIO_DRIVE_CMD, cmd))
> > > 		perror("ioctl");
> > > 
> > > 	close(fd);
> > > 	return 0;
> > > }
> > 
> > I will give it another try, after clarifying the
> above questions - maybe
> > there is a command that will perform the desired
> task. If not, I guess
> > we're back at snooping what the Windows driver
> does here...
> 
> I'm not aware of a generally specificed command,
> it's likely that the
> ibm drive has a vendor specific one. Or that one of
> the idle commands
> can be configured to park the drive. Or... I'm not
> sure you'll find
> anything interesting in the windows driver, I would
> imagine that the
> user app is the one issuing the ide command (like
> the linux equiv would
> as well).
> 
> -- 
> Jens Axboe
> 
> 
> 
>
-------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux
> Migration Strategies
> from IBM. Find simple to follow Roadmaps,
> straightforward articles,
> informative Webcasts and more! Get everything you
> need to get up to
> speed, fast.
>
http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Hdaps-devel mailing list
> Hdaps-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/hdaps-devel
> 

