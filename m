Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbTEFPid (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbTEFPid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:38:33 -0400
Received: from vicar.dcs.qmul.ac.uk ([138.37.88.163]:34705 "EHLO
	mail.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP id S263875AbTEFPi0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:38:26 -0400
Date: Tue, 6 May 2003 16:50:52 +0100 (BST)
From: Matt Bernstein <mb--lkml@dcs.qmul.ac.uk>
To: Andi Kleen <ak@muc.de>
cc: Andrew Morton <akpm@digeo.com>, elenstev@mesatop.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.68-mm4
In-Reply-To: <20030506143533.GA22907@averell>
Message-ID: <Pine.LNX.4.55.0305061641360.3237@r2-pc.dcs.qmul.ac.uk>
References: <1051905879.2166.34.camel@spc9.esa.lanl.gov>
 <20030502133405.57207c48.akpm@digeo.com> <1051908541.2166.40.camel@spc9.esa.lanl.gov>
 <20030502140508.02d13449.akpm@digeo.com> <1051910420.2166.55.camel@spc9.esa.lanl.gov>
 <Pine.LNX.4.55.0305030014130.1304@jester.mews> <20030502164159.4434e5f1.akpm@digeo.com>
 <20030503025307.GB1541@averell> <Pine.LNX.4.55.0305030800140.1304@jester.mews>
 <Pine.LNX.4.55.0305061511020.3237@r2-pc.dcs.qmul.ac.uk> <20030506143533.GA22907@averell>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-uvscan-result: clean (19D4iS-0002me-OS)
X-Auth-User: jonquil.thebachchoir.org.uk
X-uvscan-result: clean (19D4iW-000068-7K)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 16:35 +0200 Andi Kleen wrote:

>On Tue, May 06, 2003 at 04:15:55PM +0200, Matt Bernstein wrote:
>> Is this helpful?
>
>What I really need is an probably decoded with ksymoops oops, not jpegs.

OK, I'll do this tomorrow morning (I think I can do it without a serial 
console now).

>Also you seem to be the only one with the problem so just to avoid
>any weird build problems do a make distclean and rebuild from scratch
>and reinstall the modules.

The only odd thing I think I'm doing is hacking this into rc.sysinit:

awk '/version 2\.5\./ {exit 1}' /proc/version || egrep -v '^#' /etc/sysconfig/modules | while read i
do
        action $"Loading $i module: " /sbin/modprobe $i
done

This might be naughty, but it shouldn't be able to hang the box!

I'd prefer to have a proper set of aliases for 2.5 in /etc/modules.conf,
but I'm too lazy to google for one. Also, I'd prefer yet more to shunt
this stuff into an initramfs but I'll wait for documentation to appear for
that :)

Cheers,

Matt
