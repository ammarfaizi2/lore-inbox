Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRABPxp>; Tue, 2 Jan 2001 10:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbRABPxf>; Tue, 2 Jan 2001 10:53:35 -0500
Received: from hermes.mixx.net ([212.84.196.2]:31497 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129383AbRABPx1>;
	Tue, 2 Jan 2001 10:53:27 -0500
Message-ID: <3A51F1B0.3AD38F9F@innominate.de>
Date: Tue, 02 Jan 2001 16:20:16 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Vedran Rodic <vedran@renata.irb.hr>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-prerelease problems (it corrupted my ext2 filesystem)
In-Reply-To: <20010102131507.A7573@renata.irb.hr> <3A51D9BF.23C42DFE@innominate.de> <20010102152409.A10863@renata.irb.hr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vedran Rodic wrote:
> On Tue, Jan 02, 2001 at 02:38:07PM +0100, Daniel Phillips wrote:
> > Could you provide details of your configuration?
> 
> I put the complete kernel log of that session at http://quark.fsb.hr/~vrodic/kern.log
> 
> I scanned my swap device several times today with badblocks -w, and
> it didn't show any errors. I also did some RAM tests with memtest86,
> again with no errors.
> 
> If you need more details, just ask.

Are you still running 2.4.0-pre?  Can you reproduce the problem?  Does
the problem occur only with v4l?  Did you back up your files?

BTW, while spelunking the swap code I noticed this oddity:

  pte_t pte_mkdirty(pte_t pte) { (pte).pte_low |= _PAGE_DIRTY; return
pte; }

and similarly for 10 or so other functions - these functions just return
the passed pte, and reassign it to the pte orginally passed.  :-/ This
dates from version 1.2.13.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
