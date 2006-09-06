Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWIFLsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWIFLsJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 07:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWIFLsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 07:48:09 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:14600 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S1750730AbWIFLsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 07:48:08 -0400
Date: Wed, 6 Sep 2006 13:48:01 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.17.4] slabinfo.buffer_head increases
In-Reply-To: <Pine.LNX.4.63.0607101412250.27628@pcgl.dsa-ac.de>
Message-ID: <Pine.LNX.4.63.0609061341150.1700@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0607101023450.27628@pcgl.dsa-ac.de>
 <Pine.LNX.4.63.0607101412250.27628@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 10 Jul 2006, Guennadi Liakhovetski wrote:
>
>> I am obsering a steadily increasing buffer_head value in slabinfo under
>> 2.6.17.4. I searched the net / archives and didn't find anything
>> directly relevant. Does anyone have an idea or how shall we debug it?

The problem is still there under 2.6.18-rc2. I narrowed it down to ext3 
journal. To reproduce one just has to mount an ext3 partition and perform 
(write) accesses to it. A loop { touch /mnt/foo; sleep 1; } suffices - 
just let it run for a couple of minutes and monitor buffer_head in 
/proc/slabinfo. If you mount it as ext2 the problem is gone.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
