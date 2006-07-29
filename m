Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWG2RuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWG2RuA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 13:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWG2RuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 13:50:00 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:29082 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932191AbWG2Rt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 13:49:59 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44CB9F11.6080508@s5r6.in-berlin.de>
Date: Sat, 29 Jul 2006 19:46:57 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Tom Walter Dillig <tdillig@stanford.edu>
CC: linux-kernel@vger.kernel.org, w@1wt.eul, kernel_org@digitalpeer.com,
       security@kernel.org
Subject: Re: Complete report of Null dereference errors in kernel 2.6.17.1
References: <1153782637.44c5536e013a4@webmail>
In-Reply-To: <1153782637.44c5536e013a4@webmail>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Walter Dillig wrote on 2006-07-25:
> [276]
> 1043, 1051, 1075, 1083, 1091, ... drivers/ieee1394/sbp2.c
> Possible null dereference of variable "hi" checked at
> (1096:drivers/ieee1394/sbp2.c).

Thanks for the report.

"hi" is guaranteed to be nonzero and valid at these places. The 
safeguards are the if clauses in lines 1042, 1050, 1074, 1082, 1090. 
Their conditions will evaluate to false if "hi" was NULL. This is 
because of the order of how members of struct scsi_id_instance_data are 
initialized in sbp2_alloc_device() and sbp2_start_device().

What other potential errors did your checker find in 
drivers/ieee1394/sbp2.c?
-- 
Stefan Richter
-=====-=-==- -=== ===-=
http://arcgraph.de/sr/
