Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318369AbSHPNnS>; Fri, 16 Aug 2002 09:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318376AbSHPNnS>; Fri, 16 Aug 2002 09:43:18 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:19183 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S318369AbSHPNnR>; Fri, 16 Aug 2002 09:43:17 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200208151939.OAA02778@ccure.karaya.com> 
References: <200208151939.OAA02778@ccure.karaya.com> 
To: Jeff Dike <jdike@karaya.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Eliminate root_dev_names - part 2 of 2 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 16 Aug 2002 14:46:26 +0100
Message-ID: <25346.1029505586@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jdike@karaya.com said:
>  nfs - not a block device, but registering a dummy gendisk probably
> won't hurt 

That will be done in userspace anyway -- no need to worry about that in the 
long term, I suspect.

I'd like to fix JFFS2 mounting too -- currently we _pretend_ to mount on a 
block device, because that was just easiest. Then we check the major number 
== MTD_BLOCK_MAJOR and use the minor as an index to find the actual MTD 
device, and don't use the mtdblock driver at all. 

In 2.5, we also allow mounting by MTD device number or name, but not as 
a root filesystem because the actual text of the 'root=' argument is not 
passed to the file system in that case. 

T'would be nice if that could be fixed.

--
dwmw2


