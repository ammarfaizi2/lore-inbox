Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBGRk4>; Wed, 7 Feb 2001 12:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129144AbRBGRkq>; Wed, 7 Feb 2001 12:40:46 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:38924 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129032AbRBGRka>; Wed, 7 Feb 2001 12:40:30 -0500
Date: Wed, 07 Feb 2001 12:39:59 -0500
From: Chris Mason <mason@suse.com>
To: Xuan Baldauf <xuan--reiserfs@baldauf.org>, David Rees <dbr@spoke.nols.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
Message-ID: <511820000.981567599@tiny>
In-Reply-To: <3A818619.7C3967BC@baldauf.org>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, February 07, 2001 06:30:01 PM +0100 Xuan Baldauf
<xuan--reiserfs@baldauf.org> wrote:
> In my case, it's a SIS5513 board.
> 
> I have to note that I now have one case which is between offset 9260 and
> 11016. So probably the tails unpacking theory does not work out.
> 
> After a more systematical search, I have found following offsets:
> 
> 9260..11016 = 1756
> 4204.. 5964 = 1760
> 2160.. 3243 = 1083
> 2896.. 3534 =  638
> 1392.. 3704 = 2312
> 
> and so on. Maybe I should write a program which automatically detects and
> reports the zero blocks. I think the theory of tails unpacking does not
> work out, because there are also areas affected which are not between 2048
> and 4096. Also the length of the zeroing can be greater than 2048.
> However, I did not encounter a length of over 4096.
> 

Files up to around 16k in length can have tails, and tails can be larger
than 2048 bytes.

Also interesting would be info about when the file closes.  reiserfs only
creates a tail on file close (file writes always go to full blocks).  If
you application has the file mmap'd the rules change a little (does it?).

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
