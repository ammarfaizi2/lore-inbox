Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbUCVTQQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 14:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbUCVTQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 14:16:16 -0500
Received: from pop.gmx.de ([213.165.64.20]:8933 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262271AbUCVTQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 14:16:12 -0500
X-Authenticated: #21910825
Message-ID: <405F3B1C.3030500@gmx.net>
Date: Mon, 22 Mar 2004 20:14:36 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
CC: Arjan van de Ven <arjanv@redhat.com>,
       "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Device mapper devel list <dm-devel@redhat.com>,
       Thomas Horsten <thomas@horsten.com>, medley@lists.infowares.com
Subject: Re: ATARAID/FakeRAID/HPTRAID/PDCRAID as dm targets?
References: <405C8B39.8080609@gmx.net> <405CAEC7.9080104@pobox.com> <405CFC85.70004@backtobasicsmgmt.com> <20040321074711.GA13232@devserv.devel.redhat.com> <405D9CDA.6070107@gmx.at>
In-Reply-To: <405D9CDA.6070107@gmx.at>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wilfried Weissmann wrote:
> Arjan van de Ven wrote:
> 
>> On Sat, Mar 20, 2004 at 07:23:01PM -0700, Kevin P. Fleming wrote:
>>
>>> Jeff Garzik wrote:
>>>
>>>
>>>> So go ahead, and I'll lend you as much help as I can.  I have the
>>>> full Promise RAID docs, and it seems like another guy on the lists
>>>> has full Silicon Image "medley" RAID docs...

Jeff: May I request your docs?


> I am the only one without docs? Oh, Crap!
> 
>>>
>>> If these "soft" RAID implementations only support RAID-0/1/0+1/1+0,
>>> is there really any need for a new DM target? Wouldn't you just need
>>> a userspace tool to recognize the array and do the "dmsetup"
>>> operations to make it usable?
>>
>>
>>
>> the later.
> 
> 
> Why not join my evms-plugin work? This has 4 advantages over the
> "stand-alone binary" approach:

Well, I had something in mind which closely resembles the ataraid-detect
tool Thomas Horsten (Medley RAID) suggested.

http://lists.infowares.com/archive/medley/2004-February/000001.html

OK, I was even aiming for less: Write an ataraid-detect tool which outputs
the correct mapping for dmsetup. If I manage to write it generically
enough, it can be integrated into evms or used as a standalone program,
whatever you like.


> 1. its all within evms
> There is no need for additional tools required to setup the volume
> (thinking about installers and initrd...).

The EVMS sample initrd is HUGE. (2.1 MB) I'm aiming for a initrd size of
less than 1/10 of that.


> 2. evms comes with partition handling.
> Otherwise someone has to write another tool/library that does the
> partition setup.

Well, kpartx is already written.


> 3. it works for 2.6 and (patched) 2.4 kernels

Can't dispute that.


> 4. nice clickety-click user interface
> Especially useful for lazy people like me. ;)

I prefer the "no user interface" approach. But then again, I'm biased.


> My plugin has to be a bit redesigned to allow easier integration of
> support code for other controllers. What is required is basically to
> split the plugin in a common and a per-controller module. No big deal.
> Or we can make a new plugin for every controller...
> 
> see: http://marc.theaimsgroup.com/?l=evms-devel&m=107936928618685&w=2

I downloaded the code and am playing with it right now.


> Apropos: If we do evms plugins then we might want to have the
> possibility to detect if some ataraid module aleady has picked up the
> disk. In this case we should not create a volume because of someone
> might try to mount the same volume via the ataraid and evms devicefiles
> which leads to filesystem corruption. I thought about makeing a /proc
> ataraid entry that contains the claimed disks. I think this should be
> supported by all ataraid modules if this is done so I am asking you:

That's one of the problems that made me look for a 2.6-only solution. This
way, you won't get the problems described above.


> What do you think?

I'll use your work as a foundation. First step is integrating detection
for non-HPT arrays. If the code looks too messy after that, I still can
refactor it.

As soon as I have some code to get at least PDCRAID working, I'll post again.


Regards,
Carl-Daniel

