Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316693AbSE0Vr6>; Mon, 27 May 2002 17:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316766AbSE0Vr4>; Mon, 27 May 2002 17:47:56 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:31986 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316693AbSE0Vrw>; Mon, 27 May 2002 17:47:52 -0400
Subject: Re: Memory management in Kernel 2.4.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020527173306.C15560@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 May 2002 23:50:31 +0100
Message-Id: <1022539831.4123.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 22:33, Benjamin LaHaise wrote:
> On Mon, May 27, 2002 at 02:22:22PM -0700, H. Peter Anvin wrote:
> > Well, if you can't fork a new process because that would push you into
> > overcommit, then you usually can't actually do anything useful on the
> > machine.
> 
> Just use vfork or clone + exec.  It's faster and uses less memory.

In the general case a fork doesn't cause too much overcommit. Most of
the binary is mapped read-only as is a lot of the library space. Since
its read only and backed by a file it has zero cost. If you mprotect it
then you pay at mprotect time

