Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVBJAxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVBJAxU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 19:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbVBJAwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 19:52:37 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:63371 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261994AbVBJAwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 19:52:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=c5PnHMbM3x0qpA+2LvX22C9FM+QFYu/SaqjqdDazJn2b5RQlbGAU/GiP9PzOIZqJAoGNnA68rvnPRE2+RrvdIzvkzFygDQloDVfeP61hfM7xADXMyioTLRVRh6jC6knykQLmvUZgzuXHBs7AMO419bV5McL6F+iBWa8wSH0AHUE=
Message-ID: <420AB049.4040705@gmail.com>
Date: Thu, 10 Feb 2005 09:52:25 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [rfc][patch] ide: fix unneeded LBA48 taskfile registers access
References: <Pine.GSO.4.58.0502062348200.2763@mion.elka.pw.edu.pl>	 <4206F2E5.7020501@gmail.com>	 <200502070959.54973.bzolnier@elka.pw.edu.pl>	 <420AA476.1040406@gmail.com> <58cb370e050209162437808733@mail.gmail.com>
In-Reply-To: <58cb370e050209162437808733@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Okay, another quick question.

  To fix the io_32bit race problem in ide_taskfile_ioctl() (and later 
ide_cmd_ioctl() too), it seems simplest to mark the taskfile with 
something like ATA_TFLAG_IO_16BIT flag and use the flag in task_in_intr().

  However, ATA_TFLAG_* are used by libata, and I think that, although 
sharing hardware constants is good if the hardware is similar, sharing 
driver-specific flags isn't such a good idea.  So, what do you think?

  1. Add ATA_TFLAG_IO_16BIT to ata.h
  2. Make ide's own set of task flags, maybe IDE_TFLAG_* (including
     IDE_TFLAG_LBA48)

-- 
tejun

