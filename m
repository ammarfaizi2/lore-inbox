Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVDCE2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVDCE2i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 23:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVDCE2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 23:28:38 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:24009 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261290AbVDCE2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 23:28:32 -0500
Subject: Re: iomapping a big endian area
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: matthew@wil.cx, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050402200858.37347bec.davem@davemloft.net>
References: <1112475134.5786.29.camel@mulgrave>
	 <20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk>
	 <20050402183805.20a0cf49.davem@davemloft.net>
	 <20050403031000.GC24234@parcelfarce.linux.theplanet.co.uk>
	 <1112499639.5786.34.camel@mulgrave>
	 <20050402200858.37347bec.davem@davemloft.net>
Content-Type: text/plain
Date: Sat, 02 Apr 2005 22:27:57 -0600
Message-Id: <1112502477.5786.38.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-02 at 20:08 -0800, David S. Miller wrote:
> > Did anyone have a preference for the API?  I was thinking
> > ioread32_native, but ioread32be is fine too.
> 
> I think doing foo{be,le}{8,16,32}() would be consistent with
> our byteorder.h interface names.

Thinking about this some more, I know of no case of a BE bus connected
to a LE system, nor do I think anyone would ever create such a beast, so
our only missing interface is for a BE bus on a BE system.

Thus, I think io{read,write}{16,32}_native are better interfaces ...
they basically mean pass memory operations without byte swaps, so
they're well defined on both BE and LE systems and correspond exactly to
our existing _raw_{read,write}{w,l} calls (principle of least surprise).

James


