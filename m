Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262545AbREVAWz>; Mon, 21 May 2001 20:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262546AbREVAWo>; Mon, 21 May 2001 20:22:44 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:42459 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S262545AbREVAWi>; Mon, 21 May 2001 20:22:38 -0400
Date: Tue, 22 May 2001 02:22:34 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Matthew Wilcox <matthew@wil.cx>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
Message-ID: <20010522022234.T754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <E151xFO-0000ue-00@the-village.bc.nu> <Pine.GSO.4.21.0105211745490.12245-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0105211745490.12245-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, May 21, 2001 at 05:51:08PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 05:51:08PM -0400, Alexander Viro wrote:
> Sure. But we have to do two syscalls only if ioctl has both in- and out-
> arguments that way. Moreover, we are talking about non-trivial in- arguments.
> How many of these are in hotspots?

ioctl has actually 4 semantics:

command only
command + read
command + write
command + rw-transaction

Separating these would be a first step. And yes, I consider each
of them useful.

command only: reset drive
command + rw-transaction: "dear device please mangle this data"
   (crypto processors come to mind...)

The other two are obviously needed and already accepted by all of
you.

Hotspots: crypto hardware or generally DSPs.


Regards

Ingo Oeser
-- 
To the systems programmer,
users and applications serve only to provide a test load.
