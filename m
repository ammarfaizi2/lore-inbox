Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263167AbUF0P2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbUF0P2o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 11:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbUF0P2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 11:28:44 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35335 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S263167AbUF0P2m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 11:28:42 -0400
Date: Sun, 27 Jun 2004 11:28:42 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
cc: Pete Zaitcev <zaitcev@redhat.com>, <greg@kroah.com>, <arjanv@redhat.com>,
       <jgarzik@redhat.com>, <tburke@redhat.com>,
       <linux-kernel@vger.kernel.org>, <david-b@pacbell.net>,
       <oliver@neukum.org>
Subject: Re: drivers/block/ub.c
In-Reply-To: <20040627053545.GE10113@one-eyed-alien.net>
Message-ID: <Pine.LNX.4.44L0.0406271123270.10357-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jun 2004, Matthew Dharm wrote:

> > I agree that the debug logging in usb-storage is not good.  A worthwhile
> > improvement would be to log only commands that fail or get an error, with
> > the logging selected by the normal USB debugging (not usb-storage verbose
> > debugging) configuration option.  Matt, what do you think?
> 
> This is an acknowledged weak point of usb-storage.
> 
> A 'log only on error' system might be good... but it's going to be a bit
> tricky for two reasons:
> 
> 1) We have to keep data around longer than currently, so we can log it if
> something goes wrong later (so we see how we got to this point).

Yep.  I just wonder if logging only the current command will be enough.  
Sometimes it's important to see what other, successful commands preceded 
the one that didn't work.  Well, we can always fall back on the old 
verbose debugging.

> 2) What counts as an error?  We probably only want this to kick in when the
> SCSI error-recovery does.  Normal 'failed commands' probably shouldn't
> count.

An error is any time the transport routine returns TRANSPORT_ERROR or the 
command is aborted by the SCSI layer.  We should also log SCSI-initiated 
resets, but not the auto-resets for the Bulk-only protocol.

Alan Stern

