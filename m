Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277954AbRJIUTd>; Tue, 9 Oct 2001 16:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277953AbRJIUTY>; Tue, 9 Oct 2001 16:19:24 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:51964 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S277952AbRJIUTS>; Tue, 9 Oct 2001 16:19:18 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Tue, 9 Oct 2001 14:19:30 -0600
To: "White, Charles" <Charles.White@COMPAQ.com>
Cc: "Alan Cox (E-mail)" <alan@redhat.com>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@suse.de>,
        "Cameron, Steve" <Steve.Cameron@COMPAQ.com>
Subject: Re: [PATCH] Update to the Compaq cpqarray driver...
Message-ID: <20011009141930.C6348@turbolinux.com>
Mail-Followup-To: "White, Charles" <Charles.White@COMPAQ.com>,
	"Alan Cox (E-mail)" <alan@redhat.com>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@suse.de>,
	"Cameron, Steve" <Steve.Cameron@COMPAQ.com>
In-Reply-To: <A2C35BB97A9A384CA2816D24522A53BB0EA3FF@cceexc18.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A2C35BB97A9A384CA2816D24522A53BB0EA3FF@cceexc18.americas.cpqcorp.net>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 09, 2001  11:17 -0500, White, Charles wrote:
> This patch is for 2.4.10-ac8.
> 
> This changes the driver to use the new 2.4 kernel PCI APIs. This changes
> how all our cards are detected. 
> This adds some new IOCTLs for adding/deleting volumes while the driver
> is online. 
> It have added code to request/release the io-region used by our cards.

Minor note - static global variables are already zero initialized, so no
need for the following bit of the patch (which is also bad if MAX_CTLR
is not 8):

-static ctlr_info_t *hba[MAX_CTLR];
+static ctlr_info_t *hba[MAX_CTLR] =
+       { NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL };

For future reference, you'd want something like "hda[MAX_CTRL] = { NULL, };"
(assuming you are initializing a local array) which should do the right thing
(it initializes the rest of the array as zero).

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

