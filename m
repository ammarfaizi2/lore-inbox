Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753753AbWKRIG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753AbWKRIG0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 03:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753755AbWKRIGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 03:06:25 -0500
Received: from cantor2.suse.de ([195.135.220.15]:44731 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1753738AbWKRIGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 03:06:25 -0500
From: Andi Kleen <ak@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 20/20] x86_64: Move CPU verification code to common file
Date: Sat, 18 Nov 2006 09:06:21 +0100
User-Agent: KMail/1.9.5
Cc: Oleg Verych <olecom@flower.upol.cz>, LKML <linux-kernel@vger.kernel.org>,
       vgoyal@in.ibm.com, akpm@osdl.org, rjw@sisk.pl, ebiederm@xmission.com,
       Reloc Kernel List <fastboot@lists.osdl.org>, pavel@suse.cz,
       magnus.damm@gmail.com
References: <20061117223432.GA15449@in.ibm.com> <20061118070101.GA14673@flower.upol.cz> <455EAF54.5090500@zytor.com>
In-Reply-To: <455EAF54.5090500@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611180906.21340.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> However, this test should probably be pushed earlier, into setup.S, 
> where executing a BIOS-clean reboot is much easier.

It's already in there in fact. It wasn't originally, until we discovered
that there is no way to output a message in head.S when you're
using vesafb. The only way to give a visible error is to do it 
before the video switched.

The old test was kept, although it's redundant.

This means Vivek/Eric added it now to the SMP trampoline and ACPI
S3 resume too, but there it is technically redundant too.

But you have to spin, otherwise the user cannot see what is wrong
(and that is much more important than your obscure possibility
of automatic fallback -- inserting the wrong CD is pretty common) 

Finding panic=.. would require writing a command line parser in 16bit assembly.
I have my doubts that's a good use of anyone's time.

-Andi (who wonders why he wastes so much time writing about this thing) 
