Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbWEKPkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWEKPkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 11:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWEKPkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 11:40:45 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51097 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030278AbWEKPkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 11:40:45 -0400
Subject: Re: [PATCH] ide_cs: Make ide_cs work with the memory space of
	CF-Cards if IO space is not available
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Thomas Kleffel (maintech GmbH)" <tk@maintech.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44629D10.80803@maintech.de>
References: <44629D10.80803@maintech.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 11 May 2006 16:52:58 +0100
Message-Id: <1147362779.26130.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-05-11 at 04:10 +0200, Thomas Kleffel (maintech GmbH) wrote:
> From: Thomas Kleffel <tk@maintech.de>
> 
> this patch enables ide_cs to access CF-cards via their common memory
> rather than via their IO space.

One obvious problem. Your patch simply sets io_base to an ioremap value.
The ide_cs code assumes port accesses (eg it does outb() on base + 2).
While outb() may happen to work on ARM on ioremap returns it doesn't on
most platforms.

Alan

