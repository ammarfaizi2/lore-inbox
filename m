Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267566AbTBRCr4>; Mon, 17 Feb 2003 21:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267568AbTBRCr4>; Mon, 17 Feb 2003 21:47:56 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:1727 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267566AbTBRCrz>; Mon, 17 Feb 2003 21:47:55 -0500
Date: Mon, 17 Feb 2003 20:57:53 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Louis Zhuang <louis.zhuang@linux.co.intel.com>
cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI code cleanup
In-Reply-To: <1045535218.1018.0.camel@hawk.sh.intel.com>
Message-ID: <Pine.LNX.4.44.0302172055060.5217-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Feb 2003, Louis Zhuang wrote:

> The patch clean up some old-style usage of list_head. Pls apply if you
> like it. Thanks

> ===== drivers/pci/probe.c 1.26 vs edited =====
> -- 1.26/drivers/pci/probe.c     Mon Jan 13 11:44:26 2003
> +++ edited/drivers/pci/probe.c  Tue Feb 18 09:28:40 2003
> @@ -533,7 +533,7 @@
>  {
>         const struct list_head *l;
> 
> -       for(l=list->next; l != list; l = l->next) {
> +       list_for_each(l, list) {
>                 const struct pci_bus *b = pci_bus_b(l);
>                 if (b->number == nr || pci_bus_exists(&b->children, nr))
>                         return 1;

Well, if you're changing that anyway, you could as well use

{
	const struct pci_bus *b;

	list_for_each_entry(b, list) {
		if (b->number ...

which looks even nicer ;-)

--Kai


