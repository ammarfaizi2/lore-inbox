Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbTLPXcJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 18:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264321AbTLPXcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 18:32:09 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:30441 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264278AbTLPXcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 18:32:06 -0500
Message-ID: <3FDF95EB.2080903@labs.fujitsu.com>
Date: Wed, 17 Dec 2003 08:31:55 +0900
From: Tsuchiya Yoshihiro <tsuchiya@labs.fujitsu.com>
Reply-To: tsuchiya@labs.fujitsu.com
Organization: Fujitsu Labs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bryan Whitehead <driver@jpl.nasa.gov>
CC: "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: filesystem bug?
References: <3FDD7DFD.7020306@labs.fujitsu.com> <1071582242.5462.1.camel@sisko.scot.redhat.com> <3FDF7BE0.205@jpl.nasa.gov>
In-Reply-To: <3FDF7BE0.205@jpl.nasa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Stephen, I don't have anything helpful for debuging at this point. We 
noticed the problem
by debuging our SCSI driver. Then we found that the same thing happens 
on generic
SCSI disk and IDE also.  The problem we observed in our driver was that 
while it is
processing a buffer, which should be locked by BH_LOCK,  the contents of 
the buffer were
overwritten. The amount of overwrite is a few byte to 1KB out of 4KB, 
which cannot be done
in our driver. Then, we tried a generic SCSI and I reproduced the problem.
I think it is not because of a broken pointer because overwrites only 
happen in data buffers
and other parts of memory seem ok.

Especially with Ext2 reproducing is easy, it happens in a few hours with 
my script.
With Ext3, in a day if you are lucky.

Now I am trying 2.4.23 from kernel.org with ext3, and 2.6.0-test11 from 
kernel.org with ext3.
So far, it's been a about a day, they are runing nicely. Let's see what 
happens.

Following is the failed combination:
Redhat9 with 2.4.20-8 ext2 and ext3
Redhat9 with 2.4.20-19.9 ext2 and ext3
Redhat9 with 2.4.20-24.9 ext2

Thanks,
Yoshi
---
Yoshihiro Tsuchiya


