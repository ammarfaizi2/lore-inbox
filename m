Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbSLKMah>; Wed, 11 Dec 2002 07:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266979AbSLKMah>; Wed, 11 Dec 2002 07:30:37 -0500
Received: from hicks.adgrafix.com ([64.55.193.2]:59567 "EHLO
	hicks.adgrafix.com") by vger.kernel.org with ESMTP
	id <S266977AbSLKMag>; Wed, 11 Dec 2002 07:30:36 -0500
Message-ID: <3DF731C5.2040107@tungstengraphics.com>
Date: Wed, 11 Dec 2002 12:38:29 +0000
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Nicolas ASPERT <Nicolas.Aspert@epfl.ch>,
       Margit Schubert-While <margitsw@t-online.de>,
       linux-kernel@vger.kernel.org, faith@redhat.com,
       dri-devel@lists.sourceforge.net
Subject: Re: [Dri-devel] Re: 2.4.20 AGP for I845 wrong ?
References: <fa.jjk71mv.1kja10g@ifi.uio.no> <3DF72A91.5080804@epfl.ch> <20021211132059.C11689@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Wed, Dec 11, 2002 at 01:07:45PM +0100, Nicolas ASPERT wrote:
>  > IIRC, the 845G is a "new" version of the 830MP chipset (it had been
>  > added by Abraham vd Merwe & Graeme Fisher some months ago), but acts
>  > basically just as the 830MP. Therefore the entry is correct.... Or maybe
>  > if it gets confusing adding a comment would not hurt...
> 
> I'll check the chipset docs when I get time, and add a comment if
> necessary. No-one seems to be complaining that it isn't working,
> so I'm inclined to believe your diagnosis is correct.
> 
>  > > Also in drivers/char/drm/drm_agpsupport.h, the switch statement at 262 
>  > > is missing the
>  > > cases for INTEL_I830_M, INTEL_I845_G.
>  > That's true. It is also missing in 2.5.51.
>  > I attach two patches, one for 2.4.21-pre1 and one for 2.5.51 that should 
>  > fix this.
>  > diff -ru linux-2.5.51.clean/drivers/char/drm/drm_agpsupport.h linux-2.5.51/drivers/char/drm/drm_agpsupport.h
>  > --- linux-2.5.51.clean/drivers/char/drm/drm_agpsupport.h	Tue Dec 10 03:45:39 2002
>  > +++ linux-2.5.51/drivers/char/drm/drm_agpsupport.h	Wed Dec 11 12:55:08 2002
>  > @@ -271,10 +271,12 @@
>  >  #if LINUX_VERSION_CODE >= 0x02040f /* KERNEL_VERSION(2,4,15) */
>  >  	 	case INTEL_I820:	head->chipset = "Intel i820";	 break;
>  >  #endif
>  > +		case INTEL_I830_M:	head->chipset = "Intel i830M";	 break;
>  >  		case INTEL_I840:	head->chipset = "Intel i840";    break;
>  >  #if LINUX_VERSION_CODE >= 0x02040f /* KERNEL_VERSION(2,4,15) */
>  >  		case INTEL_I845:	head->chipset = "Intel i845";    break;
>  >  #endif
>  > +		case INTEL_I845:	head->chipset = "Intel i845G";	 break;
>  >  		case INTEL_I850:	head->chipset = "Intel i850";	 break;
>  >  		case INTEL_460GX:	head->chipset = "Intel 460GX";	 break;
> 
> DRI folks, this seems like duplication given that this data is available
> in agpgart. How about changing this to read whatever agpgart has set in
> .chipset_name ?
> 
> Keeping these two lists in sync seems somewhat pointless.

Yes, it's not even clear what particular use the string is.  It looks like 
it's just for the print statement at the bottom of the switch.  It would be 
safe to remove the whole thing -- agpgart has already printed out what 
hardware *it's* dealing with.

Keith



