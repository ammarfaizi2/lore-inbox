Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272528AbTHERCZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 13:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272948AbTHEQ7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:59:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14822 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272924AbTHEQ70
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:59:26 -0400
Date: Tue, 5 Aug 2003 17:59:24 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: RO --bind mount implementation ...
Message-ID: <20030805165924.GF12757@parcelfarce.linux.theplanet.co.uk>
References: <20030804221615.GA18521@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030804221615.GA18521@www.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 12:16:15AM +0200, Herbert Pötzl wrote:
 
> anyway, I discussed this with some friends, and
> they pointed out that this would be useful ...
> so here is the first try ...

Umm...  You know, the most obvious system call that should care about
read-only is open(pathname, O_RDWR) ;-)  IOW, taking care of directory
modifications is not enough - you need to deal with
	* opening file for write
	* truncation (both from *truncate() and from open() with O_TRUNC)
	* metadata changes (timestamps, ownership, permissions)

But yes, it's not that far from where we should eventualy get.
