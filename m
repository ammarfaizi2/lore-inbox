Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVE2Wx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVE2Wx3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 18:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVE2Wx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 18:53:29 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:9898 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261462AbVE2Wx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 18:53:26 -0400
Date: Mon, 30 May 2005 00:53:25 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: RAID-5 design bug (or misfeature)
Message-ID: <Pine.LNX.4.58.0505300043540.5305@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

RAID-5 has rather serious design bug --- when two disks become temporarily
inaccessible (as it happened to me because of high temperature in server
room), linux writes information about these errors to the remaining disks
and when failed disks are on line again, RAID-5 won't ever be accessible.

RAID-HOWTO lists some actions that can be done in this case, but none of
them can be done if root filesystem is on RAID --- the machine just won't
boot.

I think Linux should stop accessing all disks in RAID-5 array if two disks
fail and not write "this array is dead" in superblocks on remaining disks,
efficiently destroying the whole array.

Mikulas
