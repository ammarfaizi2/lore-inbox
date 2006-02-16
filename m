Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWBPOZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWBPOZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 09:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWBPOZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 09:25:40 -0500
Received: from mail.avm.de ([194.175.125.228]:28392 "EHLO mail.avm.de")
	by vger.kernel.org with ESMTP id S932270AbWBPOZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 09:25:39 -0500
In-Reply-To: <20060205205313.GA9188@kroah.com>
Subject: Re[2]: 2.6.16 serious consequences / GPL_EXPORT_SYMBOL / USB drivers of
 major vendor excluded
Sensitivity: 
To: Greg KH <greg@kroah.com>
Cc: torvalds@osdl.org, kkeil@suse.de, linux-kernel@vger.kernel.org,
       opensuse-factory@opensuse.org, libusb-devel@lists.sourceforge.net
X-Mailer: Lotus Notes Release 6.5.2 June 01, 2004
Message-ID: <OFED05BE20.31E2BACE-ONC1257115.005DE6CA-C1257117.004F2C48@avm.de>
From: s.schmidt@avm.de
Date: Thu, 16 Feb 2006 15:24:44 +0100
X-MIMETrack: Serialize by Router on ANIS1/AVM(Release 6.5.5|November 30, 2005) at
 16.02.2006 15:24:44
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-purgate-ID: 149429::060216152447-35428005-1B62413B 0
X-purgate-Ad: Checked for SPAM by eleven - eXpurgate www.eXpurgate.net
X-purgate: clean
X-purgate: This mail is considered clean
X-purgate-type: clean
X-purgate-size: 6051/4712
X-AntiVirus: checked by AntiVir Milter (version: 1.1.0-4; AVE: 6.33.0.31; VDF: 6.33.0.242; host: mail.avm.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are pleased to note that the GPL_EXPORT_SYMBOL fix has been withdrawn.
This is particularly important for customers who have been relying on good
driver coverage for ISDN/DSL devices with SUSE distributions over the past
few years. However, as we understand the ongoing discussion, a number of
people are tending towards a position of enforcement of USB GPL drivers
only. We would like to take this opportunity to clarify where we see the
differences between AVM and other devices and the difficulties regarding a
possible move towards user mode.

The user space does not ensure the reliability of time critical analog
services like Fax G3 or analog modem emulations. This quality of service
can only be guaranteed within the kernel space.

Let me explain that issue using the FaxG3-service as an example. Fax G3
(T.30) is not specified as a data protocol with error-free transmission.
Let us assume, there is a system peak demand on the host system, while a
fax is incoming, e.g. because of a parallel access of a higher prioritized
process. Handled in user mode, the user gets broken or fragmented faxes as
a result. Same for the communication with analogue remote stations (modems)
over a digital net (ISDN). You cannot speak about reliable quality of
service anymore. Only the kernel offers low latency and timeline processing
which is required for soft DSP alike processing. This should be OS
independent and from our point of view, Linux should not be inferior to any
other OS.

Of course, other OS also have the concept of shifting usb drivers to user
space, but time critical demands are explicitly excluded. The given
examples gPhoto und rio500 at
http://libusb.sourceforge.net/doc/examples-other.html operate mostly
unidirectionally. Isochronical services within the libusb, especially the
USB driver framework for the user mode are not ready for bidirectional
operation. Even though the current libusb development started integrating
the isochronous transfer support, it still is under construction and it is
unclear if this task can be accomplished at all (see statement from
Johannes Erdfelt at
http://sourceforge.net/mailarchive/forum.php?thread_id=9531397&forum_id=5425
).

In contrast, AVM's driver concept is established for many years now. So the
user mode does not seem to be an alternative for ISDN/DSL communication
devices at the moment. Moreover, a rework of more than 30 devices would
consume a lot of development resources. You will hardly find a similiar
company situation. We are not talking about a 10 to 20kByte mouse driver,
but rather >600kByte of complex work per device. Take a look at the
FRITZ!Card PCI package
atftp://ftp.avm.de/cardware/fritzcrd.pci/linux/suse.93/fcpci-suse93-3.11-07.tar.gz).

As a private corporation our primary focus is market relevance. AVM
invested more than 10 years of work to make analog services like Fax G3 and
analog modem emulation available to users of the digital ISDN network. The
situation is similar for the DSL part of the driver with very complex DSP
algorithms. To anticipate any "open vs. closed source" discussion:Only a
handful of companies worldwide have such know-how. With regard to our
competitive situation, we have to protect our hard-won intellectual
property and therefore cannot open the closed source part of the driver.

Kind Regards
Sven Schmidt

AVM Audiovisuelles Marketing und Computersysteme GmbH
Alt-Moabit 95, 10559 Berlin, Germany
http://www.avm.de




                                                                           
             Greg KH                                                       
             <greg@kroah.com>                                              
                                                                        An 
             05.02.2006 21:53           s.schmidt@avm.de                   
                                                                     Kopie 
                                        linux-kernel@vger.kernel.org,      
                                        opensuse-factory@opensuse.org,     
                                        kkeil@suse.de                      
                                                                     Thema 
                                        Re: 2.6.16 serious consequences /  
                                        GPL_EXPORT_SYMBOL / USB drivers of 
                                        major vendor excluded              
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           




On Fri, Feb 03, 2006 at 05:24:10PM +0100, s.schmidt@avm.de wrote:
> on January 15th / major change in USB subsystem and GPL_EXPORT_SYMBOL
> declaration
> Greg Kroah-Hartman added a Patch to kernel 2.6.15-git12, which
> substantially changed the USB system.

Have you asked Greg why he did this?

Have you asked what the other alternatives are?

You do know about usbfs/libusb that allows you to write USB drivers in
userspace that can go at the full speed of the USB bus?  Why not redo
your code to take advantage of this?  If you do that, the extra bonus is
that your drivers will also work on the BSDs and possibly Windows with
no changes needed (I think libusb works on Windows...)

> This mail is not intended to provoke a discussion of open vs closed
source.
> The only intention of this mail is to make you aware of the consequences
of
> such a decision.

I was not aware of your drivers, but now that you have informed me of
them, I am willing to work with you to figure out how to resolve this
issue.

thanks,

greg k-h


