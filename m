Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265396AbUGNTcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265396AbUGNTcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 15:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbUGNTcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 15:32:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26576 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265396AbUGNTcA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 15:32:00 -0400
Message-ID: <40F58A20.1090807@pobox.com>
Date: Wed, 14 Jul 2004 15:31:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Ingram <ingram@symsys.com>
CC: linux-kernel@vger.kernel.org, tiwai@suse.de,
       Jaroslav Kysela <perex@suse.cz>
Subject: Re: via82xx.c vs. sonypi.c i/o region conflict on vaio
References: <Pine.LNX.4.44.0407141230550.25786-100000@maestro.symsys.com>
In-Reply-To: <Pine.LNX.4.44.0407141230550.25786-100000@maestro.symsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Ingram wrote:
> I modified the sound driver to grab only 128 ports instead of 256 and the
> driver works fine on this hardware.  In 2.6.7, it's line 2049 or so of
> sound/pci/via82xx.c:
> 
> old:	if ((chip->res_port = request_region(chip->port, 256, card->driver)) == NULL) {
> new:	if ((chip->res_port = request_region(chip->port, 256, card->driver)) == NULL) {


I don't see any difference between these two lines.

Regardless, I see two bugs:

1) Hardcoding 256 for resource size.  Should be using pci_resource_len()

2) via82xx sound driver should be using pci_request_regions() and 
pci_release_regions(), not request_region.  Doing this eliminates issue #1.

	Jeff



