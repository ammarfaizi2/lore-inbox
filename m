Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261554AbSIZWxY>; Thu, 26 Sep 2002 18:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261553AbSIZWwh>; Thu, 26 Sep 2002 18:52:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:52443 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261550AbSIZWve>;
	Thu, 26 Sep 2002 18:51:34 -0400
Message-ID: <3D939075.897C9021@us.ibm.com>
Date: Thu, 26 Sep 2002 15:55:49 -0700
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: [PATCH-RFC] 4 of 4 - New problem logging macros, SCSI RAIDdevice 
 driver
References: <3D8FC5BC.51A8FCCF@us.ibm.com>  <3D8FCC53.3070809@pobox.com> <1033055520.11848.49.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> A lot of it can be tidied up by very very few changes that can be done
> over time and make the job easier. Why not just start with
> 
>         dev_printk(dev, KERN_ERR "Exploded mysteriously");
> 
> and a few notification type things people can add eg
> 
>         dev_failed(dev);
>         dev_offline(dev);
> 
> much like we keep network status. That lets driverfs tell the decision
> making code in hotplug scripts the state of play and lets it figure out
> how to reassign resources, paper over cracks, phone the engineer.

Alan-
At the risk of reading more into your suggestion than you intended...
Are you supportive of adding infrastructure into the kernel that 
provides, conceptually at least, the sort of things that Rusty and
I (and others) are after ?

Specifically...

Provide a reasonable and printk-like interface (like you've
shown above), that writes to printk if advanced logging is not 
configured; but, if advanced logging is configured... 
 
1)During the build process, static event details (strings,
  format specifiers, file and function name, line no)
  are stored in a .log section in .o files, so that a user-mode
  utility can extract-it into user-space templates.
2)During runtime, the printk-like interface writes the dynamic data
  into an in-kernel buffer (NOT the printk ring buffer), and a 
  user-space daemon reads the event and writes to a logfile.
3)Advanced logging utilities apply the templates from step (1)     
  when events are read from the logfile for querying and displaying
  events, event notification, and log management. Templates can be
  modified to control how data is displayed (in what language, for
  example).

Mindful  that....

1) It will take time for device drivers to migrate to a new interface
2) It will take time for exploitation of the template approach 
3) we should avoid modifying current printk behavior 
4) advanced logging must be an optional feature to avoid the overhead
   where its not wanted or needed 
5) User-space utilities already exist (evlog.sourceforge.net)

and of course, mindful that the 2.5 window is closing in 1 month.
  
Thanks,
Larry Kessler
