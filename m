Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129718AbRA1RXy>; Sun, 28 Jan 2001 12:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRA1RXo>; Sun, 28 Jan 2001 12:23:44 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:61189 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S129235AbRA1RXe>; Sun, 28 Jan 2001 12:23:34 -0500
Date: Sun, 28 Jan 2001 18:22:15 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
Message-ID: <20010128182215.D9106@pcep-jamie.cern.ch>
In-Reply-To: <200101281012.LAA04278@cave.bitwizard.nl> <3A73F1EB.B6F69A93@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A73F1EB.B6F69A93@transmeta.com>; from hpa@transmeta.com on Sun, Jan 28, 2001 at 02:18:19AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> It is; you'd have to specify "eax" as a clobber value, and that is
> undesirable.

For outb_p, EAX is used, usually for the last time, in the preceding
"out" instruction so clobbering it is not a big deal.

For inb_p, you first have to copy EAX to another register before
outputting the post_byte.  That's a small penalty.  Are in[bwl]_p used
anywhere time critical?  (Richard Johnson's explanation for outb_p
implies that inb_p is not required, but perhaps that explanation doesn't
tell the whole story).

> And you're still overwriting the POST value written by the BIOS.

Can the BIOS-written value be read from port 0x80?

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
