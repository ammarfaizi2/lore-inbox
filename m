Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263012AbUKZVCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbUKZVCQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbUKZUqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:46:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:54999 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264113AbUKZUeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 15:34:10 -0500
X-Authenticated: #20450766
Date: Thu, 25 Nov 2004 23:46:28 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: LM Sensors <sensors@stimpy.netroedge.com>
cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [sensors] system slow since ~ 2.6.7
In-Reply-To: <20041125211941.27eac8f0.khali@linux-fr.org>
Message-ID: <Pine.LNX.4.60.0411252337400.1631@poirot.grange>
References: <Pine.LNX.4.60.0411180115490.941@poirot.grange>
 <1101186291.20008.247.camel@d845pe> <Pine.LNX.4.60.0411242139090.2319@poirot.grange>
 <20041125211941.27eac8f0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello and thanks for the help!

On Thu, 25 Nov 2004, Jean Delvare wrote:

> > This reminds me: about a year ago my CPU fan burnt down. Then too,
> > shortly after booting the PC, it slowed down. Then by accident I
> > noticed in BIOS CPU temperature 98 deg C. With a new fan problem
> > disappeared.
> 
> Wow, 98, no less. You're lucky it didn't catch on fire, you know.

Yep, I do:-) I read some hot reports about hot AMDs right after that 
adventure:-)

> There were some significant changes to the via686a driver in 2.6.6 and
> 2.6.7.
> 
> 2.6.6: Limit initialization was removed from the driver. The same was
> done for most other drivers. The limits have to be set by either the
> BIOS or user-space, not kernel drivers. Also, chip initialization is now
> less agressive (previous version would possibly arbitrarily overwrite
> BIOS settings).
> 
> 2.6.7: Conversion formulas were reworked for a better accuracy. Errors
> were previously introduced by incorrect rounding.
> 
> I think that the changes in 2.6.6 are the ones affecting you.

In the meantime I tried 2.6.5 - same behaviour as 2.6.7.

> > Yes, some coefficients are definitely wrong. Here are a
> > couple of snapshots:
> > 
> > via686a-isa-e200
> > Adapter: ISA adapter
> > CPU core:  +1.09 V  (min =  +2.00 V, max =  +2.50 V)   ALARM
> > +2.5V:     +1.16 V  (min =  +3.10 V, max =  +1.57 V)   ALARM
> > I/O:       +3.40 V  (min =  +4.13 V, max =  +4.13 V)   ALARM
> > +5V:       +5.55 V  (min =  +6.44 V, max =  +6.44 V)   ALARM
> > +12V:      +4.81 V  (min = +15.60 V, max = +15.60 V)   ALARM
> > CPU Fan:  5443 RPM  (min =    0 RPM, div = 2)          
> > P/S Fan:     0 RPM  (min =    0 RPM, div = 2)          
> > SYS Temp:  +45.4 C  (high =   +45 C, hyst =   +40 C)   ALARM
> > CPU Temp:  +34.5 C  (high =   +60 C, hyst =   +55 C)   
> > SBr Temp:  +28.4 C  (high =   +65 C, hyst =   +60 C)   
> 
> Blame your BIOS! It did not properly configure voltage limits, among
> others. BTW, Vcore, +2.5V and +12V look awfully wrong anyway. I/O and
> +5V are acceptable but even +5V is a bit too high IMHO. Never heard of
> your motherboard model before, seems to be a rare one. Maybe Asus didn't
> put much support on it. 

Well, don't know how rare it is - I did find it on the ASUS site.

> Notice the ALARM in SYS Temp, which is probably causing the system to
> throttle.

Yep. However, I saw ALARM without throttling sometimes too.

> > via686a-isa-e200
> > Adapter: ISA adapter
> > CPU core:  +1.09 V  (min =  +2.00 V, max =  +2.50 V)   ALARM
> > +2.5V:     +1.16 V  (min =  +3.10 V, max =  +1.57 V)   ALARM
> > I/O:       +3.40 V  (min =  +4.13 V, max =  +4.13 V)   ALARM
> > +5V:       +5.55 V  (min =  +6.44 V, max =  +6.44 V)   ALARM
> > +12V:      +4.81 V  (min = +15.60 V, max = +15.60 V)   ALARM
> > CPU Fan:  5487 RPM  (min =    0 RPM, div = 2)          
> > P/S Fan:     0 RPM  (min =    0 RPM, div = 2)          
> > SYS Temp:  +45.2 C  (high =   +91 C, hyst =   +40 C)   ALARM
> > CPU Temp:  +34.4 C  (high =   +60 C, hyst =   +55 C)   
> > SBr Temp:  +28.4 C  (high =   +65 C, hyst =   +60 C)   
> > 
> > Notice how SYS Temp high changed...
> 
> Did it change *on its own*?

Hm, at least, I certainly didn't do anything to change it.

> Weird. Note that 91 = 45 << 1 + 1. I wonder
> if it could be some kind of read error. Will the value change 

Sorry? Did you mean "will it change again after that?" Well, not sure any 
more, but, I think, it did.

> > Can my guesses be correct and how can the situation be fixed?
> 
> Pick the latest default configuration file for sensors here:
> http://www2.lm-sensors.nu/%7Elm78/cvs/lm_sensors2/etc/sensors.conf.eg
> Save as /etc/sensors.conf, edit the via686a-* section, especially the
> "set temp1_high" and set temp1_hyst" values. I'd suggest:
> 
>     set temp1_hyst 55
>     set temp1_over 60
> 
> Save the changes and run "sensors -s". Your system should hopefully be
> back to full speed right after that. So all you have to do is make sure
> that "sensors -s" is called after you load the via686a driver at boot
> time.

Indeed! Just modifying these 2 values in my sensors.conf brought the 
system back to normal under 2.6.9! I'll get the latest config later. 
Thanks!

> You should take a look at the hardware monitoring options in your BIOS
> setup screen if it has any. Maybe you can configure the boot value of
> temp1_high directly there, and it may provide hints about voltages as
> well.

In BIOS one can only monitor sensors.

Thanks
Guennadi
---
Guennadi Liakhovetski

