Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUJVRLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUJVRLx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 13:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269184AbUJVREo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:04:44 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:40053 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S271419AbUJVQ6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 12:58:33 -0400
From: tabris <tabris@tabris.net>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: DVD/ide-cd related Oops 2.6.[89]-mm
Date: Fri, 22 Oct 2004 12:45:23 -0400
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>
References: <20041022090145.GA6408@tabriel.tabris.net> <58cb370e04102207351d79c481@mail.gmail.com>
In-Reply-To: <58cb370e04102207351d79c481@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jkTeBc0dpGp5eq3"
Message-Id: <200410221245.23693.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_jkTeBc0dpGp5eq3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 22 October 2004 10:35 am, Bartlomiej Zolnierkiewicz wrote:
> On Fri, 22 Oct 2004 05:01:45 -0400, Tabris <tabris@tabris.net> wrote:
> >         undecoded slave fixup is a oneliner patch in ide-probe to
> > recognize both of my Maxtor drives that appear to have the same
> > serial number, D3000000. This fix was discussed a month ago or so,
> > as I had run into it, but nothing official came of it, and it was
> > never merged to -mm.
>
> Did you test it on different controller (as asked by Eric)?
>
> > Patch attached.
>
> thanks, I'll apply it
	Patch attached with a comment. Possibly not necessary, but as it's a 
fixup, probably should anyway.
>
> Bartlomiej

--
tabris
-
Some people only open up to tell you that they're closed.

--Boundary-00=_jkTeBc0dpGp5eq3
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ide-probe+undecoded_slave-Maxtor-fixup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ide-probe+undecoded_slave-Maxtor-fixup.diff"

Signed-off by tabris@tabris.net

--- ide-probe.c~	2004-10-22 12:40:41.366608575 -0400
+++ ide-probe.c	2004-10-22 12:41:40.789111900 -0400
@@ -730,6 +730,8 @@ static void probe_hwif(ide_hwif_t *hwif)
 			    /* And beware of confused Maxtor drives that go "M0000000000"
 			      "The SN# is garbage in the ID block..." [Eric] */
 			    strncmp(drive->id->serial_no, "M0000000000000000000", 20) &&
+			    /* Same goes for another set of Maxtor drives that say "D3000000" */
+			    strncmp(drive->id->serial_no, "D3000000", 8) &&
 			    strncmp(hwif->drives[0].id->serial_no, drive->id->serial_no, 20) == 0) {
 				printk(KERN_WARNING "ide-probe: ignoring undecoded slave\n");
 				drive->present = 0;

--Boundary-00=_jkTeBc0dpGp5eq3--
