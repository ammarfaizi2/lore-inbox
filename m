Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbUBZO4Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 09:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbUBZO4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 09:56:24 -0500
Received: from magic.adaptec.com ([216.52.22.17]:25512 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261640AbUBZO4U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 09:56:20 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.3 adaptec I2O will not compile
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Thu, 26 Feb 2004 09:56:17 -0500
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F38CF74@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.3 adaptec I2O will not compile
Thread-Index: AcP8UrOEZL5D4RYVQCKOeBUF9/1phgAI1uZQ
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "David Lang" <david.lang@digitalinsight.com>,
       "Jaco Kroon" <jkroon@cs.up.ac.za>
Cc: "Adrian Bunk" <bunk@fs.tum.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My code fragment has (original multiversion and version in 2.4.24):

/*
 * scsi_unregister will be called AFTER we return.
 */
static int adpt_release(struct Scsi_Host *host)
{
        adpt_hba* pHba = (adpt_hba*) host->hostdata[0];
//      adpt_i2o_quiesce_hba(pHba);
        adpt_i2o_delete_hba(pHba);
        return 0;
}

So I am unsure as to how *that* (the scsi_unregister call) got in there
in the 2.6.3 stream. adpt_i2o_queisce was commented out in version 2.4.5
of the driver (Prior to the `historical documents' and at least the
in-box driver for RH7.3). It was not part of the 2.6.2 tree I based my
patch on and not part of the submitted 2.6 patch for the dpt_i2o driver.

adpt_i2o_quiesce tells the adapter to stop all activity, including
builds, and is a blocking command with a 4 minute timeout.

Sincerely -- Mark Salyzyn

-----Original Message-----
From: David Lang [mailto:david.lang@digitalinsight.com] 
Sent: Thursday, February 26, 2004 5:24 AM
To: Salyzyn, Mark; Jaco Kroon
Cc: Adrian Bunk; Linux Kernel Mailing List
Subject: Re: 2.6.3 adaptec I2O will not compile

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
> >he said that he has submitted the patches (I didn't get a chance to
try
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
> Hierdie boodskap en aanhangsels is aan 'n vrywaringsklousule
onderhewig.
> Volledige besonderhede is by
> www.it.up.ac.za/documentation/governance/disclaimer/ beskikbaar.
> ===========================================
>
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
