Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274653AbRIUDN7>; Thu, 20 Sep 2001 23:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274669AbRIUDNu>; Thu, 20 Sep 2001 23:13:50 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:48893 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S274653AbRIUDNk>; Thu, 20 Sep 2001 23:13:40 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Thu, 20 Sep 2001 21:12:21 -0600
To: Steve Lord <lord@sgi.com>
Cc: hch@sgi.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Gonyou, Austin" <austin@coremetrics.com>,
        narancs@narancs.tii.matav.hu, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: XFS to main kernel source
Message-ID: <20010920211221.G14526@turbolinux.com>
Mail-Followup-To: Steve Lord <lord@sgi.com>, hch@sgi.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Gonyou, Austin" <austin@coremetrics.com>,
	narancs@narancs.tii.matav.hu, linux-xfs@oss.sgi.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <hch@ns.caldera.de> <20010920222643.A7267@caldera.de> <200109202131.f8KLVbB19795@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109202131.f8KLVbB19795@jen.americas.sgi.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 20, 2001  16:31 -0500, Steve Lord wrote:
> XFS quotas are transactional, when space is added to a file the quota is
> adjusted in the same transaction. It is fairly hard to do this without your
> own quota code.

Actually not.  The quotas in ext3 are transactional as well.  It's just
that the "ext3" journal layer allows nested transactions, so it is possible
to start a write transaction, call into the journal code which calls back
into the ext3 write code to start a nested transaction on the journal file
(i.e. it is in the same transaction as the initial write), and then the
initial write completes.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

