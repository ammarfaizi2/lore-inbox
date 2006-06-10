Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030451AbWFJQjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030451AbWFJQjR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 12:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030452AbWFJQjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 12:39:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57534 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030451AbWFJQjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 12:39:16 -0400
Date: Sat, 10 Jun 2006 17:38:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ben Collins <bcollins@ubuntu.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       "Serge E. Hallyn" <serue@us.ibm.com>, weihs@ict.tuwien.ac.at,
       linux1394-devel@lists.sourceforge.net, bcollins@debian.org,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kthread conversion: convert ieee1394 from kernel_thread
Message-ID: <20060610163859.GA24081@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ben Collins <bcollins@ubuntu.com>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	"Serge E. Hallyn" <serue@us.ibm.com>, weihs@ict.tuwien.ac.at,
	linux1394-devel@lists.sourceforge.net, bcollins@debian.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <20060610143100.GA15536@sergelap.austin.ibm.com> <20060610144205.GA13850@infradead.org> <448AE12E.5060002@s5r6.in-berlin.de> <20060610154213.GA19077@infradead.org> <1149957286.4448.542.camel@grayson>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149957286.4448.542.camel@grayson>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 12:34:46PM -0400, Ben Collins wrote:
> 1394 bus rescanning takes a _lot_ longer than a PCI rescan. If we don't
> do this in a kthread, then we have to do it as a tasklet, and take a
> chance of stalling for a few seconds (not ms), preventing other
> tasklet's from running. Suboptimal, IMO.

This is just user-initiated FC rescans.  And I doubt they take as long
as parallel scsi rescans which can go into the minutes range easily.
Nothing will be stalled by calling this except the caller, which would
usually be echo called from some shell, something the user can put in
the background using job control.

