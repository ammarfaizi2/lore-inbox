Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129443AbRCFUIO>; Tue, 6 Mar 2001 15:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129446AbRCFUIE>; Tue, 6 Mar 2001 15:08:04 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:48768 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129443AbRCFUH5>; Tue, 6 Mar 2001 15:07:57 -0500
Message-ID: <3AA5440B.8FAAB728@redhat.com>
Date: Tue, 06 Mar 2001 15:09:47 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>,
        LK <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.3 and new aic7xxx
In-Reply-To: <200103061847.f26IlaO06717@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" wrote:
> 
> >This is just to report on a the behavior of this driver. I've a dual
> >channel Adaptec 7895 controller. The adapter BIOS is configured to boot
> >from devices in channel B. I boot from  a disk connected to channel B
> >and when the kernel loads the driver the disks from channel A are seen
> >first, resulting in the drive names changing from, say sda to sdb. This
> >does not happen with 2.2.18 or 2.4.2. Is there an option to reverse the
> >order? I saw some of the options in the code, but none about this.
> 
> Can you provide me with a dmesg from a boot with aic7xxx=verbose?
> I just tested this on a 3940AUW and the behavior was as expected.
> Perhaps you have a motherboard based controller that has no seeprom?
> I don't know how to detect flipped channels in that configuration
> but I'll see what I can find out.

Your driver uses the new PCI probe code, so there is no gaurantee that you'll
see channel A before channel B.  So, if you haven't seen channel A yet, you
won't already have read the Channel B Primary bit in the SEEPROM.  So, my
guess would be that you should modify the code so that when presented with the
B or C channel of a device, maybe you should make a call to load_seeprom() (or
whatever it is in your driver) for Channel A, grab the bits you need that are
only on channel A's SEEPROM, save them off, then read the Channel B/C SEEPROM
entry as needed.  That should solve the problem anyway.  Of course, it could
simply be something else that is wrong and I could be smoking crack ;-)



-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
