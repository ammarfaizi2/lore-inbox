Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264854AbTFVLPo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 07:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264888AbTFVLPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 07:15:44 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39372
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264854AbTFVLPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 07:15:42 -0400
Subject: Re: [2.5 patch] remove an unused function from wd7000.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
In-Reply-To: <20030622000538.GM23337@fs.tum.de>
References: <20030622000538.GM23337@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056281197.2075.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Jun 2003 12:26:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-22 at 01:05, Adrian Bunk wrote:
> The patch below removes an unused function from drivers/scsi/wd7000.c .
> 
> I've tested the compilation with 2.5.72-mm2.

What you actually need to do for wd7000 is to make that a new_eh abort
handler. The card every so often loses an IRQ (or we do something that
upsets it - who knows). In that situation we fake an IRQ event which
causes the card to recover and life to continue happily.

Providing you hold the lock all will then untangle.

