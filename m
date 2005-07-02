Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVGBUN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVGBUN7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 16:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVGBUN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 16:13:59 -0400
Received: from nome.ca ([65.61.200.81]:44008 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S261274AbVGBUN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 16:13:57 -0400
Date: Sat, 2 Jul 2005 13:13:58 -0700
From: Mike Bell <mike@mikebell.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: updating kernel to 2.6.13-rc1 from 2.6.12 + CONFIG_DEVFS_FS + empty /dev
Message-ID: <20050702201356.GA32409@mikebell.org>
Mail-Followup-To: Mike Bell <mike@mikebell.org>,
	Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
References: <42C30CBC.5030704@free.fr> <20050629224040.GB18462@kroah.com> <1120137161.42c3efc93b36c@imp1-q.free.fr> <20050630155453.GA6828@kroah.com> <42C455C1.30503@free.fr> <20050702053711.GA5635@kroah.com> <42C640AC.1020602@free.fr> <20050702082218.GM8907@alpha.home.local> <42C659B2.8010002@free.fr> <20050702100349.GA25749@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050702100349.GA25749@alpha.home.local>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2005 at 12:03:49PM +0200, Willy Tarreau wrote:
> They cost almost nothing, and in all cases, far less than the required code
> to autodetect them.

I beg to differ on that. As ndevfs has shown, the code required to
create a device node from kernel space is actually very minimal, when
you utilize all the infrastructure already available to you in the
kernel. libfs has most of what you need, the rest is easily stolen from
ramfs. Almost undoubtebly much less than all those device nodes,
especially when you consider the need to be able to perform chown/chmod
on nodes (thus they can't be stored in the read-only flash image, but
must instead be created at each boot on a kernel-generated filesystem
like ramfs)

devfs not utilizing it is perfectly explainable by the fact none of it
was around way back when devfs was created. Back then kernel generated
filesystems were proc, proc and proc. proc is pretty ugly too.
