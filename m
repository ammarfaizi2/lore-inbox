Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266310AbUHMRsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266310AbUHMRsi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 13:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUHMRqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 13:46:05 -0400
Received: from mail6.centrum.cz ([213.29.7.198]:20689 "EHLO mail6.centrum.cz")
	by vger.kernel.org with ESMTP id S266310AbUHMRpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 13:45:32 -0400
Date: Fri, 13 Aug 2004 16:36:09 +0200
From: "Jakub Vana" <gugux@centrum.cz>
To: <vojtech@suse.cz>, <gugux@centrum.cz>
Cc: <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
X-Mailer: Centrum Mail 1.0
MIME-Version: 1.0
X-Priority: 3
Subject: Re: x86 - Realmode BIOS and Code calling module
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
Message-Id: <20040813143618Z2102821-29041+51849@mail.centrum.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

______________________________________________________________
> Od: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Komu: Jakub Vana <gugux@centrum.cz>
> CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Datum: Thu, 12 Aug 2004 21:30:54 +0100
> Pøedmìt: Re: x86 - Realmode BIOS and Code calling module
>
> On Iau, 2004-08-12 at 14:38, Jakub Vana wrote:
> > > Why is this better than LRMI in user mode.
> > 
> > I was now looking on LRMI. It must be a nice code, but It is still only
> >  V86 emulation. I have listen that some BIOSes use something called 
> > Unreal mode, that is realmode with segment registers used like in 
> > protected mode. There is only one way, how to set this segregs - 
> > switch to prot. mode, but if the BIOS try to switch when is running 
> > in V86 CPU generates #GP (Global Protection fault). Not if it is 
> > running in real Real Mode.
> 
> I've yet to meet a video bios that does this. I don't think the X folks
> have either, but you could run it past Egbert to make sure. The 
> "unreal" mode is normally only in existance during early boot.



I got knowledge (or how is it well English?) that for video is it unusable, but I thing there are many other problems which can be solved by this module. Maybe it is not neaded for common hardware but there can be special hardware for special usage with drivers in it's BIOSes and there can by problems to write Linux Kernel driver for low documentation or a little money. It doesn't pay off to write all the driver for one or sixteen pieces of HW. 
It is better to be it module in kernel so the driver(that uses BIOS) can be in kernel too and can provide standard services.



> > > To do BIOS calls safely
> > > you need to be very careful about things like PCI locking, I/O 
> > > emulation and the ROM scribbling 
> > 
> > I'm not sure abou this, but I think there is not problem in calling 
> > BIOS, here is problem in BIOS handling with this features and so 
> > It's the problem of programmer that calls the BIOS to safely work
> > and synchronize his hardware in kernel with BIOS. Other hardware 
> > (that is not pawn by BIOS) can't make problems.
> 
> One example is PCI configuration accesses which must be co-ordinated
> with the kernel, and through the kernel PCI interfaces. 
> 



But when running in LRMI there are same problems, aren't ?




______________________________________________________________
> Od: Vojtech Pavlik <vojtech@suse.cz>
> Komu: Jakub Vana <gugux@centrum.cz>
> CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
> Datum: Fri, 13 Aug 2004 09:44:57 +0200
> Pøedmìt: Re: x86 - Realmode BIOS and Code calling module
>
> On Thu, Aug 12, 2004 at 03:38:45PM +0200, Jakub Vana wrote:
> 
> > > Why is this better than LRMI in user mode.
> > 
> > I was now looking on LRMI. It must be a nice code, but It is still
> > only V86 emulation. I have listen that some BIOSes use something
> > called Unreal mode, that is realmode with segment registers used like
> > in protected mode. There is only one way, how to set this segregs -
> > switch to prot. mode, but if the BIOS try to switch when is running in
> > V86 CPU generates #GP (Global Protection fault). Not if it is running
> > in real Real Mode.
> 
> Well, if it's running an emulated CPU (x86emu), there are no problems
> with that. Even the unreal mode could be emulated, although I have yet
> to see a BIOS which uses that to handle an INT call.



When I tried to write my own kernel I hadn't time to write disk I/O so I temporarily used the DOS that I was writing it on. I used to call it as V86 task. It worked well on my one computer, but on other it failed by #GP. Because the DOS is all realmode (I used pure DOS - not smartdrv) It must be the BIOS that make the kernel failed. I'm almost sure it was because using protected mode(maybe like unreal mode), but It's not important what was the instruction. Important is that the instruction used to generate #GP. I know that this is not operation that can be module used for, but it shows that problem can be here.



> -- 
> Vojtech Pavlik
> SuSE Labs, SuSE CR
> 


Jakub Vana

--------------------
Pøipravte se! Je tu ¹kola. Nav¹tivte vèas Palác Flóra. Od 20.srpna do 5.záøí probíhá v Paláci Flóra speciální trh ¹kolních potøeb. http://user.centrum.cz/redir.php?url=http://www.palacflora.com



