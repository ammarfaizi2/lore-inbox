Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316677AbSHAXKE>; Thu, 1 Aug 2002 19:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317314AbSHAXKE>; Thu, 1 Aug 2002 19:10:04 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:38916 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S316677AbSHAXKE>;
	Thu, 1 Aug 2002 19:10:04 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alexander Viro <viro@math.psu.edu>
Date: Fri, 2 Aug 2002 01:13:09 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: IDE from current bk tree, UDMA and two channels...
CC: martin@dalecki.de, linux-kernel@vger.kernel.org, mingo@elte.hu
X-mailer: Pegasus Mail v3.50
Message-ID: <CF6774723C@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  1 Aug 02 at 19:05, Alexander Viro wrote:
> 
> On Fri, 2 Aug 2002, Petr Vandrovec wrote:
>  
> > Normal DOS partition, with 512 byte block size, as this is 512B block
> > device, at least I believed to it until now. As start=63, it apparently
> > also handles 1024B requests on odd address (I believe that sfdisk -d dumps
> > start 0-based).
> > 
> > # partition table of /dev/hdc
> > unit: sectors
> > 
> > /dev/hdc1 : start=       63, size=12685617, Id=83, bootable
> 
> Blacklist time.  That, or decrementing size to 12675616, depending on whether
> you want that last half-Kb or not.

Last half-KB is useless, as filesystem on it is ext2 with 4KB blocks... 
Only problem is that previously stable system was now dying in e2fsck. I'll 
try to invent some solution before 2.6 ;-) 

Maybe fix to e2fsck would be sufficient, I always thought that it reads disk 
in blocksize (4KB) chunks, so disk will not see 512B request. But
apparently it either reads partition in 512B chunks, or block layer does not
do merging correctly.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
