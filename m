Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287332AbSAMSLh>; Sun, 13 Jan 2002 13:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287344AbSAMSLS>; Sun, 13 Jan 2002 13:11:18 -0500
Received: from lilly.ping.de ([62.72.90.2]:4362 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S287332AbSAMSLH>;
	Sun, 13 Jan 2002 13:11:07 -0500
Date: 13 Jan 2002 19:10:08 +0100
Message-ID: <20020113191008.A760@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: yodaiken@fsmlabs.com
Cc: "Andrea Arcangeli" <andrea@suse.de>, "Robert Love" <rml@tech9.net>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        "Rob Landley" <landley@trommello.org>,
        "Andrew Morton" <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020112121315.B1482@inspiron.school.suse.de> <20020112160714.A10847@planetzork.spacenet> <20020112095209.A5735@hq.fsmlabs.com> <20020113161823.B1439@planetzork.spacenet> <20020113105104.A16845@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20020113105104.A16845@hq.fsmlabs.com>; from yodaiken@fsmlabs.com on Sun, Jan 13, 2002 at 10:51:04AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2002 at 10:51:04AM -0700, yodaiken@fsmlabs.com wrote:
> On Sun, Jan 13, 2002 at 04:18:23PM +0100, jogi@planetzork.ping.de wrote:
> > On Sat, Jan 12, 2002 at 09:52:09AM -0700, yodaiken@fsmlabs.com wrote:
> > > On Sat, Jan 12, 2002 at 04:07:14PM +0100, jogi@planetzork.ping.de wrote:
> > > > I did my usual compile testings (untar kernel archive, apply patches,
> > > > make -j<value> ...
> > > 
> > > If I understand your test, 
> > > you are testing different loads - you are compiling kernels that may differ
> > > in size and makefile organization, not to mention different layout on the
> > > file system and disk.
> > 
> > No, I use a script which is run in single user mode after a reboot. So
> > there are only a few processes running when I start the script (see
> > attachment) and the jobs should start from the same environment.
> 
> But your description makes it sound like you do
> 	untar kernel X
> 	apply patches Y
> 	make -j  Tree
> 
> I'm sorry if I'm getting you wrong, but each of these steps is
> variable.
> Even if X and Y are the same each time, "Tree" is different.

X and Y are the same. But I don't really get why this is still
"different" ... If you think this could be because of the fs
fragmentation then I will enhance my test. I think I have a spare
partition somewhere which I can format each time before untar the
kernel sources and so on. But why can I reproduce the results then?
Ok, not exactly but the results do get close ...

Furthermore I am timing not only the make -j<value> but also the
complete untar and applying of patches. So basically I am timing the
following:

tar xvf linux-x.y.z.tar
patch -p0 < some_patches
cd linux; cp ../config-x.y.z .config
make oldconfig dep
make -j $PAR bzImage modules

and afterwards

cd .. ; rm -rf linux

and start again. Its just the same as doing 'rpm --rebuild' with

MAKE=make -j $PAR

> The test should be
> 	reboot
> 		N times
> 		make clean
> 		time make -j Tree
> 
> Am I misunderstaning your test?

No, but I don't understand why this should make any difference. I do not
propose my way of testing as *the* benchmark. Its just a benchmark of
something which I do most of the time on my system (compiling) in an
extreme way ...

Kind regards,

   Jogi

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
