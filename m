Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266465AbUFQMPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUFQMPM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 08:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUFQMOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 08:14:49 -0400
Received: from smtpout.azz.ru ([81.176.67.34]:47491 "HELO mailserver.azz.ru")
	by vger.kernel.org with SMTP id S266465AbUFQMNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 08:13:31 -0400
Message-ID: <40D18B55.1020704@vlnb.net>
Date: Thu, 17 Jun 2004 16:15:17 +0400
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040512
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [ANNOUNCE] Generic SCSI Target Middle Level for Linux (SCST)
 with target drivers
References: <40D075DA.2000007@vlnb.net> <20040616182131.GV20511@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040616182131.GV20511@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Wed, Jun 16, 2004 at 08:31:22PM +0400, Vladislav Bolkhovitin wrote:
> 
>>Any comments would be appreciated.
> 
> 
> The first obvious question is: Why does this need to be done in kernel
> space?  My impression was that an iSCSI target would best be done in
> userspace.
> 
The answer is quite obvious as well. There is not only iSCSI target 
(i.e. software one) in the world. For hardware targets if you were 
switch on each command (IRQ) to user space and back, it would be huge 
performance penalty, especially for commands that request small data 
transfers. Take a look on the Qlogic target: all job is done in the 
tasklet, without ever context switch. The same is for upcoming iSCSI 
hardware, like Qlogic QLA4010, which also supports target mode.

BTW, the processing is simple enough, the main SCST module is only about 
  60Kb long. The main point is that this processing must be done in 
_each_ SCSI target driver. So, consider SCSI target mid-level like a 
library (framework) for such drivers, exectly as the regular SCSI 
mid-level for regular SCSI drivers.

Thanks,
Vlad
