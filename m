Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318516AbSGaWob>; Wed, 31 Jul 2002 18:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318518AbSGaWob>; Wed, 31 Jul 2002 18:44:31 -0400
Received: from [143.166.83.91] ([143.166.83.91]:59142 "HELO
	AUSADMMSRR504.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S318516AbSGaWoa>; Wed, 31 Jul 2002 18:44:30 -0400
X-Server-Uuid: 5b9b39fe-7ea5-4ce3-be8e-d57fc0776f39
Message-ID: <F44891A593A6DE4B99FDCB7CC537BBBBB839AC@AUSXMPS308.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: peter@chubb.wattle.id.au, pavel@ucw.cz
cc: viro@math.psu.edu, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: RE: 2.5.28 and partitions
Date: Wed, 31 Jul 2002 17:47:49 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 1156B692338714-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter.  Thanks for your work on LBD for 2.5.x.  I'm really looking
forward to its inclusion.

> What we really need to be able to do, however, is partition these huge
> discs, if only so that each partition is less than a reasonable number
> of backup tapes/devices/whatever.  And at present the only scheme that
> Linux understands for partitioning huge discs is the EFI GUID scheme.

:-)
 
> Maybe we need to roll our own?

What's wrong with EFI GUID scheme (GPT) (other than it wasn't invented by
Linux folks)?

the 2.5.x kernel understands it today
the 2.4.x kernel could very easily understand it (patch available on
http://domsch.com/linux/patches/gpt against 2.4.19-rc1), and ia64 has had it
for a couple years.
partx understands it today
parted understands it today
(efibootmgr and the EFI environment understand it today, but that's only
relevant to IA-64 at the moment)


> Maybe we need to roll our own?  I suggest something like:
>       struct linux_volume_header {
> 	     char  volname[16];
> 	     __u32 nparts;
> 	     __u32 blocksize;

The disk can tell you its blocksize.  The FS will have its own idea anyhow.

> 	     struct linux_partition {
> 		    char partname[16]
> 		    __u64  start;
> 		    __u64  len;
> 		    __u32  usage;
> 		    __u32  flags;
> 	    } parts[]
>     }
> 
> the whole to fit into a 4k block at the start of the volume, with a
> crc32 at the end.
> 
> Usage to be a magic number that says this is a swap, spare,
> whole-disc, filesystem+type, whatever, partition.
> 
> flags for whatever we want.

All of this is already done in GPT today, or could be if desired (spare,
etc).  Tagging the FS type inside the partition table isn't pretty, and has
lead to the huge table of partition type numbers that Andries maintains,
when fs probing isn't hard.

> I can't see anyone booting from a huge array in the near-term future,
> because you need the BIOS to understand the array.

Sure, so we don't have to fix grub or lilo to understand GPT yet.  :-)

Unless there's something that GPT doesn't do well, I'd prefer not to make
yet another partitioning scheme.  If there is something else it needs, it
can be extended.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)

