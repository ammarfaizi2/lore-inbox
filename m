Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVCIVTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVCIVTt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVCIVTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 16:19:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24301 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261552AbVCIVSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 16:18:48 -0500
Date: Wed, 9 Mar 2005 21:18:44 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Andrew Morton <akpm@osdl.org>
Cc: suparna@in.ibm.com, pbadari@us.ibm.com, daniel@osdl.org,
       sebastien.dugue@bull.net, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.10 -  direct-io async short read bug
Message-ID: <20050309211844.GC2076@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com,
	pbadari@us.ibm.com, daniel@osdl.org, sebastien.dugue@bull.net,
	linux-aio@kvack.org, linux-kernel@vger.kernel.org
References: <1110189607.11938.14.camel@frecb000686> <20050307223917.1e800784.akpm@osdl.org> <20050308090946.GA4100@in.ibm.com> <1110302614.24286.61.camel@dyn318077bld.beaverton.ibm.com> <1110309508.24286.74.camel@dyn318077bld.beaverton.ibm.com> <1110324434.6521.23.camel@ibm-c.pdx.osdl.net> <1110326043.24286.134.camel@dyn318077bld.beaverton.ibm.com> <20050309040757.GY27331@ca-server1.us.oracle.com> <20050309152047.GA4588@in.ibm.com> <20050309115348.2b86b765.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309115348.2b86b765.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 11:53:48AM -0800, Andrew Morton wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> >  If writes/truncates take care of zeroing out the rest of the sector
> >  on disk, might we still be OK without having to do the bounce buffer
> >  thing ?
> 
> We can probably rely on the rest of the sector outside i_size being zeroed
> anyway.  Because if it contains non-zero gunk then the fs already has a
> problem, and the user can get at that gunk with an expanding truncate and
> mmap() anyway.

	Actually, yeah, even today we rely on block_prepare_write and
friends to handle that trail zeroing.  That all happens after the sector
has been read from disk.  So this should be analogous.

Joel

-- 

Life's Little Instruction Book #396

	"Never give anyone a fruitcake."

			http://www.jlbec.org/
			jlbec@evilplan.org
