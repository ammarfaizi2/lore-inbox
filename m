Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319440AbSIGF5l>; Sat, 7 Sep 2002 01:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319441AbSIGF5l>; Sat, 7 Sep 2002 01:57:41 -0400
Received: from 62-190-217-72.pdu.pipex.net ([62.190.217.72]:6148 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S319440AbSIGF5k>; Sat, 7 Sep 2002 01:57:40 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209070609.g8769pex000224@darkstar.example.net>
Subject: Re: ide drive dying?
To: hahn@physics.mcmaster.ca (Mark Hahn)
Date: Sat, 7 Sep 2002 07:09:50 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0209062017230.14523-100000@coffee.psychology.mcmaster.ca> from "Mark Hahn" at Sep 06, 2002 08:21:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Now that the Smart Suite S.M.A.R.T. applications are unmaintained, would
> 
> what happened?

I'm not sure, but the last update to the S.M.A.R.T. Suite website, on 3 July this year, says that the page and the applications are no longer maintained.

Seems the Beta of version 2.0 never got finished either :-(.

> > there be any chance of implementing S.M.A.R.T. in to the kernel IDE code?
> 
> what would be the benefit?  as I understand it, smart is really
> a means of reporting long-term disk status, which is optimally done
> by user-space.  even something exotic like failing over to a spare disk
> would clearly be best done in user-space.

You are right, the idea is to monitor the smart info, ideally from when the drive is new, but at least over a period of time, so that a change in it's behavior shows up.

> > I know the IDE code is already a nightmare, but it would be a nice feature.
> 
> what did you have in mind?

Well, nothing very exotic, just some sanity checks on the SMART data when the IDE and SCSI interfaces are probed for devices.  Something like:

* Device supports/does not support following SMART features:
  * General attributes
  * Vendor attributes
  * Error log
  * Selftest log
  * Drive info

* SMART is currently enabled/disabled

* Total power-on time is currently foo hours

* Warning if any of the following is excessive:

  * Last spin up time
  * Calibration retry count
  * UDMA CRC Error count

> > S.M.A.R.T. is terribly under used at the moment - most people don't even
> > know what it is.  Infact, I could be wrong, but isn't a subset of
> > S.M.A.R.T. implemented on modern SCSI disks, too? 
> 
> I know that most people don't run it, but other than that, how is it 
> underused?

Well, I can't see any reason for *not* using it where available - who wouldn't appreciate a warning on boot up, 'oh, by the way, /dev/hda is about to die in a couple of days :-)'

> > Monitoring of any kind is always a nice feature to have...
> 
> certainly, though that doesn't mean it should move from userspace to
> kernel...

Agreed, there isn't any point in doing monitoring in kernelspace, but capabilities reporting, and sanity checks on boot might be useful.

John.
