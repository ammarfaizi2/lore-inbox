Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVLAF6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVLAF6p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 00:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbVLAF6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 00:58:44 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:61784 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932089AbVLAF6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 00:58:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.br;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=znneHsvYDd16WeejnNSy5CcsK5IvqGbzytzETj9se3LJgya1wxEfjZDB9CbPkYQVFWO13pzZYtEdKu1TKQ2D9fcid1GOSzTAjVsghYHk2udsFrv0D7S02CFb+Q1hC2LDUg5vRxxzWBmXpTaPEsiP02Yudv2ryy/Ucm2j7B+QCEg=  ;
Subject: Re: Gene's pcHDTV 3000 analog problem
From: Mauro Carvalho Chehab <mauro_chehab@yahoo.com.br>
To: Linux and Kernel Video <video4linux-list@redhat.com>
Cc: linux-kernel@vger.kernel.org, Michael Krufky <mkrufky@m1k.net>
In-Reply-To: <200511292306.09395.gene.heskett@verizon.net>
References: <200511282205.jASM5YUI018061@p-chan.krl.com>
	 <c35b44d70511291435i5f07bc88g429276ef659c28c5@mail.gmail.com>
	 <438CDDBC.1070704@m1k.net>  <200511292306.09395.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 30 Nov 2005 10:59:17 -0200
Message-Id: <1133355557.8133.35.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-3mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene,

	Two questions:

1) Is it a 64bit machine?

2) please try to modprobe tuner with offset=100, then with offset=-100.
offset option will force tuner to make a freq offset. It might be the
case.

Cheers,
Mauro.

Em Ter, 2005-11-29 às 23:06 -0500, Gene Heskett escreveu:
> On Tuesday 29 November 2005 18:01, Michael Krufky wrote:
> >Kirk Lapray wrote:
> >> I only run the cards in digital mode.  I have no need to tune to any
> >> analog channels with them.  When I was working on nxt200x I was able
> >> to tune both analog and digital channels on the HDTV Wonder, but I
> >> have never tried to tune to any analog channels using the HD3000.
> >> This was using kernel 2.6.13 and the cvs v4l and dvb trees.
> >>
> >> I am not sure when I will have some time to test 2.6.15-rc3, but if I
> >> get some time I will try analog support on this and my current setup.
> >>
> >> Kirk
> >
> >Kirk-
> >
> >Please test your cards in analog mode, or I fear that we may have to
> >cause NXT200X to depend on BROKEN.
> >
> >Here's why....
> >
> >A few months ago, as we added the nxt200x module to cvs, I told you
> > that with nxt200x loaded into memory, I had some extra devices showing
> > up on my i2c bus.  At the time, I was using another cx88 card, and it
> > did not use the nxt200x module itself, although it loads up into
> > memory automatically by the cx88-dvb module.
> 
> It was not being loaded by a modprobe cx88-dvb here, see my lsmod
> listing from earlier today.
> 
> >You told me that there was some code in nxt200x module that somehow
> >opens up a channel to hidden i2c devices.  Why would this code affect
> > my system if my device is not using the nxt200x module?
> >
> >Is there code being run at nxt200x module load that is causing this
> >BEFORE cx88-dvb calls nxt200x_attach() ?
> >
> >It seems that Gene, Perry and Don are having problems with their analog
> >tuners (they each have pcHDTV 3000) ever since nxt200x got added.
> >
> >Gene, Perry and Don - What happens if you have the cx88 module loaded,
> >but you do NOT load up cx88-dvb (nxt200x will not be loaded) ... Does
> >the problem persist?
> 
> Having done an rmmod of everything related, installling the cvs but no
> reboot, an attempt to modprobe cx88 back into the system gets a module
> not found message.  So maybe I have to reboot anyway, brb.
> >
> >You do not need cx88-dvb to view analog television.
> >
> >Kirk, we need a control group!  Please test analog on both boards.
> >
> >Kirk, there is a thread on the v4l/dvb mailing lists right now about an
> >i2c gate dealing with Hauppauge cards and cx22702 frontend.  What Steve
> >Toth has described about this 'i2c gate' is starting to sound similar
> > to what you mentioned about making hidden i2c devices visible.
> >
> >I'm getting the feeling that nxt200x is indeed the problem.
> >
> >Gene, Perry and Don .... Another thing you can try -- Once again,
> >install v4l-dvb cvs on top of your running kernel, but this time,
> > before compiling, edit v4l-dvb/v4l/Makefile , and remove the line:
> >
> > EXTRA_CFLAGS += -DHAVE_NXT200X=1
> 
> I took these out before I installed the cvs to 2.6.14.3.  So here goes
> a reboot.
> >
> >... This line appears twice, you only need to remove the top one, as it
> >pertains to the cx88 card, although it is safe to remove both for the
> >purposes of this test.
> >
> >If this fixes your problem, then we know that nxt200x is the cause.
> 
> As I said above, nxt200x wasn't being loaded by the modprobe cx88-dvb
> statement.  I'm now rebooted after having done a cvs install after
> modifying the v4l/Makefile, and its now broken again.  So I'm not
> convinced that the nxt200x code has anything to do with my problem, at
> least not yet.  Now I have to see if I can recover by blowing away the
> /lib/modules dir and doing another make modules_install in the 2.6.14.3
> tree, plus a cold reboot.  Nah, to heck with it, just rerun my makeit
> script again, only takes about 9 minutes for a clean rebuild.  But this
> cold reboot will take about 20 minutes, I have umpty gigabytes of
> partitions that will e2fsck, /dev/hdd3 (180GB for amandas virtual 
> tapes) taking at least 15 minutes, much of it with the progress bar
> stuck at about 13%.  And another 80 GB partition is set for this round
> too.  It sticks for 5 minutes at about 30%, e2fsck, version 1.35, needs
> help IMNSHO. But thats what we have I guess... 
> 
> Anyway, rebooted, and it works again after modprobe cx88-dvb from a
> cli. I let it run about 3 minutes, and got this in the messages log:
> 
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc04c561a
> Nov 29 22:56:18 coyote last message repeated 3 times
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0x800476c6
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0045627
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0x80045626
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc04c561a
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0x80085617
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0x40085618
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc054561d
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0x4054561e
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0045627
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0x80045626
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc04c561a
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0x80085617
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0x40085618
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc054561d
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0x4054561e
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0445624
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561b
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0445624
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561b
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0445624
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561b
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0445624
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561b
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0x402c5639
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0445624
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561c
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0445624
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561c
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0445624
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561c
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0445624
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561c
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0445624
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561b
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0445624
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561b
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0445624
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561b
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0445624
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561b
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc02c5638
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc054561d
> Nov 29 22:56:18 coyote last message repeated 2 times
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561c
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0445624
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561c
> Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc054561d
> Nov 29 22:56:49 coyote last message repeated 907 times
> Nov 29 22:57:50 coyote last message repeated 1828 times
> Nov 29 22:58:46 coyote last message repeated 1703 times
> Nov 29 22:58:46 coyote kernel: CORE IOCTL: 0xc008561c
> 
> Is this related to the memory problems you commented on a couple of
> times?  The system seems stable though.  And I've watched tv by the
> hour many times, not knowing I should be tailing the log.
> 
> The log size so far for this week is ~500k.
> 
> >-Mike
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Mauro Carvalho Chehab <mauro_chehab@yahoo.com.br>


	

	
		
_______________________________________________________ 
Yahoo! doce lar. Faça do Yahoo! sua homepage. 
http://br.yahoo.com/homepageset.html 

