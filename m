Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268468AbUJUPNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268468AbUJUPNc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270718AbUJUPNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 11:13:00 -0400
Received: from smtpq2.home.nl ([213.51.128.197]:27541 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S270747AbUJUPKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:10:08 -0400
Date: Thu, 21 Oct 2004 17:10:05 +0200
From: Han Boetes <han@mijncomputer.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.6.9-ac1: invalid SUBLEVEL
Message-ID: <20041021151026.GP9258@boetes.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1098356892.17052.18.camel@localhost.localdomain> <20041021124945.GD10801@stusta.de> <1098365506.17096.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098365506.17096.23.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2004-10-21 at 13:49, Adrian Bunk wrote:
> >  VERSION = 2
> >  PATCHLEVEL = 6
> > -SUBLEVEL = 9-ac1
> > -EXTRAVERSION =
> > +SUBLEVEL = 9
> > +EXTRAVERSION = -ac1
> >  NAME=AC 1
>
> Doh I'm -amazed- that worked for me. Fixed in my tree

Here is some old shell-code I wrote for my kernel updating script: It
was especially written because you tend to forget this.

test_version () {
    # Sometimes Alan forgets to update the EXTRAVERSION in the Makefile;
    # then you destroy the previous version and the script fails :S
    cd $pwd/linux-$latest_stable
    # if EXTRAVERSION is for mm but not the current one.
    if [ -z "$(grep "EXTRAVERSION = -$mm_rest" Makefile)" \
        -a -z "$(grep "EXTRAVERSION = .*mm" Makefile)" ]; then
        warning 'Warning: I had to edit the versionnumber in the Makefile!'
        grep "EXTRAVERSION =" Makefile
        perl -pi -e "s#^EXTRAVERSION.*\n#EXTRAVERSION = -$mm_rest\n#" \
            Makefile || error
        grep "EXTRAVERSION =" Makefile
    fi
}

> I'll go and hide in a corner for a bit.

I think it is a better idea you add some checks to the script you use to
generate that patch.



# Han
