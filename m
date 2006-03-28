Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWC1Gl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWC1Gl5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 01:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWC1Gl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 01:41:56 -0500
Received: from pproxy.gmail.com ([64.233.166.182]:37592 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932238AbWC1Gl4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 01:41:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eK8Cht3mvOKQaeCYccW4EvB0yA1Ch1Xkk2aUIFytKLfFhzC+dAydGOkY4ye7e2CZHvsjp6u1NSU2W/X58gwWMVC7uhHesYbWulFrmDedzJKMvBEsbwEBAOnzBnCJpg/VEkFjs4TSILg905PIFgaQPiWNYWq0+eYLp0Mg+wq4r90=
Message-ID: <aec7e5c30603272241n5c07aa0csd52b237aaaeb30d6@mail.gmail.com>
Date: Tue, 28 Mar 2006 15:41:53 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Sergei Organov" <s.organov@javad.com>
Subject: Re: Lifetime of flash memory
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Artem B. Bityutskiy" <dedekind@yandex.ru>, linux@horizon.com,
       kalin@thinrope.net, linux-kernel@vger.kernel.org
In-Reply-To: <87acbb6vlj.fsf@javad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060326162100.9204.qmail@science.horizon.com>
	 <4426C320.9010002@yandex.ru>
	 <20060327161845.GA16775@csclub.uwaterloo.ca>
	 <Pine.LNX.4.61.0603271242100.16721@chaos.analogic.com>
	 <87acbb6vlj.fsf@javad.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/06, Sergei Organov <s.organov@javad.com> wrote:
> "linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:
> > Note that the actual block size is usually 64k, not the 512 bytes of a
> > 'sector'. Apparently, some of the data-space on each block is used for
> > relocation and logical-to-physical mapping.
>
> Wrong. AFAIK, first disks had FLASH with 512b blocks, then next
> generation had 16K blocks, and currently most of cards have 128K
> blocks. Besides, each page of a block (64 pages * 2K for 128K block) has
> additional "system" area of 64 bytes. One thing that is in the system
> area is bad block indicator (2 bytes) to mark some blocks as bad on
> factory, and the rest could be used by application[1] the same way the
> rest of the page is used. So physical block size is in fact 64 * (2048 +
> 64) = 135168 bytes.

Doesn't this depend on if we are talking about NOR or NAND memory? It
looks like you are describing some kind of NAND memory. Also I guess
it varies with manufacturer.

When it comes to CF the internal block size doesn't really matter
because the CF controller will hide it for you. The controller will
perform some kind of mapping between the 512 byte based IDE-interface
and it's internal sector size. This together with wear levelling.

The quality of the wear levelling will probably vary, but I guess even
the most primitive brands have something to cope with the fact that
the blocks containing the FAT are often rewritten on FAT filesystems.

/ magnus
