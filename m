Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbVHJFpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbVHJFpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 01:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbVHJFpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 01:45:22 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:44698 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S964995AbVHJFpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 01:45:21 -0400
Message-ID: <42F9946E.2040609@ext.bull.net>
Date: Wed, 10 Aug 2005 07:45:18 +0200
From: Frederic TEMPORELLI <frederic.temporelli@ext.bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: fr-fr, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Cc: Frederic TEMPORELLI <frederic.temporelli@ext.bull.net>
Subject: Re: kernel workqueue -max name length
References: <42F8AE91.9030708@ext.bull.net>
In-Reply-To: <42F8AE91.9030708@ext.bull.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/08/2005 07:57:41,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/08/2005 07:57:42,
	Serialize complete at 10/08/2005 07:57:42
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


any explanation about the 10 chars limit for kernel workqueue name ?


another question: why is the name length test managed by BUG_ON ?
returning a NULL workqueue is done in the next test (failed kmalloc for wq)...

Anyway, this can explain some issues when loading some SCSI drivers modules.


hope that somebody knows...


Frederic TEMPORELLI wrote:
> Hello,
> 
> 
> When creating a workqueue, workqueue name is limited to 10 chars
> (kernel/workqueue.c , function is __create_workqueue, test is done in a 
> BUG_ON).
> 
> Why has this length be limited to 10 chars ?
> Can I safely increase this max length (13 chars should be enough...) ?
> 
> 
> 
> Some comments about these questions:
> 
> In SCSI layer, HBA kernel ID is incremented after each modprobe/rmmod.
> 
> Then, when a scsi driver is managing a working queue and HBA kernel ID 
> is greater than 99 (let's assume that you have modprobe/rmmod the scsi 
> driver to get this ID to 99, or you may have play with 'scsi_debug' 
> module), an oops is generated when loading again the driver (and the 
> driver is frozen).
> 
> This is because working queue name format is "scsi_wq_%d" 
> (drivers/scsi/hosts.c , function scsi_add_host, %d is the HBA ID), and 
> so working queue name length is greater than 10 chars when HBA kernel ID 
> is > 99...
> 
> 
> Best regards
> 
> 


-- 
Frederic TEMPORELLI

