Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUFEIr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUFEIr5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 04:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264572AbUFEIr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 04:47:57 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:8131 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S266045AbUFEIqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 04:46:54 -0400
Subject: Re: jff2 filesystem in vanilla
From: David Woodhouse <dwmw2@infradead.org>
To: Daniel Egger <de@axiros.com>
Cc: cijoml@volny.cz, linux-kernel@vger.kernel.org
In-Reply-To: <3F4B6D09-B6CA-11D8-B781-000A958E35DC@axiros.com>
References: <200406041000.41147.cijoml@volny.cz>
	 <F84CE3DA-B605-11D8-B781-000A958E35DC@axiros.com>
	 <1086390590.4588.70.camel@imladris.demon.co.uk>
	 <3F4B6D09-B6CA-11D8-B781-000A958E35DC@axiros.com>
Content-Type: text/plain
Message-Id: <1086425211.4588.88.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sat, 05 Jun 2004 09:46:51 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-05 at 10:27 +0200, Daniel Egger wrote:
> The original version in the 2.4 kernel has a dramatic problem
> leading to FS corruption, at least when used with blkmtd on CF.
> That's why I'm using 2.4 and a CVS snapshot, not only because
> it is much faster.

Can you be more specific? I don't know of any such problems. If they
exist, they give me a potential excuse to update 2.4 to the current code
-- but to be honest I'd rather just leave it in maintenance mode.

> Believe it or not but JFFS2 is the only filesystem that works
> reasonably on CF, especially when the system is used mostly read
> only and the device is cut off from power every now and then. ;)

CF is bog-roll technology. I wouldn't want to use it in production even
with JFFS2 on it -- but at least when it gets confused you'll only lose
a limited amount of data with JFFS2.

If you're going to use JFFS2 on CF, you should really investigate using
the write-buffer we implemented for NAND flash, but without the ECC
parts. It'll mean you write each CF sector once rather than overwriting
the sector each time you add a few bytes to the log.

-- 
dwmw2


