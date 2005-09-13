Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbVIMVCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbVIMVCo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 17:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbVIMVCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 17:02:44 -0400
Received: from magic.adaptec.com ([216.52.22.17]:1692 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932338AbVIMVCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 17:02:43 -0400
Message-ID: <43273E6C.9050807@adaptec.com>
Date: Tue, 13 Sep 2005 17:02:36 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Douglas Gilbert <dougg@torque.net>,
       Christoph Hellwig <hch@infradead.org>, Luben Tuikov <ltuikov@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
 (end devices)
References: <1126308304.4799.45.camel@mulgrave> <20050910024454.20602.qmail@web51613.mail.yahoo.com> <20050911094656.GC5429@infradead.org> <43251D8C.7020409@torque.net> <1126537041.4825.28.camel@mulgrave> <20050912164548.GB11455@us.ibm.com> <1126545680.4825.40.camel@mulgrave> <20050912184629.GA13489@us.ibm.com> <1126639342.4809.53.camel@mulgrave> <4327354E.7090409@adaptec.com> <20050913203611.GH32395@parisc-linux.org>
In-Reply-To: <20050913203611.GH32395@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2005 21:02:42.0005 (UTC) FILETIME=[7B254850:01C5B8A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/05 16:36, Matthew Wilcox wrote:
> On Tue, Sep 13, 2005 at 04:23:42PM -0400, Luben Tuikov wrote:
> 
>>A SCSI LUN is not "u64 lun", it has never been and it will
>>never be.
>>
>>A SCSI LUN is "u8 LUN[8]" -- it is this from the Application
>>Layer down to the _transport layer_ (if you cared to look at
>>_any_ LL transport).
> 
> 
> Could you explain the difference please?  Why is it preferable to keep
> the LUN as an array of bytes instead of a single large integer?

A LUN is at the same concept level as a CDB.

You can see this by reading SAM or looking at the definition
of _any_ transport frame of _any_ transport (close your eyes and
pick one).

What you will see is that there is no "MSB" or "LSB" for
things like CDB and LUN fields.

SAM is very explicit on this, especially for LUN the language
used is very affirmative.

>>(It is also capitalized since it is an abbreviation.)
> 
> 
> Well, we have two conflicting standards to follow here.  That of English
> which insists that abbreviations be capitalised, and that of the kernel
> which requires that all-caps identifiers be macros rather than structure
> members.  We have to violate one.

I've never seen the symbols "lun".  In any spec
"Logical Unit Number" and "LOGICAL UNIT NUMBER" have always
been abbreviated "LUN".

As to code, it is completely clear which is which.  If you take
a look at the SAS code you know immediately what 
"task->ssp_task.LUN" is.  It is what you'd see in a spec, in the
transport frame, the "LUN", "u8 LUN[8]" field.

After a while, this becomes second nature to you.

	Luben

