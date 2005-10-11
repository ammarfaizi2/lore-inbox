Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVJKXLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVJKXLf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 19:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVJKXLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 19:11:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:45747 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932072AbVJKXLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 19:11:35 -0400
Date: Tue, 11 Oct 2005 16:10:54 -0700
From: Greg KH <greg@kroah.com>
To: Harald Welte <laforge@gnumonks.org>
Cc: Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Sergey Vlasov <vsu@altlinux.ru>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, security@linux.kernel.org,
       vendor-sec@lst.de
Subject: Re: [vendor-sec] Re: [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20051011231054.GA16315@kroah.com>
References: <Pine.LNX.4.58.0509270959380.3308@g5.osdl.org> <20050930104749.GN4168@sunbeam.de.gnumonks.org> <Pine.LNX.4.64.0509300752530.3378@g5.osdl.org> <20050930184433.GF16352@shell0.pdx.osdl.net> <Pine.LNX.4.64.0509301225190.3378@g5.osdl.org> <20050930220808.GE4168@sunbeam.de.gnumonks.org> <Pine.LNX.4.64.0509301514190.3378@g5.osdl.org> <20051010174429.GH5627@rama> <20051010180745.GT5856@shell0.pdx.osdl.net> <20051011094550.GI4290@rama>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051011094550.GI4290@rama>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2005 at 11:45:51AM +0200, Harald Welte wrote:
> On Mon, Oct 10, 2005 at 11:07:45AM -0700, Chris Wright wrote:
> > * Harald Welte (laforge@gnumonks.org) wrote:
> > > diff --git a/kernel/signal.c b/kernel/signal.c
> > > --- a/kernel/signal.c
> > > +++ b/kernel/signal.c
> > > @@ -1193,6 +1193,40 @@ kill_proc_info(int sig, struct siginfo *
> > >  	return error;
> > >  }
> > >  
> > > +/* like kill_proc_info(), but doesn't use uid/euid of "current" */
> > 
> > Maybe additional comment reminding that you most likely don't want this
> > interface.
> > 
> > Also, looks like there's same issue again:
> 
> Mh, didn't hit that bug since I don't use disconnect signals.  But it
> looks like it has the same issue.
> 
> Please consider the patch below, it
> 
> 1) changes pid_t to uid_t
> 2) exports the symbol
> 3) adresses the same task_struct referencing issue for disconnect
>    signals
> 
> I hope this now finally is the last take ;)

Ugh, but it looks like Linus already committed your previous patch, with
some changes by him.  Care to send a delta from what is currently in his
tree (2.6.14-rc4 has it) and this patch?

thanks,

greg k-h
