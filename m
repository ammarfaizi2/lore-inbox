Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265606AbUFDFCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265606AbUFDFCi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 01:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265607AbUFDFCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 01:02:38 -0400
Received: from istop-1.customer.tor.nac.net ([207.99.111.43]:3794 "EHLO
	linrouter.istop.com") by vger.kernel.org with ESMTP id S265606AbUFDFCg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 01:02:36 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [PATCH/RFC] Lustre VFS patch, version 2
Date: Fri, 4 Jun 2004 01:03:54 -0400
User-Agent: KMail/1.6.2
Cc: Christoph Hellwig <hch@infradead.org>,
       "Peter J. Braam" <braam@clusterfs.com>, linux-kernel@vger.kernel.org,
       axboe@suse.de, kevcorry@us.ibm.com, arjanv@redhat.com,
       viro@parcelfarce.linux.theplanet.co.uk, trond.myklebust@fys.uio.no,
       anton@samba.org, lustre-devel@clusterfs.com
References: <20040602231554.ADC7B3100AE@moraine.clusterfs.com> <20040603135952.GB16378@infradead.org> <20040603141922.GI4423@marowsky-bree.de>
In-Reply-To: <20040603141922.GI4423@marowsky-bree.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406040103.54672.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 June 2004 10:19, Lars Marowsky-Bree wrote:
> The hooks (once cleaned up, no disagreement here, the technical feedback
> so far has been very valuable and continues to be) are useful and in
> effect needed not just for Lustre, but in principle for all cluster
> filesystems, such as (Open)GFS and others, even potentially NFS4 et al.

GFS is now down to needing two trivial patches:

  1) export sync_inodes_sb
  2) provide a filesystem hook for flock

Since GFS functions well without any of the current batch of proposed vfs 
hooks, the word "needed" is not appropriate.  Maybe there is something in 
here that could benefit GFS, most probably in the intents department, but we 
certainly do want to try it first before pronouncing on that.  The raw_ops 
seem to be entirely irrelevant to GFS, which is peer-to-pear, so does not 
delegate anything to a server.  I don't think we have a use for lookup_last.
There are quite possibly some helpful ideas in the dcache tweaks but the devil 
is in the details: again we need to try it.

Such things as:

+#define DCACHE_LUSTRE_INVALID	0x0020	/* invalidated by Lustre */

clearly fail the "needed not just for Lustre" test.

Looking into my crystal ball, I see many further revisions of this patch set.  
Unfortunately, in the latest revision we lost the patch-by-patch discussion, 
which seems to have been replaced by list of issues sorted by complainant.   
That's interesting, but it's no substitute.

Regards,

Daniel
