Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131772AbRCUTgR>; Wed, 21 Mar 2001 14:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131771AbRCUTgH>; Wed, 21 Mar 2001 14:36:07 -0500
Received: from Xenon.Stanford.EDU ([171.64.66.201]:58241 "EHLO
	Xenon.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S131760AbRCUTfy>; Wed, 21 Mar 2001 14:35:54 -0500
From: Benjamin Chelf <bchelf@CS.Stanford.EDU>
Message-Id: <200103211935.LAA05813@Xenon.Stanford.EDU>
Subject: Re: [CHECKER] 120 potential dereference to invalid pointers errors
To: linux-kernel@vger.kernel.org
Date: Wed, 21 Mar 2001 11:35:02 -0800 (PST)
Cc: mc@CS.Stanford.EDU
In-Reply-To: <200103191624.f2JGOmo16559@webber.adilger.int> from "Andreas Dilger" at Mar 19, 2001 09:24:48 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I'm interested in one specific "bug" reported out of these 120 and
no one seems to have responded about it yet. It reports the error on
line 889 (drivers/scsi/sd.c), but line 825 also seems bad (memsetting
the pointer that was allocated before checking for NULL). This piece
of code seems to go back to the 1.0 version of the kernel, hence my
suspcision about it actually being a bug. Anyone have thoughts about
it? Thanks!

-ben

---------------------------------------------------------
[BUG] scsi_malloc can return NULL. it should find error at line 756

2.4.1/drivers/scsi/sd.c:889:sd_init_onedisk:
ERROR:NULL:738:889: Using unknown ptr "buffer" illegally! set by
'scsi_malloc':738

Start --->
        buffer = (unsigned char *) scsi_malloc(512);

        spintime = 0;

        /* Spin up drives, as required.  Only do this at boot time */

        ... DELETED 143 lines ...


                rscsi_disks[i].capacity = 1 + ((buffer[0] << 24) |
                                               (buffer[1] << 16) |
                                               (buffer[2] << 8) |
Error --->
                                               buffer[3]);

---------------------------------------------------------

