Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267603AbSKQV0G>; Sun, 17 Nov 2002 16:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267605AbSKQV0G>; Sun, 17 Nov 2002 16:26:06 -0500
Received: from marcie.netcarrier.net ([216.178.72.21]:3851 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S267603AbSKQV0F>; Sun, 17 Nov 2002 16:26:05 -0500
Message-ID: <3DD80C9B.42A8AD73@compuserve.com>
Date: Sun, 17 Nov 2002 16:39:39 -0500
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: QM_MODULES, bk current initrd problems?
References: <3DD7C050.759F7973@compuserve.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Brosius wrote:
> 
> So I worked through bk current again this morning, needing most of
> Arnaldo Carvalho de Melo fixes to compile (see example at
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103753350710937&w=2),
> then grabbed Rusty's new modutils(
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103741153016225&w=2),
> because initrd couldn't load modules with "insmod: QM_MODULES: "
> notices.  However, I still cannot load modules even with Rusty's
> modutils installed.  Is there anything else required?  I'm only trying
> to load DAC960, reiserfs, and aix7xxx from initrd, none of which loads.
> (DAC960 is the updated version from DMO, at
> http://www.osdl.org/archive/dmo/)
> 

This is partly my fault (although I'll share the blame with Rusty and
SuSE equally.)

On SuSE 8.1, insmod is installed twice, once as /sbin/insmod and also as
/sbin/insmod.static.  The static version is used for building rd images
for initrd.  Rusty's package doesn't build a static version, so until I
looked into this, it was still the old insmod.static without the
module-init changes.

I made an attempt to work around this, both by forcing the SuSE mkinitrd
script to include libc and by building a static version of Rusty's
insmod.  However, the kernel still will not boot, although the problem
changes to 'no such file or dir' during the module load attempt.  I'm no
expert on initrd, so am not sure why this is a problem at this point.

-- 
Kevin
