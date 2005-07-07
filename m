Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVGGQtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVGGQtY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 12:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVGGQrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 12:47:21 -0400
Received: from nproxy.gmail.com ([64.233.182.206]:34414 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261486AbVGGQqT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 12:46:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ckx6PCrWASOE1N7Q/iTSY+eUaFNGn+ykzjnZkhkOYXztBNlU5A+oY8+gWvmma97+u4d7+Zg9FshdggZm3JzMu5du/PPnoqq1TssqWt6nvd21g8da323NiivLzk5hVj0I3NoULv7QtVIQD23UvHsGRfe2VzWEUGr/KwqKOLgqlog=
Message-ID: <58cb370e05070709461d9a6d9c@mail.gmail.com>
Date: Thu, 7 Jul 2005 18:46:18 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Christoph Lameter <christoph@lameter.com>
Subject: Re: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
Cc: Andi Kleen <ak@suse.de>, linux-ide@vger.kernel.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0507070930220.5875@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050706133052.GF21330@wotan.suse.de>
	 <Pine.LNX.4.62.0507070912140.27066@graphe.net>
	 <20050707162442.GI21330@wotan.suse.de>
	 <Pine.LNX.4.62.0507070930220.5875@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/05, Christoph Lameter <christoph@lameter.com> wrote:
> On Thu, 7 Jul 2005, Andi Kleen wrote:
> 
> > On Thu, Jul 07, 2005 at 09:21:55AM -0700, Christoph Lameter wrote:
> > > On Wed, 6 Jul 2005, Andi Kleen wrote:
> > >
> > > > Without this patch a dual Xeon EM64T machine would oops on boot
> > > > because the hwif pointer here was NULL. I also added a check for
> > > > pci_dev because it's doubtful that all IDE devices have pci_devs.
> > >
> > > Here is IMHO the right way to fix this. Test for the hwif != NULL and
> > > test for pci_dev != NULL before determining the node number of the pci
> > > bus that the device is connected to. Maybe we need a hwif_to_node for ide
> > > drivers that is also able to determine the locality of other hardware?
> >
> > Hmm? Where is the difference?
> 
> node = -1 if the node cannot be determined.
> 
> > This is 100% equivalent to my code except that you compressed
> > it all into a single expression.
> 
> My patch consistently checks for hwif != NULL and pci_dev != NULL.
> There was someother stuff in your patch. This patch does not add any
> additional variables and is more readable.

seconded but hwif != NULL still just hides some other issue

* hwifs and drives are not allocated dynamically
* drive->hwif is initialized to hwif for every hwif very early in the
driver initialization
