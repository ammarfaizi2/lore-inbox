Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262209AbTCPDPJ>; Sat, 15 Mar 2003 22:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262242AbTCPDPI>; Sat, 15 Mar 2003 22:15:08 -0500
Received: from franka.aracnet.com ([216.99.193.44]:56549 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262209AbTCPDPH>; Sat, 15 Mar 2003 22:15:07 -0500
Date: Sat, 15 Mar 2003 19:22:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       James Bottomley <James.Bottomley@SteelEye.com>
cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] NUMAQ subarchification
Message-ID: <6720000.1047784959@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0303152036250.27065-100000@chaos.physics.uiowa.edu>
References: <Pine.LNX.4.44.0303152036250.27065-100000@chaos.physics.uiowa.edu>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It is the place designed for code belonging only to one subarch.
>> 
>> > Last time I looked (and I don't think anyone has fixed it since) 
>> > it requires copying files all over the place, making an unmaintainable
>> > nightmare. Either subarch needs fixing first, or we don't use it.
> 
> I agree that duplicating files into different subarch dirs sure isn't the 
> way to go.
> 
>> The problem you have (your setup.c and topology.c are identical to the
>> default) was originally going to be solved using VPATH.  Unfortunately,
>> that got broken along the way in the new build scheme, so the best I
>> think you can do is add this to the summit Makefile
> 
> I think VPATH has never been meant to be used for anything like this, it 
> could be make to work, though it would interfere with the separate src/obj 
> thing. But I don't think it's a good idea, we'll have object files 
> magically appear without any visible source file, that's just too obscure.
> 
> I can basically see two options at this point:
> 
>> $(obj)/setup.c: $(src)/../mach-default/setup.c
>> 	cat $< $@
> 
> Something like this, but using ln -sf would be nicer, since that avoids 
> someone editing the wrong file by mistake.

GNU diff doesn't seem to understand soft links, so I don't think that's
feasible unfortunately. The ../mach-default stuff still requires you to
edit each subarch's makefile when adding a file to any subarch, which is
a pain in the butt, but better than the duplicated files by a long way.

Another comprimise solution for now might be to leave the Makefile entries
with ifdefs in the main Makefile (just as we do without subarch), but just
move the subarch files into the subarch dirs ... at least until we get a 
better plan sorted out? That'll mean much less reshuffling when it's fixed.

M.


