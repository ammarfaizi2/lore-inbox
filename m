Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbTKNAhB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 19:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264476AbTKNAhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 19:37:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14607 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261802AbTKNAhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 19:37:00 -0500
Message-ID: <3FB4238A.40605@zytor.com>
Date: Thu, 13 Nov 2003 16:36:26 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: OT: why no file copy() libc/syscall ??
References: <1068512710.722.161.camel@cube> <20031111133859.GA11115@bitwizard.nl> <20031111085323.M8854@devserv.devel.redhat.com> <bp0p5m$lke$1@cesium.transmeta.com> <20031113233915.GO1649@x30.random>
In-Reply-To: <20031113233915.GO1649@x30.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> I actually hacked cp for a while and it improved cp some point percent
> on normal machines.
> 
> See ftp://ftp.suse.com/pub/people/andrea/cp-sendfile/
> 
> the main downside and the reason it wasn't applied IIRC is the lack of
> interruption of sendfile, basically for an huge file it would take a
> while before C^c has any effect. The kernel isn't interrupting the
> syscall.  This is no different from a huge read or write syscall (but
> read/write are never huge or the buffer would need to be huge too, not
> the case for sendfile that works zerocopy), so in theory we could
> workaround it by entering/exiting kernel multiple times just to allow
> the signal to be handled like in the read/write case.

... or we could put in checks into the kernel for signal pending, and
return EINTR.

	-hpa

