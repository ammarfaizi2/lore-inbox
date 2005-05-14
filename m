Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262788AbVENPr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbVENPr6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 11:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbVENPr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 11:47:58 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:17049 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262788AbVENPrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 11:47:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=M/fOC6Ggl4cVpGq/gf69Ltj8IePL4yl60SOP0Jb2mslbcixWjSY8vUKE+4KLzTOyzSJKbL6cklMsg8kYHH6/Ff0KfgvLpr0+ZoXM1r91j/tcCfbyj00g2abg5y4O/kbM+fSIUQwjfeupONnVKZWSRta0M2KiXDF2t163Cr/rZE4=
Date: Sun, 15 May 2005 00:47:33 +0900
From: Tejun Heo <htejun@gmail.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, Christoph Hellwig <hch@infradead.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 04/04] scsi: remove unnecessary scsi_wait_req_end_io()
Message-ID: <20050514154733.GA5557@htj.dyndns.org>
References: <20050514135610.81030F26@htj.dyndns.org> <20050514135610.50606F9C@htj.dyndns.org> <1116084383.5049.18.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116084383.5049.18.camel@mulgrave>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, James.

On Sat, May 14, 2005 at 11:26:23AM -0400, James Bottomley wrote:
> On Sat, 2005-05-14 at 22:57 +0900, Tejun Heo wrote:
> > 	As all requests are now terminated via scsi midlayer, we don't
> > 	need to set end_io for special reqs, remove it.
> 
> This statement is untrue as long as the prep function can return
> BLKPREP_KILL, which it still does even after your patch set, so the
> scsi_wait_req_end_io() is still necessary to catch this case.

 BLKPREP_KILL is only used to kill illegal (unpreparable, way-off)
requests.  Actually, for special requests, the only tests performed
are req->flags and CDB_SIZE tests.  I don't think anyone does/will
submit that illegal requests via scsi_wait_req().  And if so, it will
be a bug.

 I don't feel strong against keeping the end_io routine but, if you
decide to keep the routine, please consider adding a comment
explaining the peculiar path the routine might be used, such that
other people don't have to wander through the code.

 Thanks.

-- 
tejun
