Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267812AbRHARvW>; Wed, 1 Aug 2001 13:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267821AbRHARvM>; Wed, 1 Aug 2001 13:51:12 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:38707 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S267812AbRHARvB>; Wed, 1 Aug 2001 13:51:01 -0400
From: sduchene@mindspring.com
Date: Wed, 1 Aug 2001 13:51:04 -0400
To: linux-kernel@vger.kernel.org
Subject: Patch for Riva framebuffer driver
Message-ID: <20010801135104.J10061@lapsony.mydomain.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent the following E-mail to Ani Joshi but have never received a reply from him so I thought
I would forward this info onto the linux-kernel list so this fix for a repeatable kernel Oops
could be incorperated in future kernels.

----- Forwarded message from valsad -----

From: valsad
Date: Sun, 15 Jul 2001 22:25:19 -0400
To: Ani Joshi <ajoshi@shell.unixbox.com>
Subject: Patch for Riva framebuffer driver
User-Agent: Mutt/1.3.5i

Ani:
I'm not sure if you are the current maintainer of the Riva framebuffer
driver however you are listed in the drivers/video/riva/fbdev.c file
as the author. I have discovered a small problem with the code in the
fbdev.c file that causes a kernel oops everytime. 

I was informed that the Riva 128 chip does not really support 16bpp and
that I should be using 15 bpp instead however when I configure my video
line in the lilo.conf file as follows:

  append="video=riva:1280x1024-15@74"

I got an kernel oops and an assertion failed message from line 1120 in
fbdev.c 

By adding the following code to fbdev.c everything works just fine now.

*** linux/drivers/video/riva/fbdev.c    Mon Jul 16 01:17:39 2001
--- linux_sad/drivers/video/riva/fbdev.c        Mon Jul 16 01:17:12 2001
***************
*** 1107,1112 ****
--- 1107,1115 ----
                break;
  #endif
  #ifdef FBCON_HAS_CFB16
+       case 15:
+               rc = 15;        /* fix for 15 bpp depths on Riva 128 based cards */
+               break;          
        case 16:
                rc = 16;        /* directcolor... 16 entries SW palette */
                break;          /* Mystique: truecolor, 16 entries SW palette, HW palette hardwired into 1:1 mapping */



BTW, the following is an exerpt from an E-mail conversation between myself and
Bakonyi Ferenc <fero@drama.obuda.kando.hu> regarding my problems with 16 bpp:

> > The fbset output on this system says:
> >
> > mode "1280x1024-74"
> >     # D: 135.007 MHz, H: 78.859 kHz, V: 74.116 Hz
> >     geometry 1280 1024 1280 1024 16
> >     timings 7407 256 32 34 3 144 3
> >     accel true
> >     rgba 5/11,6/5,5/0,0/0
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > endmode
>
> This line indicates you are using rivafb in 16 bpp mode. Unfortunetly
> 16 bpp is not supported by Riva 128 hw. It's a bug, in a perfect
> world rivafb should disable 16 bpp mode on Riva 128. In this case
> hardware is set to 15 bpp, but rivafb thinks it's set to 16 bpp. (Or
> something similar.)

----- End forwarded message -----

Also after implementing this change fbset now reports:

mode "1280x1024-74"
    # D: 135.007 MHz, H: 78.859 kHz, V: 74.116 Hz
    geometry 1280 1024 1280 1024 16
    timings 7407 256 32 34 3 144 3
    accel true
    rgba 5/10,5/5,5/0,0/0
endmode

-- 
Steven A. DuChene	sad@ale.org
			linux-clusters@mindspring.com
			sduchene@mindspring.com

	http://www.mindspring.com/~sduchene/
