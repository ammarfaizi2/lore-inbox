Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbQJ0Ov2>; Fri, 27 Oct 2000 10:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129094AbQJ0OvR>; Fri, 27 Oct 2000 10:51:17 -0400
Received: from [64.64.109.142] ([64.64.109.142]:35346 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S129077AbQJ0OvH>; Fri, 27 Oct 2000 10:51:07 -0400
Message-ID: <39F995E8.FE7324BA@didntduck.org>
Date: Fri, 27 Oct 2000 10:49:12 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick van de Lageweg <patrick@bitwizard.nl>
CC: Andrew Morton <andrewm@uow.edu.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>,
        Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PROPOSED PATCH] ATM refcount + firestream
In-Reply-To: <Pine.LNX.4.21.0010271631330.16544-100000@panoramix.bitwizard.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick van de Lageweg wrote:
> 
> On Fri, 27 Oct 2000, Andrew Morton wrote:
> 
> > Patrick van de Lageweg wrote:
> > >
> > > Hi all,
> > >
> > > Here is the second try for the atm refcount problem. I've made made
> > > several enhancement over the previos patch. Can you take a look at it if
> > > I've missed anything? (This time it also includes the driver for the
> > > firestream card. That's why the patch is so large. It's gziped and
> > > uuencoded).
> >
> > Patrick, I looked at the modules stuff and you do not
> > appear to be actually _using_ it anywhere:
> >
> > bix:/home/morton> grep owner patch
> > +  owner:       THIS_MODULE,
> > +       owner:          THIS_MODULE
> > +       owner:          THIS_MODULE,
> > +       owner:        THIS_MODULE,
> > +  owner:       THIS_MODULE,
> > +       owner:          THIS_MODULE,
> > +   owner:      THIS_MODULE,
> > +       struct module *owner;
> > +       struct module *owner;
> > bix:/home/morton>
> 
> We use it throught the fops_get/fops_put macros to in/decrease the mod
> counter. See the definitions for those macros (include/linux/fs.h)
> 
>         Patrick

This will break horribly if fops_put/get are changed to inlines instead
of macros.  They are only supposed to be used on struct file_operations.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
