Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTLUXPn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 18:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTLUXPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 18:15:43 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:34260 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264256AbTLUXPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 18:15:40 -0500
Message-ID: <3FE62999.90309@labs.fujitsu.com>
Date: Mon, 22 Dec 2003 08:15:37 +0900
From: Tsuchiya Yoshihiro <tsuchiya@labs.fujitsu.com>
Reply-To: tsuchiya@labs.fujitsu.com
Organization: Fujitsu Labs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: filesystem bug?
References: <3FDD7DFD.7020306@labs.fujitsu.com>	 <1071582242.5462.1.camel@sisko.scot.redhat.com> <3FDF7BE0.205@jpl.nasa.gov>	 <3FDF95EB.2080903@labs.fujitsu.com>  <3FE0E5C6.5040008@labs.fujitsu.com> <1071782986.3666.323.camel@sisko.scot.redhat.com>
In-Reply-To: <1071782986.3666.323.camel@sisko.scot.redhat.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie wrote:

>>>Following is the failed combination:
>>>Redhat9 with 2.4.20-8 ext2 and ext3
>>>Redhat9 with 2.4.20-19.9 ext2 and ext3
>>>Redhat9 with 2.4.20-24.9 ext2
>>>      
>>>
>>I forgot to mention that I had been testing 2.4.20 from kernel.org 
>>also.... And it failed now!
>>    
>>
>
>This looks more and more like either bad hardware, or a specific device
>driver problem.  What storage is being used here?
>
>  
>
Hi,

Stephen, I don't think it is a hardware problem, since this problem
happens on
several different machines, and it happens both on SCSI disk and
our own iSCSI like device driver. I typically use:

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
<Adaptec aic7899 Ultra160 SCSI adapter>
aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

blk: queue c1671674, I/O limit 4095Mb (mask 0xffffffff)
Vendor: SEAGATE Model: ST336753LC Rev: DX03


>It could possibly be a core VFS bug, but the VFS is in general pretty
>reliable under load.  We've had problems under specific edge conditions
>such as races between sync and unmount, but the basic VFS behaviour
>under load generally gets _lots_ of testing, so I'd definitely start by
>looking elsewhere.  
>
>I'd also like to see how your 2.4.23 and 2.6.0-test11 testing is going. 
>That might give some clues, too.  There's a race between clear_inode()
>and read_inode() fixed in those kernels, but that doesn't look relevant
>here; there may be something else changed that's significant, though.
>
>  
>
EXT3 on 2.4.23 and 2.6.0-test11 both failed. I feel when I make the
filesystem
smaller - make the filesystem usage 70% to 80% during the test- ,
the problem happens easyer.

Yoshi
--
Yoshihiro Tsuchiya


