Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbVIMPzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbVIMPzZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVIMPzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:55:25 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:14291 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964821AbVIMPzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:55:22 -0400
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
	(end devices)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: ltuikov@yahoo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <4326CAC6.3050202@adaptec.com>
References: <20050910024454.20602.qmail@web51613.mail.yahoo.com>
	 <1126368081.4813.46.camel@mulgrave>  <4325997D.3050103@adaptec.com>
	 <1126547565.4825.52.camel@mulgrave>  <4325E5AE.1080900@adaptec.com>
	 <1126560191.4825.71.camel@mulgrave>  <4326CAC6.3050202@adaptec.com>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 10:54:17 -0500
Message-Id: <1126626858.4809.26.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-13 at 08:49 -0400, Luben Tuikov wrote:
> >>Channel and id are assigned _after_ the device has been scanned for
> >>LUs.  So I cannot just call scsi_scan_target() and say: "here is
> >>this SCSI Domain device, I know nothing about, other than
> >>the fact that it has a Target port, scan it".
> > 
> > In your code channel corresponds to an index in the ports array of the
> > host adapter and hence is known before you do any logical unit scanning.
> > Id is assigned from a bitmap in the port.  You could do that assignment
> > in sas_discover_end_dev() then you could use scsi_scan_target() in place
> > of sas_do_lu_discovery().  It would also mitigate your bug below since
> > now your id is one to one on the end devices rather than the logical
> > units of the end devices, so each port would support up to 128 end
> > devices rather than 128 logical units.
> 
> James, even Christoph understands this: no HCIL in SCSI Core is needed.
> The whole problem is not what you *keep grinding about over and over above*,
> but the fact that I have to _invent_ channel, id and emaciated LUN to give
> to the broken, outdated and Parallel SCSI-centric SCSI Core.
> 
> Christoph understand this, why cannot you?
> 
> That bitmap was added in the last moment when I needed to register devices
> with SCSI Core.  There is a lot of other problems which I've pointed out
> int the scsi glue file, which do you not want to talk about or you do
> not bring up.

I think, therefore, I've made the point that you could have used
scsi_scan_target() but chose not to for ideological rather than
technical reasons.

Writing code which duplicates existing mid-layer functionality is what
I've been telling you all along isn't acceptable.  Use what exists to
day and if it doesn't work quite right, fix it.  If you want to alter an
interface, we need to evolve towards it keeping all the current users
working.

Now, I can merge your transport class with Christoph's (or find someone
else to do it for me) by converting it to use the existing mid-layer and
transport class infrastructure (I think, actually, it will look rather
nice after this and probably reduce in size by about 50%) but I'd much
rather that you did it.

The unified transport class should be capable of supporting both the
aic94xx SAS card using your existing domain device interface as well as
the fusion SAS card, which is the whole goal of all of this in the first
place.

So, do you want to do this work, or would you rather just be responsible
for the aic94xx driver?

James


