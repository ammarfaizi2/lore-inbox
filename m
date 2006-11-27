Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758541AbWK0T4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758541AbWK0T4E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 14:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758542AbWK0T4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 14:56:03 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:30279 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1758541AbWK0T4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 14:56:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W+vdXng5VTwmhzmCW4eRuSeiteaCD476Zpb2eRb/yVt/A3x1lQsOYS2IDA7R6dgotFLUhVSeHXPraKSdBKEcbG0m4chcFrptE4KSBNTyGIjhxLrlEF5qSOvRpa5AA5+8CdkeUXIlBtH/JVG1gtsrAbSf7uJDcUeR8IA9SA0cvw0=
Message-ID: <a4e6962a0611271155q55adf6fftd489de84d6ae7e88@mail.gmail.com>
Date: Mon, 27 Nov 2006 13:55:58 -0600
From: "Eric Van Hensbergen" <ericvh@gmail.com>
To: "bert hubert" <bert.hubert@netherlabs.nl>, dm-devel@redhat.com,
       ming@acis.ufl.edu, "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] dm-cache: block level disk cache target for device mapper
In-Reply-To: <20061127184748.GA11219@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611271826.kARIQYRi032717@hera.kernel.org>
	 <20061127184748.GA11219@outpost.ds9a.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/06, bert hubert <bert.hubert@netherlabs.nl> wrote:
> On Mon, Nov 27, 2006 at 06:26:34PM +0000, Eric Van Hensbergen wrote:
> > This is the first cut of a device-mapper target which provides a write-back
> > or write-through block cache.  It is intended to be used in conjunction with
> > remote block devices such as iSCSI or ATA-over-Ethernet, particularly in
> > cluster situations.
>
> How does this work in practice? In other words, what is a typical actual
> configuration?
>
> There is a remote block device, and a local one, and these are kept into
> sync in some way?
>

That's the basic idea.  In our testbed, we had a single iSCSI server
exporting block devices to several clients -- each maintaining their
own local disk cache of the server exported block devices.  You can
configured either write-through or write-back policies -- write-back
has better performance, but somewhat obvious consistency issues in
failure cases.

The original intent was to combine this with the dm-cow target (which
I posted a few hours before the dm-cache patch) to provide a scalable
cluster deployment system based on back-end iSCSI or ATA-over-Ethernet
storage.

          -eric
