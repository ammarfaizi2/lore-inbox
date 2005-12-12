Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbVLLLUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVLLLUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 06:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbVLLLUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 06:20:36 -0500
Received: from w241.dkm.cz ([62.24.88.241]:50145 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751234AbVLLLUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 06:20:35 -0500
Date: Mon, 12 Dec 2005 12:20:33 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Kurt Wall <kwallinator@gmail.com>
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org, sam@ravnborg.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/3] [kconfig] Direct use of lxdialog routines by menuconfig
Message-ID: <20051212112033.GB8025@pasky.or.cz>
References: <20051212004159.31263.89669.stgit@machine.or.cz> <20051212004606.31263.37616.stgit@machine.or.cz> <200512112218.27286.kwallinator@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512112218.27286.kwallinator@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Dec 12, 2005 at 04:18:26AM CET, I got a letter
where Kurt Wall <kwallinator@gmail.com> said that...
> On Sunday 11 December 2005 07:46 pm, Petr Baudis wrote:
> > After three years, the zombie walks again!  This patch (against the latest
> > git tree) cleans up interaction between kconfig's mconf (menuconfig
> > frontend) and lxdialog. Its commandline interface disappears in this patch,
> > instead a .so is packed from the lxdialog objects and the relevant
> > functions are called directly from mconf.
> 
> > @@ -808,18 +684,22 @@ static void conf(struct menu *menu)
> >     }
> >     break;
> >    case 4:
> > -   if (type == 't')
> > +   if (active_type == 't')
> >      sym_set_tristate_value(sym, no);
> >     break;
> >    case 5:
> > -   if (type == 't')
> > +   if (active_type == 't')
> >      sym_set_tristate_value(sym, mod);
> >     break;
> >    case 6:
> > -   if (type == 't')
> > +   if (active_type == 't') {
> >      sym_toggle_tristate_value(sym);
> > -   else if (type == 'm')
> > -    conf(submenu);
> > +   } else if (active_type == 'm') {
> > +    if (single_menu_mode)
> > +     submenu->data = (void *) !submenu->data;
> 
> Shouldn't this be:
>      submenu->data = (void *) (long) !submenu->data;

You are right, it should be so at least for consistency - it'll be fixed
in the next resend of the patch. I can't see why is it needed, though -
shouldn't the int be padded to void* anyway?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
