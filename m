Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVBJACR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVBJACR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 19:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVBJACO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 19:02:14 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:62665 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261976AbVBJACF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 19:02:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=aGcKUrfzhtMOUXXz09dcYnmZSRBEvZ1A/t9tCyKKb6Xn2nuKj8oNQvuDfhO3EIxUIUcFHx96q4BrVXs3rz5RZP8P633YPkH1XVjcrIOrIrMeaceJe83snXVx7jTY1u+y0iQyaxzJX0NMME6B28NE+Wrty5cFpk70j983WQnoypg=
Message-ID: <420AA476.1040406@gmail.com>
Date: Thu, 10 Feb 2005 09:01:58 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Tejun Heo <tj@home-tj.org>
Subject: Re: [rfc][patch] ide: fix unneeded LBA48 taskfile registers access
References: <Pine.GSO.4.58.0502062348200.2763@mion.elka.pw.edu.pl> <4206F2E5.7020501@gmail.com> <200502070959.54973.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200502070959.54973.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello, Bartlomiej.  Happy new lunar year.

Bartlomiej Zolnierkiewicz wrote:
> 
> I would prefer to not teach do_rw_taskfile() about ->tf_{in,out}_flags
> (and convert all users to use helpers) - it is much simpler this way,
> 
> ->flags field in ide_task_t is needed anyway (32-bit I/O flag).
> 

  New lunar year day is one of the biggest holidays here, so I haven't 
got time to work for a few days.  As it's over now, I began to work on 
ide drivers again.  I applied your task->flags patch and am moving my 
patches over it.

  One problem is that, with ATA_TFLAG_LBA48, whether to use HOB 
registers or not cannot be determined separately for writing and 
reading.  So, when initializing flush tasks, if WIN_FLUSH_CACHE_EXT is 
used, we need to turn on ATA_TFLAG_LBA48 to read error location 
properly, and we end up unnecessarily writing HOB registers.

  I think we can...

  1. Just leave it as it is.  It's not that big a deal.
  2. Use another flag(s) to control LBA48 reading/writing separately.
  3. do my proposal. :-)

  I'm currently sticking to #1.  Please let me know what you think.

  Thanks.

-- 
tejun

