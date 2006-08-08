Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWHHJi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWHHJi2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 05:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWHHJi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 05:38:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8841 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932168AbWHHJi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 05:38:27 -0400
To: linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: modifying degraded raid 1 then re-adding other members is bad
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat OS Tools Group
Date: Tue, 08 Aug 2006 06:38:19 -0300
Message-ID: <or8xlztvn8.fsf@redhat.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Assume I have a fully-functional raid 1 between two disks, one
hot-pluggable and the other fixed.

If I unplug the hot-pluggable disk and reboot, the array will come up
degraded, as intended.

If I then modify a lot of the data in the raid device (say it's my
root fs and I'm running daily Fedora development updates :-), which
modifies only the fixed disk, and then plug the hot-pluggable disk in
and re-add its members, it appears that it comes up without resyncing
and, well, major filesystem corruption ensues.

Is this a known issue, or should I try to gather more info about it?

This happened with 2.6.18rc3-git[367] (not sure which), plus Fedora
development patches.

-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
Secretary for FSF Latin America        http://www.fsfla.org/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
