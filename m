Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267757AbTAXPl5>; Fri, 24 Jan 2003 10:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267761AbTAXPl5>; Fri, 24 Jan 2003 10:41:57 -0500
Received: from poup.poupinou.org ([195.101.94.96]:55829 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S267757AbTAXPlx>; Fri, 24 Jan 2003 10:41:53 -0500
Date: Fri, 24 Jan 2003 16:51:01 +0100
To: Sergio Visinoni <piffio@arklinux.org>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, linux-kernel@vger.kernel.org,
       acpi-devel@sourceforge.net
Subject: Re: [ACPI] [TRIVIAL] Re: [PATCH] ACPI update (20030122)
Message-ID: <20030124155101.GZ18109@poup.poupinou.org>
References: <F760B14C9561B941B89469F59BA3A84725A131@orsmsx401.jf.intel.com> <20030124032222.A9061@piffio.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030124032222.A9061@piffio.homelinux.org>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 03:22:22AM +0100, Sergio Visinoni wrote:
> * Grover, Andrew (andrew.grover@intel.com) wrote:
> > (2.4) S4BIOS support (Ducrot Bruno)
> 
> Attached is the missing s4bios portion (the
> acpi_enter_sleep_state_s4bios function ) + fixes to make it
> build correctly on a 2.4.20 tree.
> 
> It should apply correctly on 2.4.21-pre3 as well (not tested).
> 

It should be OK (I think..)

Appart the following chunk:

--- linux-2.4.20/drivers/acpi/hardware/hwsleep.c.s4bios~	2003-01-24 02:35:41.000000000 +0100
+++ linux-2.4.20/drivers/acpi/hardware/hwsleep.c	2003-01-24 02:35:53.000000000 +0100
@@ -339,6 +387,8 @@
 
 	ACPI_FUNCTION_TRACE ("acpi_leave_sleep_state");
 
+	/* Be sure to have BM arbitration */
+	status = acpi_set_register (ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
 
 	/* Ensure enter_sleep_state_prep -> enter_sleep_state ordering */
 
@@ -371,8 +421,5 @@
 		return_ACPI_STATUS (status);
 	}
 
-	/* Disable BM arbitration */
-	status = acpi_set_register (ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
-
 	return_ACPI_STATUS (status);
 }


which is a bug fix for a different purpose.

We can not trust the bios when we have to enter the _WAK method.
Those we re-enable the BM arbitration before (the comment Disable
is actually a mistake).

Cheers,


-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
