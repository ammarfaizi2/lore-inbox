Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317616AbSGOUJ3>; Mon, 15 Jul 2002 16:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317620AbSGOUJ3>; Mon, 15 Jul 2002 16:09:29 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:22210 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S317616AbSGOUJ1> convert rfc822-to-8bit; Mon, 15 Jul 2002 16:09:27 -0400
Date: Mon, 15 Jul 2002 13:12:22 -0700 (PDT)
From: Jauder Ho <jauderho@carumba.com>
X-X-Sender: jauderho@twinlark.arctic.org
To: Nick Bellinger <nickb@attheoffice.org>
cc: Buddy Lumpkin <b.lumpkin@attbi.com>, <linux-kernel@vger.kernel.org>
Subject: RE: IDE/ATAPI in 2.5
In-Reply-To: <1026757651.9529.36.camel@subjeKt>
Message-ID: <Pine.LNX.4.44.0207151305540.28451-100000@twinlark.arctic.org>
X-Mailer: UW Pine 4.44 + a bunch of schtuff
X-There-Is-No-Hidden-Message-In-This-Email: There are no tyops either
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I would disagree here. NAS _does_ in fact typically refer to storage that
is network attached and acessed via some form of network filesystem i.e.
NFS and friends. Typically, this is billed as just plugging more storage
into the network.

See http://www.quantum.com/Products/NAS+Servers/Default.htm for an
example. SearchStorage has a little blurb (which I think could use some
additional clarity)
http://whatis.techtarget.com/definition/0,289893,sid9_gci214410,00.html

SAN on the other hand typically requires a different HBA than that NIC you
use to access the network. Common access methods are via FiberChannel or
iSCSI. As of now SAN based storage also requires more effort, skill and
cost to provision. I would expect that to go down over time.

--jauder

On 15 Jul 2002, Nick Bellinger wrote:

>
>
> >I think someone is misunderstanding some industry buzz words here ...
> >NAS refers to Network Attached Storage, as in via NFS, AFS, et al.
> >What your showing in the output of the Solaris format command are
> >raw SCSI LUNS attached via fibre channel (fabric or loop) or native
> >scsi.
>
> Just as a matter of clarification, the above two examples NFS and AFS
> are most certainly NOT Network Attached Storage aka NAS.  The former is
> an simple Networked File System, and the latter the first practical
> distributed file system (ie: multiple client access to shares), but they
> both provide access to storage resources at the FILE SYSTEM level.
>
> The term 'NAS' (and SAN for that matter as the terms are pretty much
> used interchangeably these days) refer to moving raw disk protocol
> Command Descriptor Blocks aka CDBs and its associated data across the
> network at the BLOCK level.  But storage folks generically regard the
> terms as: NAS refers to BLOCK level storage over IP networks,  and SAN
> to BLOCK level storage over a Fibre Channel setup.
>
> The reason being a Storage Area Network is generally a closed, secure,
> and seperate entity from ones IP network,  while Network Attached
> Storage is storage added directly into an existing IP network.  Of
> course this opens up all of related security considerations when dealing
> with IP networks,  but a discussion of the related issues is beyond the
> scope of this reply, and dangerously off-topic.
>
>
> 		Nicholas 'trying to keep it real' Bellinger
>
>
> >>From venom@sns.it Mon Jul 15 11:11:59 2002
> >>On Sun, 14 Jul 2002, Rik van Riel wrote:
>
> >>> > BTW: did you ever look at Solaris / HP-UX, ... and the way they
> >>> > name disks?
> >>> >
> >>> > someting like: /dev/{r}dsk/c0t0d0s0
> >>> > This is SCSI bus, target, lun and slice.
> >>>
> >>> I wonder what they'll change it to in order to support
> >>> network attached storage.
> >>>
> >>Actually notthing:
>
> >>dbtecnocasa:{root}:/>format
> >>Searching for disks...done
>
> >>c2t1d0: configured with capacity of 6.56MB
> >>c2t1d30: configured with capacity of 34.04GB
> >>c2t1d31: configured with capacity of 34.04GB
> >>c2t1d81: configured with capacity of 34.04GB
>
>
> >>AVAILABLE DISK SELECTIONS:
> >>       0. c0t0d0 <SUN18G cyl 7506 alt 2 hd 19 sec 248>
> >>          /pci@1f,4000/scsi@3/sd@0,0
> >>       1. c2t1d0 <EMC-SYMMETRIX-5567 cyl 14 alt 2 hd 15 sec 64>
> >>          /pci@4,2000/scsi@1/sd@1,0
> >>       2. c2t1d30 <EMC-SYMMETRIX-5567 cyl 37178 alt 2 hd 30 sec 64>
> >>          /pci@4,2000/scsi@1/sd@1,1e
> >>       3. c2t1d31 <EMC-SYMMETRIX-5567 cyl 37178 alt 2 hd 30 sec 64>
> >>          /pci@4,2000/scsi@1/sd@1,1f
> >>       4. c2t1d81 <EMC-SYMMETRIX-5567 cyl 37178 alt 2 hd 30 sec 64>
> >>          /pci@4,2000/scsi@1/sd@1,51
>
> >>except of c0t0d0 everything else is network attached...
>
>
> >How is it attached? Using FACL or ISCSI?
>
> >In any case, it seems to be a natural solution to do it this way.
>
> >In order to access a network disk, you need to obtain the right to
> >do so first. Once this has been done, the netork subsystem just looks
> >like a new SCSI bus.
>
> >Jörg
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

