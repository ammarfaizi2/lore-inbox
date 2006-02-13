Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWBMSSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWBMSSm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 13:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWBMSSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 13:18:41 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37027 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932383AbWBMSSl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 13:18:41 -0500
Date: Mon, 13 Feb 2006 18:18:39 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 7/8] don't mangle INQUIRY if cmddt or evpd bits are set
Message-ID: <20060213181839.GA27946@ftp.linux.org.uk>
References: <E1F6vyJ-00009k-3Z@ZenIV.linux.org.uk> <43EA7226.60306@s5r6.in-berlin.de> <20060208230559.GK27946@ftp.linux.org.uk> <43F0B1AB.6010708@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F0B1AB.6010708@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 05:19:55PM +0100, Stefan Richter wrote:
> OK, tested scsiinfo now with 9 bridges (8 or 7 different chips).
> The patch obviously works as expected.
> 
> Jody, are you going to channel the patch through your tree?
> 
> BTW, a Prolific based enclosure indeed seems to be unable to handle
> CD-ROMs after scsiinfo treatment. An enclosure based on an old
> revision of TI StorageLynx apparently causes mode_sense -> check
> condition/ unit attention loops when scsiinfo tries to access some
> mode page.

The former is best treated by using the hardware in question as a pissuary,
to make sure that its contents matches the quality of design.  The latter
might be more interesting - RBC devices are only required to implement
MODE SENSE/SELECT page 6; they shouldn't get messed by the rest, but at
least some of them blindly respond with page 6 to _every_ MODE SENSE.
So that might be a good reason to blacklist.
