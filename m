Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTGVOHV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 10:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270775AbTGVOHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 10:07:21 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:36857 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262955AbTGVOHU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 10:07:20 -0400
Subject: Re: [Patch] Non-ASCII chars in visor.c messages
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Jan Kasprzak <kas@informatics.muni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030722125039.GA2310@kroah.com>
References: <20030722143821.C26218@fi.muni.cz>
	 <20030722125039.GA2310@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058883388.2751.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Jul 2003 15:16:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-22 at 13:50, Greg KH wrote:
> > 	The visor.c module contains three messages
> > with non-ASCII character ("e" with acute above, encoded in
> > ISO 8859-1, in the name of "Sony Clie'" handheld). I propose the attached
> > patch, which works in all environments (altough UTF-8 variant would be
> > IMHO fine as well).
> > 
> > 	What do you think about it?
> 
> I don't think it's really needed.  Why change this, syslog can't handle
> this?  It works for me...

Current syslog has problems handling it. These problems are a lot worse
than they appear too. Since the file system encoding is UTF-8 for file
naming the syslog daemon is sometimes logging kernel file path objects
which are unicode utf-8 format. 

The highbit corrupted characters in the C files (as well as being iffy
C) causes problems we just don't need. 

It doens't really matter if we pick UTF-8 (which does mean things like
names can be handled ok) or plain 7bit ascii C locale but we need to
pick something.

