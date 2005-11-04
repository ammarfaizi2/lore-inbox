Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751537AbVKDPxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbVKDPxJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbVKDPxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:53:09 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:46730 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751537AbVKDPxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:53:07 -0500
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, heicars2@de.ibm.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATCH resubmit] do_mount: reduce stack consumption
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
From: Andreas Herrmann <AHERRMAN@de.ibm.com>
X-MIMETrack: S/MIME Sign by Notes Client on Andreas Herrmann/Germany/IBM(Release 5.0.11
  |July 24, 2002) at 04.11.2005 16:52:39,
	Serialize by Notes Client on Andreas Herrmann/Germany/IBM(Release 5.0.11  |July
 24, 2002) at 04.11.2005 16:52:39,
	Serialize complete at 04.11.2005 16:52:39,
	S/MIME Sign failed at 04.11.2005 16:52:39: The cryptographic key was not
 found,
	Serialize by Router on D12ML065/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 04/11/2005 16:53:04,
	Serialize complete at 04/11/2005 16:53:04
Message-ID: <OFDDB8F7D0.1B3A39C6-ONC12570AF.00570609-C12570AF.005739CC@de.ibm.com>
Date: Fri, 4 Nov 2005 16:53:03 +0100
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.11.2005 15:06 Al Viro wrote:
> On Fri, Nov 04, 2005 at 01:57:05PM +0100, Heiko Carstens wrote:
> > Ok, since I can only guess what you don't like: here is an updated 
patch
> > that probably addresses a few things.
> > If you don't like this one too, could you please explain what should 
be
> > changed?

> Depth analysis.  E.g. do_move_mount() change is simply nonsense - _this_
> is not going to overflow, no matter what.  And do_add_mount() change
> is also very suspicious - looks like you are attacking the wrong place
> in call chain.

Obviously you missed the point that (depending on the compiler version,
options etc.) do_move_mount() and do_add_mount() can be inlined.
Hence stack frame size of do_mount is directly influenced by those two
functions. At least when I performed my "skin-deep" analysis of this
kernel stack overflow both functions were inlined in do_mount().

Stack consumptions of all other functions occurring in the backtrace
were moderate or due to the amount of inlined functions.

Just do_mount and its inlined friends use to put larger structures on
the stack that better should be allocated. There would not be any
performance impact for the user to allocate the structs.


Regards,

Andreas
