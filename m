Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbTJ2QVe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 11:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbTJ2QVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 11:21:34 -0500
Received: from colt-na165.alcatel.fr ([62.23.212.165]:12446 "EHLO
	smail.alcatel.fr") by vger.kernel.org with ESMTP id S262070AbTJ2QVH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 11:21:07 -0500
Sensitivity: 
Subject: Re: [cgl_discussion] RE: ANNOUNCE: User-space System Device Enumation	(uSDE)
To: "Guo, Min" <min.guo@intel.com>
Cc: "Greg KH" <greg@kroah.com>, "Steven Dake" <sdake@mvista.com>,
       linux-raid@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       Lars Marowsky-Bree <lmb@suse.de>,
       "Ling, Xiaofeng" <xiaofeng.ling@intel.com>,
       Mark Bellon <mbellon@mvista.com>, linux-kernel@vger.kernel.org,
       cgl_discussion@osdl.org
From: Eric.Chacron@alcatel.fr
Date: Wed, 29 Oct 2003 17:20:01 +0100
Message-ID: <OF3ACB2DB7.10C92CBA-ONC1256DCE.00538D5B@netfr.alcatel.fr>
X-MIMETrack: Serialize by Router on FRMAIL19/FR/ALCATEL(Release 5.0.11  |July 24, 2002) at
 10/29/2003 17:20:02
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>From a pure technical point of view  and from presentations made by the
authors of u*** perspective
i think uSDE could add some interresting features like a customizable
naming policy.
For instance: geographical addressing to identify devices using rack,
subrack, slot numbers
seems possible.

I have not a good knowledge of the history of all these projects : udev,
sysfs, /sbin/hotplug , devfs ...
But what could be needed is some references from one project to others it
depends on or inherits.
I have read such a reference in Greg udev whitepaper and it is very
helpfull to understand added values.


Eric







"Guo, Min" <min.guo@intel.com>@lists.osdl.org on 10/29/2003 06:12:26 AM

Sent by:    cgl_discussion-bounces@lists.osdl.org


To:    "Greg KH" <greg@kroah.com>, "Steven Dake" <sdake@mvista.com>
cc:    linux-raid@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net, Lars Marowsky-Bree
       <lmb@suse.de>, "Ling,  Xiaofeng" <xiaofeng.ling@intel.com>, Mark
       Bellon <mbellon@mvista.com>, linux-kernel@vger.kernel.org,
       cgl_discussion@osdl.org
Subject:    [cgl_discussion] RE: ANNOUNCE: User-space System Device
       Enumation  (uSDE)


Here I try to summary out some difference for uSDE and uDEV,any comments
are welcome!
In my opinion, competition is good and user can choose one they like
because both of them
are user-space applications with a little minor kernel changes,is that
right?

1.For the IDE/SCSI/PCI hotplug devices.
 uDEV:
 edit namedev.config manually to specify certain map,
 if slot change or device change, user can re-edit namedev.config
 uSDE
 record the id or slot at the first time, when move device to new slot or
 change to a new same type device,
 automatically persist the name.
 user can also specify map manually.

2.For non-hotplug device
 uDEV:
    not deal with it
 uSDE
    scan at boot time and also perform policy method. so when moved or
replaced devcie when the machine is
down, the name can also be persisted.


3. for multipath device.
uDEV
     not support it.
uSDE
     automatically detect mulitpath device and create md device. support
     hot add a new path and remove a path.

4. ethernet
 uDEV
     not deal with it
 nameif
    name interface based on MAC,
 uSDE
    can set map based on MAC, SLOT.
    support both setting manually map and automatic processing
    support hotplug, eg. when exchange two device, the name can also be
    exchanged automatically.
  .
5.devfs simulation
  uDEV
    No such function
  uSDE
     provide devfs simulation method.

>From the above comparsion, we can see uSDE really have some advantages.As
far maintaince,
I think that more codes don't mean lacking maintainability.

Thanks
Guo Min

> -----Original Message-----
> From: linux-hotplug-devel-admin@lists.sourceforge.net
> [mailto:linux-hotplug-devel-admin@lists.sourceforge.net]On
> Behalf Of Greg KH
> Sent: Wednesday, October 29, 2003 6:44 AM
> To: Steven Dake
> Cc: Lars Marowsky-Bree; Mark Bellon;
> linux-raid@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-hotplug-devel@lists.sourceforge.net
> Subject: Re: ANNOUNCE: User-space System Device Enumation (uSDE)
>
>
> On Tue, Oct 28, 2003 at 11:12:07AM -0700, Steven Dake wrote:
> > On Tue, 2003-10-28 at 04:00, Lars Marowsky-Bree wrote:
> > > On 2003-10-27T14:14:18,
> > >    Mark Bellon <mbellon@mvista.com> said:
> > >
> > > > The uSDE and udev are simlar in some respects. The uSDE
> allows for
> > > > complete control of the policy handling a device - not
> just its naming.
> > >
> > > Well, so could udev in theory, and I had this plan to
> enhance it to do
> > > so for the specific case of multipathing one day in the
> not too distant
> > > future (ie, before q1/04).
> > >
> > > In as far as I can see, udev and uSDE really do not have
> too different
> > > goals. Competition is good, but only if they explore
> distinct approaches
> > > ;-)
> > >
> > There are several distinct approaches which have been enumerated in
> > other mails.
> >
> > Since this point has not been addressed, I'd like to focus
> on the major
> > difference in philosophy.
> >
> > SDE places all policy in the hands of the policy developer
> in a seperate
> > policy program.  udev places the policies in the main
> processing loop of
> > the system, effectively implementing whatever policy is
> desired by the
> > udev maintainers.
>
> What do you mean by "policy"?
>
> If you are saying that SDE allows programmers the ability to write new
> programs to plug into your framework to create new types of policies,
> then I understand that.  Your loadable plugins look like they support
> that.  But they require a dynamic loader :)
>
> What udev is doing is trying to provide a flexible policy
> that will work
> for everyone, with a heirchy of rules that can be easily
> controlled and
> changed by anyone who can operate a text editor (and soon to
> be changed
> by GUI applications, like the HAL project).
>
> I have not heard of any situation in which the current udev
> set of rules
> do not work out for them.  And if you can think of one, can't it be
> covered by the CALLOUT rule?  For example, someone has sent me a small
> userspace program that works with the CALLOUT rule that handles
> multipath devices by talking to the dm code.  Now that's pretty
> flexible.
>
> If you (or anyone else) thinks of something that the existing
> udev rules
> do not handle, please let me know.  If it's too complex, then yes, the
> user should use write their own SDE plugin.  But remember,
> 99.9% of the
> people out there just want the LSB device names, with possibly a
> persistent entry for their digital camera and USB joystick, which udev
> handles just fine today.
>
> For people with 4000 real scsi disks, udev also works well.
> That seems
> to cover the wide range of users.
>
> > Without seperating policies from the core executive of device naming
> > system, the core of udev suffers from the same issues as
> placing policy
> > in the kernel suffers.   Lack of maintainability, lack of
> user-defined
> > functionality, bloat, etc.
>
> Easy Separation?  Hm, in looking at udev, if you just replace
> 2 .c files
> with your new naming scheme, everything works just fine.
>
> And if you want to go down the path of accusations about lack of
> maintainability, bloat, etc. I will be glad to point people
> at your tree
> and then they can see these kinds of numbers:
>
> For SDE:
> $ find . -type f | egrep '[.c|.h]$' | xargs wc -l | tail -1
>   57328 total
>
> Wow, you build 18 shared libraries:
> $ find . -type f | grep '\.so' | wc
>      18      18     625
>
> For udev:
> $ find . -type f | egrep '[.c|.h]$' | xargs wc -l | tail -1
>   17632 total
>
> And that includes all of klibc, which really is not fair for udev to
> calculate.  So let's just look at the udev code size:
> $ ls | egrep '[.c|.h]$' | xargs wc -l | tail -1
>    2613 total
>
> And to be complete, let's add the totals of libsysfs and tdb,
> but to be
> fair any udev developer never has to look into those files:
>
> libsysfs is this big:
>    3798 total
>
> And tdb is this big:
>    2679 total
>
> So adding those numbers up we get these kinds of numbers for
> size of the
> .c and .h files in the different projects:
>     SDE:  57328 lines
>     udev:  9090 lines
>
> That makes SDE over 6 times bigger in source code alone than all of
> udev (including tdb and libsysfs).
>
> I can compare executable size too, if you really want to still claim
> that udev is suffering from "lack of maintainability and bloat" if you
> really want :)
>
> Oh, any reason you all haven't shown a working uSDE system in public
> anywhere?
>
> thanks,
>
> greg k-h
>
> p.s. yes, I know lines of code is a horrible metric, and
> doesn't really
> mean squat.  I just want to point out the huge size difference between
> the current state of udev and SDE, with pretty much identical
> functionality from what I can tell.
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?   SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Linux-hotplug-devel mailing list  http://linux-hotplug.sourceforge.net
> Linux-hotplug-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-hotplug-devel
>

_______________________________________________
cgl_discussion mailing list
cgl_discussion@lists.osdl.org
 http://lists.osdl.org/mailman/listinfo/cgl_discussion




