Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270815AbTGPNow (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 09:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270824AbTGPNow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 09:44:52 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:17082 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S270815AbTGPNov
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 09:44:51 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>,
       "Lars Marowsky-Bree" <lmb@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Partitioned loop device..
Date: Wed, 16 Jul 2003 08:51:18 -0500
User-Agent: KMail/1.5
References: <E1B7C89B8DCB084C809A22D7FEB90B3840AE@frodo.avalon.ru>
In-Reply-To: <E1B7C89B8DCB084C809A22D7FEB90B3840AE@frodo.avalon.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307160851.18967.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 July 2003 03:59, Dimitry V. Ketov wrote:
> > There is no difference. What makes /dev/loop1a worse than
> > /dev/hda1? It's just block devices, that's it.
>
> Yes, it is. But I meant its still impossible to use legacy fdisk to
> create that DM mapped partitions (or am I wrong?)

The program fdisk does not know about Device-Mapper. It only reads and writes 
DOS partition tables, and leaves it up to the kernel block-layer to provide 
the corresponding block devices. Other tools are available that use the same 
partitioning format and work with Device-Mapper.

> > I have hopes that the entire partitioning code etc will be
> > ripped out in 2.7 in favour of full userspace discovery + DM,
> > and that MD will hit the same fate...
>
> MD - did you mean metadisks (software raids?)

Yes. Software RAID devices are currently handled by the MD driver, but much of 
that functionality could be ported to Device-Mapper. RAID-linear and RAID-0 
can already be supported in DM, and the latest DM release from Sistina has a 
module to support RAID-1. So all that's left is to port the RAID-5 code to a 
DM module, and modify the user-space tools.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

