Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUBYNRC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 08:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbUBYNRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 08:17:02 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:55568 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261316AbUBYNQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 08:16:58 -0500
Date: Wed, 25 Feb 2004 13:16:40 +0000
From: "'Christoph Hellwig'" <hch@infradead.org>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: "'Arjan van de Ven'" <arjanv@redhat.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'matt_domsch@dell.com'" <matt_domsch@dell.com>,
       "'Paul Wagland'" <paul@wagland.net>, Matthew Wilcox <willy@debian.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [SUBJECT CHANGE]: megaraid unified driver version 2.20.0.0-alpha1
Message-ID: <20040225131640.A3966@infradead.org>
Mail-Followup-To: 'Christoph Hellwig' <hch@infradead.org>,
	"Mukker, Atul" <Atulm@lsil.com>,
	'Arjan van de Ven' <arjanv@redhat.com>,
	'James Bottomley' <James.Bottomley@SteelEye.com>,
	"'matt_domsch@dell.com'" <matt_domsch@dell.com>,
	'Paul Wagland' <paul@wagland.net>,
	Matthew Wilcox <willy@debian.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC3E2@exa-atlanta.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BC3E2@exa-atlanta.se.lsil.com>; from Atulm@lsil.com on Tue, Feb 24, 2004 at 07:34:01PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 07:34:01PM -0500, Mukker, Atul wrote:
> 1.	Support for upcoming MPT *RAID* controllers. These are not the
> currently in kernel fusion-mpt controllers we are talking about.

given that they are completely different from the controller we know
as megaraid today this is an extremly bad idea.  Just put it into an driver
of their own, e.g. mptraid

> 2.	Controller and device re-ordering on both lk 2.4 and lk 2.6. If this
> is not desired, the driver code would be modified to make it PCI ordered
> detection. The driver also re-orders the drives, based on which one is
> chosen as boot drive. Matt, please add your comments here.

This is a bad thing for 2.6, don't do it.  For 2.4 just leave the probe code as
it is there currently - any change during the stable series just confuses
users.

> 4.	Native hot-plug support for both lk 2.4 and lk 2.6

hotplug scsi in 2.4 is impossible without a host template per controller
which you don't seem to do and I'd advice against.

> 6.	Single code to support *all* x86-32, IA64, and x86-64 platforms

Umm, it's a PCI card - if it doesn't work on any PCI supporting architecture
it's a driver bug (either in your driver or the architectures PCI subsysyem)

> 7.	Exports physical devices on their actual addresses instead 2.10.1
> scheme of exporting logical drives first and than exporting physical devices
> on virtual channels.

While this makes sense it's not a change that should go into 2.4 anymore
as it changes existing setups

