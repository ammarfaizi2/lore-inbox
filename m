Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWAFMqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWAFMqH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 07:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWAFMqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 07:46:07 -0500
Received: from natfrord.rzone.de ([81.169.145.161]:5784 "EHLO
	natfrord.rzone.de") by vger.kernel.org with ESMTP id S1751343AbWAFMqG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 07:46:06 -0500
From: Stefan Rompf <stefan@loplof.de>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: State of the Union: Wireless
Date: Fri, 6 Jan 2006 13:48:05 +0100
User-Agent: KMail/1.8
Cc: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20060106042218.GA18974@havoc.gtf.org> <1136547084.4037.41.camel@localhost> <20060106114620.GA23707@isilmar.linta.de>
In-Reply-To: <20060106114620.GA23707@isilmar.linta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601061348.05803.stefan@loplof.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag 06 Januar 2006 12:46 schrieb Dominik Brodowski:

> From someone who has no idea at all (yet) about 802.11: why character
> device, and not sysfs or configfs files? Like

sysfs shares the main problem with wireless extensions: It configures one 
value per file / per ioctl. Setting up a wireless card to associate or form 
an IBSS network consists of multiple parameters, many requiring the card to 
disasscociate.

With hardware like prism2 usb that gets "don't touch me now mode" for a while 
after a join command is issued, current API requires a driver to delay 
starting an association in order to wait if other config requests are issued 
- an ugly hack.

I vote for netlink. It's a defined and tested interface and has all features 
needed to set multiple values in one transaction.

Stefan
