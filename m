Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263829AbUDPVhM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbUDPVfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:35:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:13244 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262509AbUDPVfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:35:04 -0400
X-Authenticated: #21910825
Message-ID: <40805185.8050608@gmx.net>
Date: Fri, 16 Apr 2004 23:35:01 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linux RAID Mailing List <linux-raid@vger.kernel.org>
Subject: [RFC] Enhanced MD / alternatives in userspace
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

during development of raiddetect I asked myself if this tool could be
extended to set up not only the classic vendor ATARAID devices, but also
things like Adaptec ASR (HostRAID) and DDF based RAID formats.

Raiddetect is a utility which searches all disks for known RAID
superblocks/metadata and parses the contents for validity. The results of
this scan can either be outputted to the console or used to tell dm/md to
set up the RAID devices. The newest version of raiddetect was posted to
linux-kernel a few minutes ago and I will provide a web home for it soon.

So far, the development of raiddetect is at a stage where I can find (and
mostly validate) the metadata of all ATARAID devices recognized by 2.4
kernels. Adding ASR and DDF detection should be relatively easy since I
tried to make the code moular and extensible.

Assuming the on-disk format of RAID5 et al. does not differ between the
Linux md implementation and e.g. DDF (modulo some offset and different
superblocks), DDF support is possible today with combinations of plain MD
and DM. No additional kernel code needed at all. Simply teach raiddetect
to understand the DDF metadata and pass this information to MD in a format
md understands. The DDF metadata can be masked away from MD by using DM so
you don't have to worry about it being trashed.

Since this is marked as [RFC], please comment on its (in-)feasibility.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

