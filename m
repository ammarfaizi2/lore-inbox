Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbTEHEyG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 00:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbTEHEyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 00:54:06 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:1554 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261171AbTEHEyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 00:54:05 -0400
Date: Thu, 8 May 2003 06:06:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: chas williams <chas@locutus.cmf.nrl.navy.mil>, davem@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [ATM] [PATCH] unbalanced exit path in Forerunner HE he_init_one()
Message-ID: <20030508060640.A24325@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Francois Romieu <romieu@fr.zoreil.com>,
	chas williams <chas@locutus.cmf.nrl.navy.mil>, davem@redhat.com,
	linux-kernel@vger.kernel.org
References: <200305071813.h47IDpc9010906@hera.kernel.org> <20030508010146.A20715@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030508010146.A20715@electric-eye.fr.zoreil.com>; from romieu@fr.zoreil.com on Thu, May 08, 2003 at 01:01:46AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 01:01:46AM +0200, Francois Romieu wrote:
>  #if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,43)
> -	if (pci_enable_device(pci_dev)) return -EIO;
> +	if (pci_enable_device(pci_dev))
> +		goto out;
>  #endif

Btw, this driver badly wants a cleanup of the ifdef mess.  Look
at some network drivers on how to support older kenrels nicely
wiþh not much more than a compat layer header instead of spreading
ifdefs all over the place.  Who reviewed this driver before
inclusion?

