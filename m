Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289359AbSA1Tnp>; Mon, 28 Jan 2002 14:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289341AbSA1Tng>; Mon, 28 Jan 2002 14:43:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34577 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289370AbSA1TnS>; Mon, 28 Jan 2002 14:43:18 -0500
Message-ID: <3C55A9CA.5050105@zytor.com>
Date: Mon, 28 Jan 2002 11:43:06 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: frank.van.maarseveen@altium.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: restoring hard linked files from zisofs/iso9660 w. RR
In-Reply-To: <20020125135545.A28897@espoo.tasking.nl> <a2s67d$8s0$1@cesium.transmeta.com> <20020128170704.A2632@espoo.tasking.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay... I have successfully reproduced this bug.  It's definitely a Linux
kernel bug -- mkisofs correctly puts file numbers (inode numbers) in the
PX Rock Ridge entries.

Unfortunately it is a pretty deep decision in the Linux isofs that the
inode number is the offset of the directory entry; isofs pretty much needs
to be rewritten to be dentry-centric rather than inode-centric on order to
resolve this.  Note that dentry-centric operation is the sane thing for
something like isofs, so this wouldn't be a bad idea.

Unfortunately, that doesn't solve all problems: there is no structure to
the inode numbers provided in the PX entries, and there is the potential
for collision when used on a disc which is only partially RockRidge (which
is legal.)  This has to be taken into account, and all of these things
have to be done without reading the whole disc first...

	-hpa

