Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271394AbTGQKbp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 06:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271395AbTGQKbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 06:31:45 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:3857 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S271394AbTGQKbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 06:31:43 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Date: Thu, 17 Jul 2003 10:46:35 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bf5uqb$3ei$1@news.cistron.nl>
References: <20030716184609.GA1913@kroah.com> <20030717014410.A2026@pclin040.win.tue.nl> <20030716164917.2a7a46f4.akpm@osdl.org> <20030717122600.A2302@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1058438795 3538 62.216.29.200 (17 Jul 2003 10:46:35 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030717122600.A2302@pclin040.win.tue.nl>,
Andries Brouwer  <aebr@win.tue.nl> wrote:
>There are many filesystems that only have room for 32 bits.
>For example, NFSv2 has "unsigned int rdev".
>So, the kernel must be able to handle 32-bit device numbers.
>
>Now about the encoding - nobody knows. This NFS filesystem was mounted
>from a FreeBSD system. It is encoded 16+8+8 with the middle 8 the major.
>Or, no, it was Solaris or Irix. Encoded 14+18. Etc.
>
>In the case of NFSv2 there is an unknown system on the other side.

So put the translation of 32 bits rdev to 32:32 in the NFS client.
Provide a mount-time option "rdev-encoding=14:18", with symbolic
names for often-used encodings: "rdev-encoding=solaris". Done.
You can do this on the NFS server side as well.. per-client,
even.  If anyone still cares for NFSv2, that is.

Same goes for other filesystems, though a dynamic translation will
not be nessecary. But the filesystem driver itself
must convert from native rdev to linux 32:32.

Mike.

