Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbSKTXlt>; Wed, 20 Nov 2002 18:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263899AbSKTXlt>; Wed, 20 Nov 2002 18:41:49 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:1446 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S263794AbSKTXlr>; Wed, 20 Nov 2002 18:41:47 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Steven Dake <sdake@mvista.com>
Date: Thu, 21 Nov 2002 10:48:47 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15836.8031.649441.843857@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
In-Reply-To: message from Steven Dake on Wednesday November 20
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>
	<3DDBC0D9.5030904@mvista.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 20, sdake@mvista.com wrote:
> Neil,
> 
> I would suggest adding a 64 bit field called "unique_identifier" to the 
> per-device structure.  This would allow a RAID volume to be locked to a 
> specific host, allowing the ability for true multihost operation.

You seem to want a uniq id in 'per device' which will identify the
'volume'.
That doesn't make sense to me so maybe I am missing something.
If you want to identify the 'volume', you put some sort of id in the
'per-volume' data structure.

This is what the 'name' field is for.

> 
> For FibreChannel, we have a patch which places the host's FC WWN into 
> the superblock structure, and only allows importing an array disk (via 
> ioctl or autostart) if the superblock's WWN matches the target dev_t's 
> host fibrechannel WWN.  We also use this for environments where slots 
> are used to house either CPU or disks and lock a RAID array to a 
> specific cpu slot.  WWNs are 64 bit, which is why I suggest such a large 
> bitsize for this field.  This really helps in hotswap environments where 
> a CPU blade is replaced and should use the same disk, but the disk 
> naming may have changed between reboots.
> 
> This could be done without this field, but then the RAID arrays could be 
> started unintentionally by the wrong host.  Imagine a host starting the 
> wrong RAID array while it has been already started by some other party 
> (forcing a rebuild) ugh!

Put your 64 bit WWN in the 'name' field, and teach user-space to match
'name' to FC adapter.

Does that work for you?

NeilBrown
