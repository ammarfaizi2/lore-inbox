Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281607AbRKPWlN>; Fri, 16 Nov 2001 17:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281604AbRKPWlD>; Fri, 16 Nov 2001 17:41:03 -0500
Received: from MAILGW01.bang-olufsen.dk ([193.89.221.116]:24329 "EHLO
	mailgw01.bang-olufsen.dk") by vger.kernel.org with ESMTP
	id <S281603AbRKPWkq>; Fri, 16 Nov 2001 17:40:46 -0500
To: "H . J . Lu" <hjl@lucon.org>
Cc: Kristian Hogsberg <hogsberg@users.sourceforge.net>,
        Andrew Morton <akpm@zip.com.au>, jamesg@filanet.com,
        linux-1394devel@lists.sourceforge.net,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: sbp2.c on SMP
In-Reply-To: <3BEF27D1.7793AE8E@zip.com.au> <3BEF27D1.7793AE8E@zip.com.au>
	<20011113191721.A9276@lucon.org> <3BF21B79.5F188A0D@zip.com.au>
	<20011115193234.A22081@lucon.org>
	<m3snbeofnw.fsf@dk20037170.bang-olufsen.dk>
	<20011116132520.A6204@lucon.org>
From: Kristian Hogsberg <hogsberg@users.sourceforge.net>
Date: 16 Nov 2001 23:40:39 +0100
In-Reply-To: <20011116132520.A6204@lucon.org>
Message-ID: <m3zo5ml4pk.fsf@dk20037170.bang-olufsen.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BeoSmtp/Bang & Olufsen/DK(Release 5.0.6a |January
 17, 2001) at 16-11-2001 23:40:43,
	Serialize by Router on dzln11/Bang & Olufsen/DK(Release 5.0.6 |December 14, 2000) at
 16-11-2001 23:40:38,
	Serialize complete at 16-11-2001 23:40:38
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H . J . Lu" <hjl@lucon.org> writes:

> On Fri, Nov 16, 2001 at 05:15:47PM +0100, Kristian Hogsberg wrote:
> > This is true, but only because the struct list_head is the first
> > element in struct node_entry.  If it wasn't, lh would have been -16 or
> > so, as Andrew says.
> > 
> > In any case, it's the wrong fix, because the error is elsewhere:
> > neither the host_info list or the node list should contain NULL
> > entries.  This is just curing the symptoms.  HJ, could you provide
> > some details on the crash?  Do you have the sbp2 module loaded when
> > you insmod/rmmod ohci1394, and if so, does it crash without sbp2
> > loaded?
> > 
> 
> Found it. You have to use list_for_each_safe when you remove things.
> Here is a patch.

Thanks for looking into this, however these bugs have been fixed in
the cvs version of the drivers, except for the loop in video1394.c
(which wouldn't cause problems, since there's a break immediately
after the call to remove_card).

Kristian

