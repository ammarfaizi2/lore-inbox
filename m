Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbTDNRRZ (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263572AbTDNRRZ (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:17:25 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:41212 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263571AbTDNRRY (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:17:24 -0400
Date: Mon, 14 Apr 2003 11:28:17 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: olarge -- force O_LARGEFILE on app binaries.
Message-ID: <20030414112817.H26054@schatzie.adilger.int>
Mail-Followup-To: Tigran Aivazian <tigran@veritas.com>,
	linux-kernel@vger.kernel.org
References: <20030414101959.E26054@schatzie.adilger.int> <Pine.LNX.4.44.0304141724130.3964-100000@einstein31.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0304141724130.3964-100000@einstein31.homenet>; from tigran@veritas.com on Mon, Apr 14, 2003 at 05:29:18PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 14, 2003  17:29 +0100, Tigran Aivazian wrote:
> On Mon, 14 Apr 2003, Andreas Dilger wrote:
> > I don't see how this helps you very much.  So now, instead of the kernel
> > complaining with EFBIG and/or SIGXFSZ, your 32-bit size offset wraps in
> > the application.
> 
> Good point, but, very _very_ luckily it does NOT happen in this case, i.e. 
> with gs(1). I just verified every bit of output and it is correct both 
> before and beyond the 2G boundary, all the way to 5.2G. But in general 
> (i.e. for some other app) your comment is valid.

I suppose for applications that do only streaming I/O (and gs is one of those)
this O_LARGEFILE fix shouldn't cause any problem.  Any applications which do
seeking, or otherwise use/store the file offset for any reason will likely
break.  However, since they are still using the 32-bit syscalls, they will
likely just get EOVERFLOW and not die horribly (assuming they check the
return code).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

