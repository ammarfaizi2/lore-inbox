Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271120AbRHTHno>; Mon, 20 Aug 2001 03:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271117AbRHTHne>; Mon, 20 Aug 2001 03:43:34 -0400
Received: from dv1.dataventures.com ([207.188.144.122]:31874 "EHLO
	dv1.dataventures.com") by vger.kernel.org with ESMTP
	id <S271113AbRHTHnZ>; Mon, 20 Aug 2001 03:43:25 -0400
Date: Mon, 20 Aug 2001 01:40:21 -0600 (MDT)
From: Donald Thompson <dlt@dataventures.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Stallion EasyIO and devfs
In-Reply-To: <200108122123.f7CLNDK03327@mobilix.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.31.0108200124160.11127-100000@dv1.dataventures.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

devfsd and the compatability links work correctly as of 2.4.8 with the
patch you provided.

This is quite possibly user error and not a kernel issue, but it seems
pppd 2.4.1 breaks once I've got the stallion card under devfsd with
compatability links.

mgetty runs on device lets say, /dev/ttyE2 (symlink to /dev/ttyE/2), and
passes off incoming connections to pppd. I'm expecting pppd is gonna want
to look at /etc/ppp/options.ttyE2, but its not.

If I change stallion.c at around line 145 from:
static char     *stl_serialname = "ttyE/%d";

To:
static char     *stl_serialname = "ttyE%d";

so that the real device becomes /dev/ttyE2 rather than a symlink to
/dev/ttyE/2 pppd starts looking at the correct options file.

pppd seems to be able to handle the compatability symlinks just fine on
/dev/ttyS* devices and find the proper ppp options file to look at. So I'm
guessing they've got a hack to handle devfsd standard serial ports, or I'm
doing something wrong somewhere.

-Don

On Sun, 12 Aug 2001, Richard Gooch wrote:

> Donald Thompson writes:
> > Works correctly. Didn't patch properly into 2.4.7 properly, think it
> > just
> > had the wrong line numbers. But patching it in by hand was no problem.
> > I'm
> > missing compatability symlinks, so that I get links from /dev/ttyE/* to
> > /dev/ttyE*, but thats another problem.
>
> The current version of devfsd (1.3.14) should provide them. Note that
> the kernel patch and devfsd will probably be changed again, but the
> compatibility names should stay the same.
>
> 				Regards,
>
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca
>

