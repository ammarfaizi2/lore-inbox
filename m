Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292516AbSCDQxO>; Mon, 4 Mar 2002 11:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292508AbSCDQxG>; Mon, 4 Mar 2002 11:53:06 -0500
Received: from pc-80-195-34-57-ed.blueyonder.co.uk ([80.195.34.57]:33410 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S292482AbSCDQwt>; Mon, 4 Mar 2002 11:52:49 -0500
Date: Mon, 4 Mar 2002 16:52:16 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jeremy Higdon <jeremy@classic.engr.sgi.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <20020304165216.A1444@redhat.com>
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain> <E16heCm-0000Q5-00@starship.berlin> <10203032021.ZM443706@classic.engr.sgi.com> <E16hl4R-0000Zx-00@starship.berlin> <phillips@bonn-fries.net> <10203032209.ZM424559@classic.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <10203032209.ZM424559@classic.engr.sgi.com>; from jeremy@classic.engr.sgi.com on Sun, Mar 03, 2002 at 10:09:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 03, 2002 at 10:09:35PM -0800, Jeremy Higdon wrote:

> > WCE is per-command?  And 0 means no caching, so the command must complete
> > when the data is on the media?
> 
> My reading is that WCE==1 means that the command is complete when the
> data is in the drive buffer.

Even if WCE is enabled in the caching mode page, we can still set FUA
(Force Unit Access) in individual write commands to force platter
completion before commands complete.

Of course, it's a good question whether this is honoured properly on
all drives.

FUA is not available on WRITE6, only WRITE10 or WRITE12 commands.

--Stephen
