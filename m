Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269672AbUINWXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269672AbUINWXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 18:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269581AbUINWUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 18:20:48 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:41055 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267945AbUINWT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 18:19:27 -0400
Message-ID: <9ae345c004091415197ea06621@mail.gmail.com>
Date: Wed, 15 Sep 2004 01:19:26 +0300
From: Yuval Turgeman <yuvalt@gmail.com>
Reply-To: Yuval Turgeman <yuvalt@gmail.com>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] Menuconfig search changes - pt. 3
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0409141613050.877@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040914121401.GA13531@aduva.com>
	 <Pine.LNX.4.61.0409141613050.877@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 19:53:26 +0200 (CEST), Roman Zippel
<zippel@linux-m68k.org> wrote:
> Hi,
> 
> On Tue, 14 Sep 2004, Yuval Turgeman wrote:
> 
> > +static int regex_match(const char *string, regex_t *re)
> > +{
> > +     int rc;
> > +
> > +     rc = regexec(re, string, (size_t) 0, NULL, 0);
> > +     if (rc)
> > +             return 0;
> > +     return 1;
> > +}
> 
> I guess, this doesn't has to be a separate function anymore.

Ok.

> > +static void show_expr(struct menu *menu, FILE *fp)
> > +{
> > +     bool hit = false;
> > +     fprintf(fp, "Depends:\n ");
> > +     if (menu->prompt->visible.expr) {
> > +             if (!hit)
> > +                     hit = true;
> > +             expr_fprint(menu->prompt->visible.expr, fp);
> > +     }
> > +     if (!hit)
> > +             fprintf(fp, "None");
> > +     if (menu->sym) {
> > +             struct property *prop;
> > +             hit = false;
> > +             fprintf(fp, "\nSelects:\n ");
> > +             for_all_properties(menu->sym, prop, P_SELECT) {
> > +                     if (!hit)
> > +                             hit = true;
> > +                     expr_fprint(prop->expr, fp);
> > +             }
> > +             if (!hit)
> > +                     fprintf(fp, "None");
> > +             hit = false;
> > +             fprintf(fp, "\nSelected by:\n ");
> > +             if (menu->sym->rev_dep.expr) {
> > +                     hit = true;
> > +                     expr_fprint(menu->sym->rev_dep.expr, fp);
> > +             }
> > +             if (!hit)
> > +                     fprintf(fp, "None");
> > +     }
> > +}
> 
> This still prints duplicate information, look at how
> ConfigMainWindow::setHelp() in qconf.cc does it. Your function should have
> pretty much the same structure, e.g.

I don't understand - duplicate information of what ?
Can you perhaps give me an example (it seems to me that i am actually
doing what qconf is doing... printing all the P_SELECT of the all the
properties, printing the dependencies and the reverse dependencies) ?

> > +     for_all_symbols(i, sym) {
> > +             if (!sym->name)
> > +                     continue;
> > +             if (!regex_match(sym->name, &re))
> > +                     continue;
> > +             for_all_prompts(sym, prop) {
> 
> here you should iterate over all properties and print the info about it.

The search prints out plenty of info already - what info do you think
is missing ?

> 
> > +     if (!hit)
> > +             fprintf(fp, "No matches found.");
> 
> You could print the number of found symbols here.

Ok.

> 
> >               stat = exec_conf();
> > +             if (stat == 26) {
> 
> Move this into the switch part a few lines below and simply use the next
> available number. For this you need to print the currently selected
> symbol and the search string from lxdialog, this way you also return to
> the same previously selected symbol after exiting the search.

Ok (although if I remember correctly it does return to selected symbol)

Thanks,
Yuval.
