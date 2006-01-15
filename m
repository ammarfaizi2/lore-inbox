Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWAOINH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWAOINH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 03:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbWAOINH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 03:13:07 -0500
Received: from pineapple.cc.columbia.edu ([128.59.29.164]:10722 "EHLO
	pineapple.cc.columbia.edu") by vger.kernel.org with ESMTP
	id S1750999AbWAOING (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 03:13:06 -0500
Date: Sun, 15 Jan 2006 03:13:05 -0500 (EST)
From: Matthew Schulkind <mss2049@columbia.edu>
To: linux-kernel@vger.kernel.org
Subject: Possible IDE bug in 2.4 and 2.6
Message-ID: <Pine.GSO.4.64.0601150312400.1738@pineapple.cc.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First off, I'm not on the list, so please CC me on any replies.

I believe I have found a bug in the IDE code of both the 2.4 and 2.6 
kernels. Here is a snippet from 2.4.32 starting from line 277 of 
drivers/ide/ide-io.c:

if (drive->select.b.lba &&
                     (hwif->INB(IDE_COMMAND_REG) == WIN_SPECIFY))
                     /* some newer drives don't
                      * support WIN_SPECIFY
                      */
                     return ide_stopped;


This code is attempting to ignore IDE errors if they were a result of the 
WIN_SPECIFY command, but the IDE_COMMAND_REG is a write only register, if 
it is read, IDE_STATUS_REG is read instead. Could someone confirm that 
this is in fact a bug and not something I'm missing? Almost identical code 
is also found in 2.6 kernels.

I think the best way to fix this would be to ignore the error in 
set_geometry_intr() in ide-taskfile.c instead of in ide_error() as seen 
above.

-Matt Schulkind
