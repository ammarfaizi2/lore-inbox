Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272042AbTHMXSh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 19:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272043AbTHMXSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 19:18:36 -0400
Received: from evrtwa1-ar2-4-33-045-074.evrtwa1.dsl-verizon.net ([4.33.45.74]:25531
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S272042AbTHMXSe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 19:18:34 -0400
Message-ID: <3F3AC749.7010803@candelatech.com>
Date: Wed, 13 Aug 2003 16:18:33 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.21: proc-fs and allocating many new files (PROC_NDYNAMIC)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on a mac-vlan module, and would like to have a proc entry for each
vlan device.  My code fails after creating 124 vlans (which will create ~240
proc entries).

What is worse, after doing this, the 802.1q module will not even load because
it can't allocate it's small number of proc entries.  (I will fix this shortly
and have it ignore the error and continue, since it uses ioctls as well.)

After poking around in the proc-fs code (please, next time someone re-writes this,
give us an int* err_code return value so that we can know why things fail!!!)
I believe I must be hitting the failure due to not being able to find a free entry
in the proc_alloc_map.  It seems that a max of PROC_NDYNAMIC proc entries can be
created.  This value is #defined to 4096 in 2.4.21....

So, several questions:

Can I arbitrarily make this bigger...say (4096*4)?  Any trade-offs other than memory?

Is there a better way to have many proc file entries?  I can even live
  with read-only, as I can do the config through ioctls.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


