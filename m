Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbUCWVEP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 16:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbUCWVEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 16:04:14 -0500
Received: from mail.gmx.de ([213.165.64.20]:40586 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262840AbUCWVDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 16:03:23 -0500
X-Authenticated: #7370606
Message-ID: <4060A60E.7050109@gmx.at>
Date: Tue, 23 Mar 2004 22:03:10 +0100
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
CC: Arjan van de Ven <arjanv@redhat.com>,
       "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Device mapper devel list <dm-devel@redhat.com>,
       Thomas Horsten <thomas@horsten.com>, medley@lists.infowares.com
Subject: Re: ATARAID/FakeRAID/HPTRAID/PDCRAID as dm targets?
References: <405C8B39.8080609@gmx.net> <405CAEC7.9080104@pobox.com> <405CFC85.70004@backtobasicsmgmt.com> <20040321074711.GA13232@devserv.devel.redhat.com> <405D9CDA.6070107@gmx.at> <405F3B1C.3030500@gmx.net>
In-Reply-To: <405F3B1C.3030500@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:
> Wilfried Weissmann wrote:
>>Why not join my evms-plugin work? This has 4 advantages over the
>>"stand-alone binary" approach:
> 
> 
> Well, I had something in mind which closely resembles the ataraid-detect
> tool Thomas Horsten (Medley RAID) suggested.
> 
> http://lists.infowares.com/archive/medley/2004-February/000001.html
> 
> OK, I was even aiming for less: Write an ataraid-detect tool which outputs
> the correct mapping for dmsetup. If I manage to write it generically
> enough, it can be integrated into evms or used as a standalone program,
> whatever you like.

Oh, well. My intention was to prevent that there is a set of new tools 
but instead to integrate what is required into an existing framework. 
And also to benefit from the system, like using the partition support 
that was already present in EVMS. Particulary this was the key factor in 
my decision for EVMS. Right now we have 3 places where partition 
(detection) code is located. Its in the kernel, its in EVMS and now 
there is also kpartx. Each implementation has its own features and 
goodies, but the problem is that they also have their own bugs. There is 
a wide set of partition types one wants to implement. So we end up in a 
point where we have dependencies on hardware and partition types. Like 
if you have hardware X you cannot use LDM and Solaris Slices but you can 
have BSD Disk Slices.

> 
> 
> 
>>1. its all within evms
>>There is no need for additional tools required to setup the volume
>>(thinking about installers and initrd...).
> 
> 
> The EVMS sample initrd is HUGE. (2.1 MB) I'm aiming for a initrd size of
> less than 1/10 of that.

On the other hand this is not a big deal unless you do have embedded 
systems with tight hardware constraints. You can also strip evms a lot 
by removing unnecessary plugins. Installers can also have EVMS only on 
the installation media (unless your install source is on the RAID).

> 
> 
> 
>>2. evms comes with partition handling.
>>Otherwise someone has to write another tool/library that does the
>>partition setup.
> 
> 
> Well, kpartx is already written.

Right, but like I have already written above, I do not understand why 
one should not reuse existing code and therefor preventing code duplication.

> 
> 
> 
>>3. it works for 2.6 and (patched) 2.4 kernels
> 
> 
> Can't dispute that.

Support in both kernels enables one to make a smooth migration.

> 
> 
> 
>>4. nice clickety-click user interface
>>Especially useful for lazy people like me. ;)
> 
> 
> I prefer the "no user interface" approach. But then again, I'm biased.

Well, I have to admit that I am also biased. You can still use the 
command line evms binary for scripting of course.

[snip]

>>Apropos: If we do evms plugins then we might want to have the
>>possibility to detect if some ataraid module aleady has picked up the
>>disk. In this case we should not create a volume because of someone
>>might try to mount the same volume via the ataraid and evms devicefiles
>>which leads to filesystem corruption. I thought about makeing a /proc
>>ataraid entry that contains the claimed disks. I think this should be
>>supported by all ataraid modules if this is done so I am asking you:
> 
> 
> That's one of the problems that made me look for a 2.6-only solution. This
> way, you won't get the problems described above.

Not all features and supported hardware of the current ataraid code are 
going to be available in a matter of days (at least for my part). Indeed 
I am wondering if it might be desirable to use both implementations at a 
time during migration. This is why I was thinking about adding a config 
options that protects you from destroying data by error.

Regards,
Wilfried
