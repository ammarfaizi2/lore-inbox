Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVBRKb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVBRKb1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 05:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVBRKb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 05:31:27 -0500
Received: from ext-ch1gw-6.online-age.net ([64.37.194.14]:36738 "EHLO
	ext-ch1gw-6.online-age.net") by vger.kernel.org with ESMTP
	id S261326AbVBRKbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 05:31:21 -0500
From: "Kiniger, Karl (GE Healthcare)" <karl.kiniger@med.ge.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Date: Fri, 18 Feb 2005 11:31:07 +0100
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
Message-ID: <20050218103107.GA15052@wszip-kinigka.euro.med.ge.com>
References: <200502152125.j1FLPSvq024249@turing-police.cc.vt.edu> <200502161736.j1GHa4gX013635@turing-police.cc.vt.edu> <cv36kk$54m$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cv36kk$54m$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 05:58:05PM -0500, Bill Davidsen wrote:
> Valdis.Kletnieks@vt.edu wrote:
> >On Wed, 16 Feb 2005 10:42:21 +0100, "Kiniger, Karl (GE Healthcare)" said:
> >
> >
> >>>  Have you tested the ISO on some *OTHER* hardware?  The impression I got
> >>>  was that the cd was *burned* right by ide-cd, but when *read back*, it
> >>>  bollixed things up at the end of the CD.....
> >>
> >>Using ide-scsi is enough to get all the data till the real end of the CD.
> >
> >
> >OK, so the problem is that ide-cd is able to *burn* the CD just fine, but 
> >it
> >suffers lossage when ide-cd tries to read it back...
> >
> >Alan - are the sense-byte patches for ide-cd in a shape to push either 
> >upstream
> >or to -mm?
> 
> The last time I looked at this, the issue was that the user software did 
> a large read and the ide-cd didn't properly return a small data block 
> with no error, but rather returned an error with no data. If you get the 
> size of the ISO image, you can read that with any program which doesn't 
> try to read MORE than that.

Not entirely true (at least for me). I actually tried to read the 
last iso9660 data sector with a small C program (reading 2 kb) and
it failed to read the sector. Using ide-scsi I was able to read it.....

sdd (from Joerg Schilling) should not try to read more than ivsize
bytes (InputVolumeSize) if that argument is given - I did not
verify with strace though.


Karl

-- 
Karl Kiniger   mailto:karl.kiniger@med.ge.com
GE Medical Systems Kretztechnik GmbH & Co OHG
Tiefenbach 15       Tel: (++43) 7682-3800-710
A-4871 Zipf Austria Fax: (++43) 7682-3800-47
