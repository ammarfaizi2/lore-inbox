Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbWHONp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWHONp1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 09:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbWHONp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 09:45:27 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:4922 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030288AbWHONp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 09:45:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=WVQHD9uNp0a2aRImPiElbgi9bMYaKfkhtqMDQ62Atxoc2GRRZfrHcZ5W9kuVPbUWmInNBzUGQiC/2UfXH7iywWbxm6y/ssT/8DIraSBlOOzY5tJ033+uNMpML+H+7jpaIBxE7UpMTd2uugVObZ++/d5RQoH2ZLtd+QMkNdxt8OY=
Subject: Re: Oops on suspend
From: "Antonino A. Daplas" <adaplas@gmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <200608151512.49265.rjw@sisk.pl>
References: <1155603152.3948.4.camel@daplas.org>
	 <200608151153.03441.rjw@sisk.pl> <1155646570.4181.2.camel@daplas.org>
	 <200608151512.49265.rjw@sisk.pl>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 21:45:08 +0800
Message-Id: <1155649508.3448.1.camel@daplas.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 15:12 +0200, Rafael J. Wysocki wrote:
> On Tuesday 15 August 2006 14:56, Antonino A. Daplas wrote:
> > On Tue, 2006-08-15 at 11:53 +0200, Rafael J. Wysocki wrote:
> > > On Tuesday 15 August 2006 02:52, Antonino A. Daplas wrote:
> > > > Anyone see this oops on suspend to disk? Copied by hand only.
> > > > 
> > > > EIP is at swap_type_of
> > > > 
> > > > swsusp_write
> > > > pm_suspend_disk
> > > > enter_state
> > > > state_store
> > > > subsys_attr_store
> > > > sysfs_write_file
> > > > vfs_write
> > > > sys_write
> > > > sysenter_past_EIP
> > > > 
> > > > openSUSE-10.2-Alpha3 (2.6.18-rc4), but I see this also with stock
> > > > 2.6.18-rc4-mm1.
> > > 
> > > Are there two swap partitions on your system?  Is any of them on an LVM?
> > 
> > I have two swap partitions, /dev/hda3 and /dev/hdc1. resume=/dev/hdc1.
> > 
> > If both partitions are mounted, suspend fails with a message of "cannot
> > determined swap partition", or something to that effect.
> > 
> > If I do swapoff /dev/hda3, then suspend to disk, I get the oops.
> > 
> > No LVM.
> > 
> > I'll try removing /dev/hda3 and try again. Hold on...

Removing the extra swap partition worked.

> 
> OK
> 
> Could you please try the patch I posted earlier today
> (http://marc.theaimsgroup.com/?l=linux-kernel&m=115563697203025&q=raw)?
> 

This patch worked too with my original setup. Thanks :-)

Tony


