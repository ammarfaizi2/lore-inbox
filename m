Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbUBZKY0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 05:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbUBZKY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 05:24:26 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:45776 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S262752AbUBZKYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 05:24:24 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       Jaco Kroon <jkroon@cs.up.ac.za>
Cc: Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Thu, 26 Feb 2004 02:24:14 -0800 (PST)
Subject: Re: 2.6.3 adaptec I2O will not compile
In-Reply-To: <403DBC2E.3040307@cs.up.ac.za>
Message-ID: <Pine.LNX.4.58.0402260223190.994@dlang.diginsite.com>
References: <403DBC2E.3040307@cs.up.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-ID: <Pine.LNX.4.58.0402260223192.994@dlang.diginsite.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark, do you have any comments on this?

On Thu, 26 Feb 2004, Jaco Kroon wrote:

> Date: Thu, 26 Feb 2004 01:28:14 -0800
> From: Jaco Kroon <jkroon@cs.up.ac.za>
> To: David Lang <david.lang@digitalinsight.com>
> Cc: Adrian Bunk <bunk@fs.tum.de>,
>      Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: 2.6.3 adaptec I2O will not compile
>
> David Lang wrote:
>
> >I received a post from Mark Salyzyn with a new driver that does
> compile,
> >he said that he has submitted the patches (I didn't get a chance to try
> >the new kernel yet, I expect to do that shortly and will report any
> >problems)
> >
> >D
> >
> Somebody just mailed me a patch too, but I found the following
> discrepancy:
>
> /*
>  * scsi_unregister will be called AFTER we return.
>  */
> static int adpt_release(struct Scsi_Host *host)
> {
>     adpt_hba* pHba = (adpt_hba*) host->hostdata[0];
> //  adpt_i2o_quiesce_hba(pHba);
>     adpt_i2o_delete_hba(pHba);
>     scsi_unregister(host);
>     return 0;
> }
>
> This is used to release the host, now read the comment, and then the
> line just before the return.  This line was added by the patch, which
> also commented out the quiesce line.  Is it possible to get any
> confirmation on how this is supposed to function?
>
> Jaco
>
> ===========================================
> This message and attachments are subject to a disclaimer. Please refer
> to www.it.up.ac.za/documentation/governance/disclaimer/ for full
> details.
> Hierdie boodskap en aanhangsels is aan 'n vrywaringsklousule onderhewig.
> Volledige besonderhede is by
> www.it.up.ac.za/documentation/governance/disclaimer/ beskikbaar.
> ===========================================
>
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
