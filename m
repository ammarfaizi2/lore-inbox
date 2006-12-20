Return-Path: <linux-kernel-owner+w=401wt.eu-S964998AbWLTLcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWLTLcM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 06:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWLTLcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 06:32:12 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:35054 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965000AbWLTLcL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 06:32:11 -0500
Date: Wed, 20 Dec 2006 12:32:07 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Jean Pierre Dion" <jean-pierre.dion@bull.net>
Subject: Re: Fix IPMI watchdog set_param_str() using kstrdup
Message-ID: <20061220123207.4b48af02@frecb000686>
In-Reply-To: <84144f020612200319s748457ccr11f527dd7bca4c96@mail.gmail.com>
References: <20061220120544.36fdf518@frecb000686>
	<84144f020612200319s748457ccr11f527dd7bca4c96@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/12/2006 12:39:50,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/12/2006 12:39:51,
	Serialize complete at 20/12/2006 12:39:51
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 13:19:09 +0200 "Pekka Enberg" <penberg@cs.helsinki.fi> wrote:

> On 12/20/06, Sébastien Dugué <sebastien.dugue@bull.net> wrote:
> >   set_param_str() cannot use kstrdup() to duplicate the parameter. That's
> > fine when the driver is compiled as a module but it sure is not when
> > built into the kernel as the kernel parameters are parsed before the
> > kmalloc slabs are setup.
> 
> Aah. I wonder though, if we could defer parsing driver parameters
> until kmalloc caches are up...

  From a general point of view, why not. Except that for the
watchdog case, I want it to start as soon as possible for it to be
able to reboot in case of an early crash.

  Sébastien.
