Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbUL3Tx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbUL3Tx4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 14:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUL3Tx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 14:53:56 -0500
Received: from imap.gmx.net ([213.165.64.20]:41151 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261705AbUL3Txw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 14:53:52 -0500
X-Authenticated: #116626
From: Alexander Kern <alex.kern@gmx.de>
To: Stas Sergeev <stsp@aknet.ru>
Subject: Re: bug: cd-rom autoclose no longer works (fix attempt)
Date: Thu, 30 Dec 2004 20:52:57 +0100
User-Agent: KMail/1.7.2
Cc: Linux kernel <linux-kernel@vger.kernel.org>
References: <200412301853.48677.alex.kern@gmx.de> <41D4483C.9030005@aknet.ru>
In-Reply-To: <41D4483C.9030005@aknet.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200412302053.00850.alex.kern@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 30. Dezember 2004 19:26 schrieb Stas Sergeev:
> Hello.
Hello,
>
> Alexander Kern wrote:
> >> The ide-cd.c change is as per 2.4.20
> >> which works. For some reasons
> >> sense.ascq == 0 for me when the tray
> >> is opened.
> >
> > ascq = 0 is legal.
> > According to mmc3r10g
> > asc 3a
> > ascq 0 is MEDIUM NOT PRESENT
> > ascq 1 is MEDIUM NOT PRESENT - TRAY CLOSED
> > ascq 2 is MEDIUM NOT PRESENT - TRAY OPEN
> > What in my eyes means, your drive is impossible to determine is tray open
> > or closed.
>
> I think so too, this is the problem most
> likely. However, my cd-roms are not that
> ancient, I expect there are millions of
> the like ones around. Breaking autoclose
> for all of them after it worked for ages,
> is no good IMO.
>
Can agree with you, but a modern cdrom should be able to konwn, is it open or 
not. This patch change basic behaviour for all cdroms.
> > Linux assumes if not known tray is closed. That is better default, it
> > avoids infinate trying to close.
>
> I don't think so. It is safe to assume the
> tray is opened, at least it worked in the
> past (or were there the real problems with
> this?) You can always try to close it only
> once, and if that still returns 0, then
> bail out. One extra closing attempt should
> not do any harm I suppose. That's exactly
> what my patch does (I hope). And that's most
> likely how it used to work before. I'll be
> disappointed if autoclose will remain broken -
> it was the very usefull feature, it will be
> missed. Unless there are the real technical
> reasons against the old behaviour, of course.
Old behaviour has another problems, and revert to 2.4.20 code base is a bad 
solution. I have nothing against changing the default.
The patch must be minimal...
         
	if (sense.sense_key == NOT_READY) {
               if (sense.asc == 0x3a) {
-                        if (sense.ascq == 0 || sense.ascq == 1)
+                        if (sense.ascq == 1)
                                return CDS_NO_DISC;
-                        else if (sense.ascq == 2)
+                        else if (sense.ascq == 0 || sense.ascq == 2)
                                return CDS_TRAY_OPEN;
                }
         }

Regards Alex

P.S. S Novym Godom!
