Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263324AbUFJXTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbUFJXTd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 19:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbUFJXTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 19:19:33 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:39578 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263324AbUFJXTa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 19:19:30 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Lars <terraformers@gmx.net>
Subject: Re: 2.6.7-rc3: nforce2, no C1 disconnect fixup applied
Date: Fri, 11 Jun 2004 01:23:36 +0200
User-Agent: KMail/1.5.3
References: <ca9jj9$dr$1@sea.gmane.org> <200406110035.48711.bzolnier@elka.pw.edu.pl> <caap8q$m51$1@sea.gmane.org>
In-Reply-To: <caap8q$m51$1@sea.gmane.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406110123.36981.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 of June 2004 01:01, Lars wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Friday 11 of June 2004 00:19, Lars wrote:
> >> just learned that
> >> setpci -H1 -s 0:0.0 6C.L=0x9F01FF01
> >> enables C1 *and* the 80ns stability fix.
> >>
> >> looks like i have to stick with my ugly little workaround for a while
> >
> > "ugly"?
>
> just kiddin' ;)
>
> > We can probably change kernel fixup to always do & 0x9F01FF01
> > but adding "force C1HD" kernel options sounds insane.
>
> i guess that always applying 0x9F01FF01 will force c1 for all users
> to *on* again, because the 9F value triggers this.
> its my understanding that
> 0x9F01FF01 enables c1 and fix
> 0x0F01FF01 disables c1, enables fix
> 0x0F0FFF01 disables c1 and fix
>
> am i right ?

Yes but doing & should always give the right result:
0x0F0FFF01 & 0x9F01FF01 -> 0x0F01FF01
(disabled -> disabled + fix)
0x9F0FFF01 & 0x9F01FF01 -> 0x9F01FF01
(enabled -> enabled + fix)
...

