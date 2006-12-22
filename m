Return-Path: <linux-kernel-owner+w=401wt.eu-S1945964AbWLVIH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945964AbWLVIH0 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 03:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945965AbWLVIH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 03:07:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:59620 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945964AbWLVIHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 03:07:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=NNkZTf8gkJKsobpiwpJj+sWBLD2LrUtHF5/Gn0IfCMaBE4HWm9BYAchyDGpxwQrJP5NrXERzJm1yCRfU7x47csCFoQTT+JGcgR7EKrFJTIm0wJyNm5zC334Rnm6VbeRGsyNwIOaGK+NXPOZ+Hyp3EA95Yli6aowySChSSXurKQY=
Date: Fri, 22 Dec 2006 08:05:39 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] ptrace: make {put,get}reg work again for gs and fs
Message-ID: <20061222080539.GE18827@slug>
References: <20061214225913.3338f677.akpm@osdl.org> <20061221183518.GA18827@slug> <458ADEDD.8010903@goop.org> <20061221215942.GC18827@slug> <458B3C51.4030905@goop.org> <20061221181108.6cede9ba.akpm@osdl.org> <20061222060618.GD18827@slug> <20061221225414.de09c7df.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221225414.de09c7df.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 10:54:14PM -0800, Andrew Morton wrote:
> On Fri, 22 Dec 2006 06:06:18 +0000
> Frederik Deweerdt <deweerdt@free.fr> wrote:
> 
> > On Thu, Dec 21, 2006 at 06:11:08PM -0800, Andrew Morton wrote:
> > > On Thu, 21 Dec 2006 18:00:49 -0800
> > > Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> > > 
> > > > Frederik Deweerdt wrote:
> > > > > This is a -mm1 kernel + your efl_offset fix + the attached patch.
> > > > > So the problem came from putreg still saving %gs to the stack where
> > > > > there's no slot for it, whereas getreg got things right.
> > > > >   
> > > > 
> > > > That patch looks good, but I think it is already effectively in Andrew's
> > > > queue, because I noticed some problems in there when I reviewed  the
> > > > convert-to-%fs patch.
> > > > 
> > > 
> > > The below is what I have queued for urgent mainlining to address these
> > > problems.
> > > 
> > > Is it sufficient?
> > > 
> > No, it's not. The patch below fixes the place where we get eflags, this
> > triggered the "BUG while gdb'ing" reports.
> > The one I sent was to fix a problem that only I reported, AFAIK: when
> > you use gdb/ptrace to modify %fs, the value gets written in the wrong
> > place (see gdb sessions). So, unless you have another patch fixing the
> > way putreg() writes %fs, the patch[1] I sent should also be queued for
> > mainline.
> 
> OK, but you're using -mm, yes?  And -mm has (the rather irritating)
> convert-i386-pda-code-to-use-%fs.patch in it.
> 
> So perhaps your fix is a -mm-only thing?
> 
It is sorry, I mixed things up. BTW, your mails don't seem to make it to
the lkml (see http://lkml.org/lkml/2006/12/22/10)

Regards,
Frederik
