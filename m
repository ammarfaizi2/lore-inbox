Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292634AbSCDSGY>; Mon, 4 Mar 2002 13:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292631AbSCDSGR>; Mon, 4 Mar 2002 13:06:17 -0500
Received: from pc-80-195-34-57-ed.blueyonder.co.uk ([80.195.34.57]:58754 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S292533AbSCDSGF>; Mon, 4 Mar 2002 13:06:05 -0500
Date: Mon, 4 Mar 2002 18:05:37 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Chris Mason <mason@suse.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        James Bottomley <James.Bottomley@steeleye.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <20020304180537.F1444@redhat.com>
In-Reply-To: <phillips@bonn-fries.net> <200203041503.g24F3WU01722@localhost.localdomain> <20020304170434.B1444@redhat.com> <1201480000.1015262195@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1201480000.1015262195@tiny>; from mason@suse.com on Mon, Mar 04, 2002 at 12:16:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 04, 2002 at 12:16:35PM -0500, Chris Mason wrote:
 
> writeback data order is important, mostly because of where the data blocks
> are in relation to the log.  If you've got bdflush unloading data blocks
> to the disk, and another process doing a commit, the drive's queue
> might look like this:
> 
> data1, data2, data3, commit1, data4, data5 etc.
> 
> If commit1 is an ordered tag, the drive is required to flush 
> data1, data2 and data3, then write the commit, then seek back
> for data4 and data5.

Yes, but that's a performance issue, not a correctness one.

Also, as soon as we have journals on external devices, this whole
thing changes entirely.  We still have to enforce the commit ordering
in the journal, but we also still need the ordering between that
commit and any subsequent writeback, and that obviousy can no longer
be achieved via ordered tags if the two writes are happening on
different devices.

--Stephen
