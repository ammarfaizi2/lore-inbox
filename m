Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281593AbRKZLrU>; Mon, 26 Nov 2001 06:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281614AbRKZLrK>; Mon, 26 Nov 2001 06:47:10 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:24594 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S281593AbRKZLrC>;
	Mon, 26 Nov 2001 06:47:02 -0500
Message-ID: <3C022BB4.7080707@epfl.ch>
Date: Mon, 26 Nov 2001 12:47:00 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Didier.Moens@dmb001.rug.ac.be, Robert Love <rml@tech9.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: Re: OOPS in agpgart (2.4.13, 2.4.15pre7)]
In-Reply-To: <linux.kernel.3C021570.4000603@dmb.rug.ac.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>                         if (i810_dev == NULL) {
>                                 printk(KERN_ERR PFX "agpgart: Detected an "
>                                        "Intel i815, but could not find the"
>                                        " secondary device. Assuming a "
>                                        "non-integrated video card.\n");
>                                 break;
> 
> 
> This leads me to believe the "secondary device"  could be the integrated
> graphics component on the i810/815.
> 
> As the i830M doesn't have one (the i830MG does), I suppose this could
> lead to the aforementioned error message, and hence failure of the
> agpgart modprobe ?
> 
> Could it be that one has to differentiate between i830MG (secondary
> device, and hence analoguous to i810/i815) and i830M (no secondary
> device, and possibly analoguous to i830/i840/i845/... : no check for 2nd
> device needed ) ?
> 
> 
> Offcourse, I could be utterly wrong.
> 

Hello

It seems like you have pointed out the problem... From what you had sent 
previously (the output of 'lspci' on your machine), and what the Intel 
doc says, it looks to me like the code for i830 initialization is not 
correct for your version of the chipset. But I am not too sure of what 
is to be done in that case... should we switch back to a 'classic' AGP 
initialization, similar to the other i8xx chipsets (820/840/860...) ? 
Robert (or somebody else), any clue about this one ?
I'll try to figure out where the 'i830_configure' performs call on the 
secondary device...

Best regards
-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)

