Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbTBSSZP>; Wed, 19 Feb 2003 13:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268389AbTBSSZO>; Wed, 19 Feb 2003 13:25:14 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:136 "EHLO w-patman.des")
	by vger.kernel.org with ESMTP id <S264654AbTBSSZN>;
	Wed, 19 Feb 2003 13:25:13 -0500
Date: Wed, 19 Feb 2003 10:23:08 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Thomas Molina <tmolina@cox.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.62]: 2/3: Make SCSI low-level drivers also a seperate, complete selectable submenu
Message-ID: <20030219102308.A19911@beaverton.ibm.com>
References: <Pine.LNX.4.44.0302190105370.4923-100000@localhost.localdomain> <Pine.LNX.3.96.1030219084918.9798A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1030219084918.9798A-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Wed, Feb 19, 2003 at 08:55:22AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 08:55:22AM -0500, Bill Davidsen wrote:
> On Wed, 19 Feb 2003, Thomas Molina wrote:
> 
> > On Tue, 18 Feb 2003, Bill Davidsen wrote:
> > 
> > > On Tue, 18 Feb 2003, Christoph Hellwig wrote:
> > > 
> > > > On Tue, Feb 18, 2003 at 02:02:10PM +0100, Marc-Christian Petersen wrote:
> > > > > so you can disable all SCSI lowlevel drivers at once.
> > > > 
> > > > Why? just disable CONFIG_SCSI instead of adding an artifical option
> > > 
> > > Isn't that going to disable all of SCSI? I think the intention may be to
> > > drop hardware drivers and just use ide-scsi, although I might be
> > > misreading the original intent.
> > > 
> > > There are a fair number of tape/CD/DVD devices out there which you might
> > > run SCSI. I many cases will run SCSI or not at all.
> > 
> > I thought the intent was to make it unnecessary to run ide-scsi at all.  
> 
> I don't think it matters, the idea is to avoid all the low-level SCSI
> menus in one place, without disabling the ability to handle ATAPI devices.
> Using the ide-scsi or not still uses SCSI drivers AFAIK.

But as far as linux scsi is concerned, ide-scsi is a low-level SCSI driver. 

IDE and USB have there own Kconfig options that enable low-level SCSI
driver emulation outside of drivers/scsi, pcmcia does not, and there are
probably other exceptions.

The following is simpler, though I'm not suggesting anything like this be
applied, since we don't have consitency. If all of the low-level scsi
drivers and options were under drivers/scsi, and we could separate
emulated versus real, something like this might be OK:

--- 1.12/drivers/scsi/Kconfig	Sun Feb  9 17:29:49 2003
+++ edited/drivers/scsi/Kconfig	Wed Feb 19 10:19:11 2003
@@ -170,8 +170,16 @@
 	  logging turned off.
 
 
+config SCSI_LOW_LEVEL
+	bool "SCSI low level drivers"
+
+	help
+	  enables a list of additional SCSI low level drivers
+
+	  If you need one of the drivers here say Y, else say N ;-)
+
 menu "SCSI low-level drivers"
-	depends on SCSI!=n
+	depends on SCSI!=n && SCSI_LOW_LEVEL!=n
 
 config SGIWD93_SCSI
 	tristate "SGI WD93C93 SCSI Driver"

-- Patrick Mansfield
