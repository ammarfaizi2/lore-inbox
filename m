Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbULVCGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbULVCGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 21:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbULVCGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 21:06:15 -0500
Received: from pop.gmx.net ([213.165.64.20]:43979 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261939AbULVCGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 21:06:10 -0500
X-Authenticated: #21910825
Message-ID: <41C8D689.3020502@gmx.net>
Date: Wed, 22 Dec 2004 03:06:01 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: acpi-devel@lists.sourceforge.net
CC: Matthias Hentges <mailinglisten@hentges.net>,
       Oliver Dawid <od@fet.uni-hannover.de>,
       =?ISO-8859-1?Q?Stefan_D=F6singer?= <stefandoesinger@gmx.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: Samsung P35 and S3 suspend
References: <41BFC3AD.5030001@gmx.net> <1103117333.5924.3.camel@mhcln03>	 <41C07B6F.70900@gmx.net> <1103159022.5924.17.camel@mhcln03> <41C0FFF3.4010902@gmx.net> <41C19BD8.7050201@gmx.net> <41C1CFA2.20304@gmx.net>
In-Reply-To: <41C1CFA2.20304@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:

> OK, I got S3 working with all kernels since 2.6.9 (well, your
> patches had to be modified slightly). Right now I'm running on the
> latest Linus -bk tree.
>
> I will now try other configurations and a full bootup.
>
> OK, it is working perfectly with the latest Linus -bk tree and
> everything configured in (SuSE .config, comparable to allmodconfig).

It turns out that (at least for 2.6.10-rc3 and later) the kernel
resumes from S3 perfectly regardless of .config as long as
- no framebuffer console is activated (kernel param video=vesa:off )
- pci-resume-2.6.10.patch and resume-finish-split-2.6.10.patch
  are applied
- suspend and resume happen with an active TEXT console (chvt 2)
- VESA registers are saved before suspend
- the radeon card is POSTed after resume
- the VESA registers are restored after that
- now you are free to change back to X if you want.

You do NOT need
- a patched X server
- a special kernel .config
- sacrifices of any kind.

See my other mail to acpi-devel for details about how to save/restore
the VESA registers and POST the card.

Question for the framebuffer experts: Is it possible to forbid access
to the video card after resume until the card has been POSTed and all
registers are restored? Any access to the card before that will freeze
the machine.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
